# MarkLeft: A Superset to Markdown-to-HTML Compilers

![image](https://github.com/user-attachments/assets/b73b1753-8b48-4036-a0e3-8b1fba47d223)


## Overview

MarkLeft is a powerful and flexible tool designed to extend the capabilities of traditional Markdown-to-HTML compilers. It introduces additional syntax and features to enhance the expressiveness and functionality of Markdown documents.

> [!TIP]
> MarkLeft is a work in progress and is currently under development. Please check back for updates and new features.
> You are still free to use it and contribute to it.


## Features

- **Superfast**: MarkLeft is designed to be fast and efficient, processing Markdown files quickly and generating HTML output in an instant.
- **Extensible**: MarkLeft is highly extensible, allowing users to define custom syntax and features to suit their needs.
- **Customizable**: MarkLeft provides a range of options and settings to customize the output, including themes, styles, and more.(coming soon)

## Prerequisites

- Ruby >~ 3.2.4
- Bundler =2.6.3

## Installation

To install MarkLeft, clone the repository and navigate to the project directory:

#### Gem

```sh
gem install markleft
```

#### Repository

```sh
git clone git@github.com:greeenboi/markdown-superset-compiler.git
cd markdown-superset-compiler
```

## Running the Converter

#### Using Gem

```shell
markleft
```

0r 

```shell
markleft --file <filename>
```

#### Using `markleft-main.rb`

The `markleft-main.rb` file is a simple script that reads a Markdown file, tokenizes it, parses it, and generates HTML output.

1. Run the script:
   ```sh
   ruby lib/markleft.rb
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
