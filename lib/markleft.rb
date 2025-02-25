# frozen_string_literal: true

require "cli/ui"
require "fileutils"
require_relative "markleft/version"
require 'optparse'

module Markleft
  # ----------------- Tokenizer Module ----------------- #
  class Tokenizer
    TOKEN_TYPES = [
      [:heading1, /^# .+/],
      [:heading2, /^## .+/],
      [:heading3, /^### .+/],
      [:heading4, /^#### .+/],
      [:heading5, /^##### .+/],
      [:heading6, /^###### .+/],
      [:strikethrough, /((?<!\s)~~(?!\s)(?:[^~]+?|(?:[^~]*(?:(?:~[^~]*){2})+?)+?)(?<!\s)~~)/],
      [:bold, /((?<!\s)\*\*(?!\s)(?:[^*]+?|(?:[^*]*(?:(?:\*[^*]*){2})+?)+?)(?<!\s)\*\*)/],
      [:italics, /((?<!\s)\*(?!\s)(?:(?:[^**]*(?:(?:\*\*[^**]*){2})+?)+?|[^**]+?)(?<!\s)\*)/],
      [:newline, /(\r\n|\r|\n)/],
      [:text, /[^*\n\r]+/]
    ].freeze

    def initialize(markleft)
      @code = markleft
    end

    def tokenize
      tokens = []
      until @code.empty?
        tokens << tokenize_one_token
        @code = @code.strip
      end
      tokens
    end

    def tokenize_one_token
      TOKEN_TYPES.each do |type, re|
        re = /\A(#{re})/
        next unless @code =~ re

        value = ::Regexp.last_match(1)
        @code = @code[value.length..]
        return Token.new(type, value)
      end
      raise "Unexpected character #{@code.inspect}"
    end
  end

  # ----------------- Parser Module ----------------- #

  class Parser
    def initialize(tokens)
      @tokens = tokens
    end

    def parse
      nodes = []
      nodes << parse_node until @tokens.empty?
      nodes
    end

    def parse_node
      case @tokens.first.type
      when :bold
        parse_bold
      when :italics
        parse_italics
      when :newline
        parse_newline
      when :text
        parse_text
      when :heading1
        parse_heading(1)
      when :heading2
        parse_heading(2)
      when :heading3
        parse_heading(3)
      when :heading4
        parse_heading(4)
      when :heading5
        parse_heading(5)
      when :heading6
        parse_heading(6)
      when :strikethrough
        parse_strikethrough
      else
        raise "Unexpected token type: #{@tokens.first.type}"
      end
    end

    def parse_bold
      value = consume(:bold).value
      BoldNode.new(value)
    end

    def parse_italics
      value = consume(:italics).value
      ItalicsNode.new(value)
    end

    def parse_newline
      consume(:newline)
      NewlineNode.new
    end

    def parse_heading(level)
      consume(:"heading#{level}")
      HeadingNode.new("Heading", level)
    end

    def parse_strikethrough
      value = consume(:strikethrough).value
      StrikethroughNode.new(value)
    end

    def parse_text
      value = consume(:text).value
      TextNode.new(value)
    end

    def consume(expected_type)
      token = @tokens.shift
      unless token.type == expected_type
        raise "Expected token type #{expected_type.inspect} but got #{token.type.inspect}"
      end

      token
    end
  end

  # ----------------- Code Generator Module ----------------- #

  class Generator
    def generate(node)
      case node
      when BoldNode
        generate_bold(node)
      when ItalicsNode
        generate_italics(node)
      when NewlineNode
        generate_newline(node)
      when TextNode
        generate_text(node)
      when HeadingNode
        generate_heading(node)
      when StrikethroughNode
        generate_strikethrough(node)
      else
        raise "Unexpected node type: #{node.class}"
      end
    end

    def generate_bold(node)
      "<b>#{node.value}</b>"
    end

    def generate_italics(node)
      "<i>#{node.value}</i>"
    end

    def generate_newline(_node)
      "<br>"
    end

    def generate_heading(node)
      "<h#{node.level}>#{node.value}</h#{node.level}>"
    end

    def generate_strikethrough(node)
      "<del>#{node.value}</del>"
    end

    def generate_text(node)
      node.value
    end

    def generate_all(nodes)
      nodes.map { |node| generate(node) }.join
    end
  end

  # ----------------- Error handler ----------------- #
  class Error < StandardError; end
  # ----------------- Nodes ----------------- #

  Token = Struct.new(:type, :value)
  BoldNode = Struct.new(:value)
  ItalicsNode = Struct.new(:value)
  NewlineNode = Struct.new(:value)
  TextNode = Struct.new(:value)
  HeadingNode = Struct.new(:value, :level)
  StrikethroughNode = Struct.new(:value)

  # ----------------- Main Block ----------------- #

  CLI::UI::StdoutRouter.enable

  def self.list_md_files
    Dir.glob("*.md")
  end

  def self.select_md_file(files)
    CLI::UI::Prompt.ask("Select a markdown file to process:") do |handler|
      files.each do |file|
        handler.option(file) { file }
      end
    end
  end

  def self.process_file(file_name)
    myfile = File.read(file_name)
    html_content = nil

    CLI::UI::SpinGroup.new do |spin_group|
      spin_group.add("Tokenizing") do |spinner|
        tokenizer = Tokenizer.new(myfile)
        @tokens = tokenizer.tokenize
        spinner.update_title("Tokenizing complete")
      end

      spin_group.add("Parsing") do |spinner|
        parser = Parser.new(@tokens)
        @node_tree = parser.parse
        spinner.update_title("Parsing complete")
      end

      spin_group.add("Generating HTML") do |spinner|
        generator = Generator.new.generate_all(@node_tree)
        html_content = generator
        spinner.update_title("HTML generation complete")
      end
    end.wait

    html_content
  end

  def self.save_html(file_name, content)
    html_file_name = file_name.sub(/\.md$/, ".html")
    File.write(html_file_name, content)
    html_file_name
  end

  CLI::UI::Frame.open("Markleft") do
    puts "Markleft version: #{Markleft::VERSION}"
    puts "Ruby version: #{RUBY_VERSION}"
    puts "Developer: Suvan Gowri Shanker"
    puts "GitHub: https://github.com/greeenboi"

    options = {}
    OptionParser.new do |opts|
      opts.banner = <<~BANNER
        Usage: markleft [options]

        This utility converts Markdown files in the current directory to HTML.
        It provides an interactive UI to select files unless a file is specified.
        Use the following flags for quick access:

      BANNER
      opts.separator ""
      opts.separator "Examples:"
      opts.separator "  markleft --file example.md"
      opts.separator "  markleft --help"
      opts.separator ""
      opts.on("--help", "Show help information") do
        puts opts
        exit
      end
      opts.on("--file FILE", "Specify a markdown file") do |filename|
        options[:file] = filename
      end
    end.parse!

    files = list_md_files
    if files.empty?
      puts "No markdown files found in the current directory."
    else
      selected_file = options[:file] || select_md_file(files)
      puts "Processing file: #{selected_file}"
      html_content = process_file(selected_file)
      puts "Generated HTML content:"
      puts html_content
      saved_file = save_html(selected_file, html_content)
      puts "HTML content saved to: #{saved_file}"
    end
  end
end
