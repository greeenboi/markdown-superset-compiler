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
