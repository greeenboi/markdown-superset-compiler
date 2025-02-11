require_relative 'lib/generator'
require_relative 'lib/parser'
require_relative 'lib/tokenizer'


# ----------------- Nodes ----------------- #

Token = Struct.new(:type, :value)
BoldNode = Struct.new(:value)
ItalicsNode = Struct.new(:value)
NewlineNode = Struct.new(:value)
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
puts "Tokens Recognized"
tokens.each do |token|
  puts token
end

parser = Parser.new(tokens)
node_tree = parser.parse
puts "Node Tree"
node_tree.each do |node|
  puts node
end

generator = Generator.new.generate_all(node_tree)
puts generator