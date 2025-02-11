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
