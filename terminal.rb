require 'cli/ui'
require 'fileutils'

require_relative 'lib/generator'
require_relative 'lib/parser'
require_relative 'lib/tokenizer'

CLI::UI::StdoutRouter.enable

Token = Struct.new(:type, :value)
BoldNode = Struct.new(:value)
ItalicsNode = Struct.new(:value)
NewlineNode = Struct.new(:value)
TextNode = Struct.new(:value)

def list_md_files
  Dir.glob('*.md')
end

def select_md_file(files)
  CLI::UI::Prompt.ask('Select a markdown file to process:') do |handler|
    files.each do |file|
      handler.option(file) { file }
    end
  end
end

def process_file(file_name)
  myfile = File.read(file_name)
  html_content = nil

  CLI::UI::SpinGroup.new do |spin_group|
    spin_group.add('Tokenizing') do |spinner|
      tokenizer = Tokenizer.new(myfile)
      @tokens = tokenizer.tokenize
      spinner.update_title('Tokenizing complete')
    end

    spin_group.add('Parsing') do |spinner|
      parser = Parser.new(@tokens)
      @node_tree = parser.parse
      spinner.update_title('Parsing complete')
    end

    spin_group.add('Generating HTML') do |spinner|
      generator = Generator.new.generate_all(@node_tree)
      html_content = generator
      spinner.update_title('HTML generation complete')
    end
  end.wait

  html_content
end

def save_html(file_name, content)
  html_file_name = file_name.sub(/\.md$/, '.html')
  File.write(html_file_name, content)
  html_file_name
end

CLI::UI::Frame.open('Markdown to HTML Converter') do
  files = list_md_files
  if files.empty?
    puts "No markdown files found in the current directory."
  else
    selected_file = select_md_file(files)
    puts "Processing file: #{selected_file}"
    html_content = process_file(selected_file)
    puts "Generated HTML content:"
    puts html_content
    saved_file = save_html(selected_file, html_content)
    puts "HTML content saved to: #{saved_file}"
  end
end