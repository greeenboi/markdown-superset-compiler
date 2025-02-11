# MarkLeft: A Superset to Markdown-to-HTML Compilers

![image](https://github.com/user-attachments/assets/b73b1753-8b48-4036-a0e3-8b1fba47d223)


## Overview

MarkLeft is a powerful and flexible tool designed to extend the capabilities of traditional Markdown-to-HTML compilers. It introduces additional syntax and features to enhance the expressiveness and functionality of Markdown documents.

## Project Structure

- `Gemfile` and `Gemfile.lock`: Manage gem dependencies.
- `markleft-main.rb`: Script for converting Markdown to HTML.
- `terminal.rb`: TUI for converting Markdown to HTML.
- `lib/`: Contains the tokenizer, parser, and generator classes.

## Features

- **Extended Syntax**: Supports additional formatting options such as bold, italics, and more.
- **Custom Nodes**: Allows the creation of custom nodes to represent different types of content.
- **Tokenization and Parsing**: Efficiently tokenizes and parses Markdown content into a structured node tree.
- **Easy Integration**: Can be easily integrated into existing projects and workflows.

## Prerequisites

- Ruby >~ 3.2.4
- Bundler =2.6.3

## Installation

To install MarkLeft, clone the repository and navigate to the project directory:

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/markdown-to-html.git
   cd markdown-to-html
   ```

2. Install the dependencies:
   ```sh
   bundle install
   ```

## Running the Converter

### Using `markleft-main.rb`

The `markleft-main.rb` file is a simple script that reads a Markdown file, tokenizes it, parses it, and generates HTML output.

1. Run the script:
   ```sh
   ruby markleft-main.rb
   ```

2. Enter the name of the Markdown file when prompted.

### Using `terminal.rb` (TUI)

The `terminal.rb` file provides a Text User Interface (TUI) for selecting and processing Markdown files.

1. Run the script:
   ```sh
   ruby terminal.rb
   ```

2. Follow the prompts to select a Markdown file and process it.



## Example

Given a sample Markdown file `sample.md`:

```markdown
This is a sample *Markdown* file
**bold** yippee!
```

## Contributing

We welcome contributions to enhance MarkLeft. Please fork the repository and submit pull requests with your improvements.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For any questions or feedback, please contact [contact@suvangs.tech](mailto:contact@suvangs.tech).

---
