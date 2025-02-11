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
    else
      raise RuntimeError.new("Unexpected node type: #{node.class}")
    end
  end

  def generate_bold(node)
    "<b>#{node.value}</b>"
  end

  def generate_italics(node)
    "<i>#{node.value}</i>"
  end

  def generate_newline(node)
    "<br>"
  end

  def generate_text(node)
    node.value
  end

  def generate_all(nodes)
    nodes.map { |node| generate(node) }.join
  end

end
