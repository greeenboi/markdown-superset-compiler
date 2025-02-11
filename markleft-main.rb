# ----------------- Tokenizer Block ----------------- #
class Tokenizer
  TOKEN_TYPES = [
    [:bold, /((?<!\s)\*\*(?!\s)(?:[^\*]+?|(?:[^\*]*(?:(?:\*[^\*]*){2})+?)+?)(?<!\s)\*\*)/],
    [:italics, /((?<!\s)\*(?!\s)(?:(?:[^\*\*]*(?:(?:\*\*[^\*\*]*){2})+?)+?|[^\*\*]+?)(?<!\s)\*)/],
    [:newline, /(\r\n|\r|\n)/],
    [:text, /[^\*\n\r]+/]
  ]

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
      if @code =~ re
        value = $1
        @code = @code[value.length..-1]
        return Token.new(type,value)
      end
    end
    raise RuntimeError.new(
      "Unexpected character #{@code.inspect}"
    )
  end
end

# ----------------- Parser Block ----------------- #
class Parser
  def initialize(tokens)
    @tokens=tokens
  end

  def parse
    nodes = []
    until @tokens.empty?
      nodes << parse_node
    end
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
    else
      raise RuntimeError.new("Unexpected token type: #{@tokens.first.type}")
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

  def parse_text
    value = consume(:text).value
    TextNode.new(value)
  end

  def consume(expected_type)
    token = @tokens.shift
    if token.type == expected_type
      token
    else
      raise RuntimeError.new("Expected token type #{expected_type.inspect} but got #{token.type.inspect}")
    end
  end
end





# ----------------- Nodes ----------------- #

Token = Struct.new(:type, :value)
BoldNode = Struct.new(:value)
ItalicsNode = Struct.new(:value)
NewlineNode = Struct.new
TextNode = Struct.new(:value)

# ----------------- Main Block ----------------- #

puts "Enter the file name"
file_name = gets.chomp.to_s

unless File.exist?(file_name)
  raise RuntimeError.new("#{file_name} not found")
end
myfile = File.read(file_name)
puts myfile

tokenizer = Tokenizer.new(myfile)

tokens = tokenizer.tokenize

tokens.each do |token|
  puts token
end

