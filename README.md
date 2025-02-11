# MarkLeft: A Superset to Markdown-to-HTML Compilers

## Overview

MarkLeft is a powerful and flexible tool designed to extend the capabilities of traditional Markdown-to-HTML compilers. It introduces additional syntax and features to enhance the expressiveness and functionality of Markdown documents.

## Features

- **Extended Syntax**: Supports additional formatting options such as bold, italics, and more.
- **Custom Nodes**: Allows the creation of custom nodes to represent different types of content.
- **Tokenization and Parsing**: Efficiently tokenizes and parses Markdown content into a structured node tree.
- **Easy Integration**: Can be easily integrated into existing projects and workflows.

## Installation

To install MarkLeft, clone the repository and navigate to the project directory:

```sh
git clone https://github.com/yourusername/markleft.git
cd markleft
```

## Usage

1. **Prepare Your Markdown File**: Create a Markdown file with the content you want to convert.

2. **Run MarkLeft**: Use the provided Ruby script to tokenize and parse your Markdown file.

```sh
ruby markleft-main.rb
```

3. **View the Output**: The script will output the tokens and the node tree, representing the structure of your Markdown content.

## Example

Given a sample Markdown file `sample.md`:

```markdown
This is a sample *Markdown* file
**bold** yippee!
```

Running MarkLeft will produce the following output:

```
Tokens Recognized
#<struct Token type=:text, value="This is a sample ">
#<struct Token type=:italics, value="*Markdown*">
#<struct Token type=:text, value=" file">
#<struct Token type=:newline, value="\n">
#<struct Token type=:bold, value="**bold**">
#<struct Token type=:text, value=" yippee!">

Node Tree
#<struct TextNode value="This is a sample ">
#<struct ItalicsNode value="*Markdown*">
#<struct TextNode value=" file">
#<struct NewlineNode>
#<struct BoldNode value="**bold**">
#<struct TextNode value=" yippee!">
```

## Contributing

We welcome contributions to enhance MarkLeft. Please fork the repository and submit pull requests with your improvements.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For any questions or feedback, please contact [contact@suvangs.tech](mailto:contact@suvangs.tech).

---

MarkLeft: Extending Markdown to new heights!