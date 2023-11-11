# Writing Your Thesis in Markdown

It is possible to use the UA thesis template with markdown + pandoc.

## File Structure

## Installation

In order for the filters to work, some filters and python dependencies have to be installed.

Please run `make install` inside this directory to create a python virtual environment in this directory under `.venv`

It will be automatically used when compiling the markdown into latex.

### What is installed

Pandoc filters:

[pandoc-minted](https://github.com/nick-ulle/pandoc-minted), to use `minted` for typesetting, as the template uses.

Python dependencies:

[pandocfilters](https://pypi.org/project/pandocfilters/), to be able to make python pandoc filters
[pyyaml](https://pypi.org/project/PyYAML/), to be able to read yaml data for the metadata

## Usage

In order to compile the thesis from markdown into pdf, use `make md` in the repository root.

If you only need to compile the markdown into the latex files, use `make` inside this directory.
