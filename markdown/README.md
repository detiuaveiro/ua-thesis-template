# Writing Your Thesis in Markdown

It is possible to use the UA thesis template with markdown + pandoc.

## File Structure

The `markdown` directory is structured as follows:

```
.
├── content
├── demo.md
├── filters
│   ├── acronyms.py
│   └── pandoc-minted
│       ├── LICENSE
│       ├── pandoc-minted.py
│       └── README.md
├── Makefile
├── metadata.yaml
├── README.md
├── requirements.txt
└── templates
    ├── cover_template.tex
    └── matter_template.tex
```

`content` is where all the markdown files for the thesis will reside.

`demo.md` is a demo file showcasing pandoc's markdown functionality.

`filters` contains the filters in use, see [What is Installed](#what-is-installed) for more details.

`Makefile` contains a couple targets that compile the files in various scenarios. See [Cmake Targets](#cmake-targets) for more details.

`metadata.yaml` is where the template is configured.

`README.md` is this file, containing an overview of how to use pandoc and markdown to write a thesis.

`requirements.txt` contains the python dependencies needed for the filters. See [What is Installed](#what-is-installed) for more details.

`templates` contains modified versions of `matter.tex` and `cover.tex` that allow for customization via yaml configuration.

## Cmake targets

`all` compiles all the markdown files in `content`. To actually compile the thesis please also run `make` in the repository's root directory (or run `make md` from there to do it all in one step).

`install` installs all dependencies. See [Installation](#installation) for more details.

`test` compiles `demo.md`, using it in the thesis template. To actually compile the thesis please also run `make` in the repository's root directory. 

## Installation

In order for the compilation to work, some filters and python dependencies have to be installed.

Please run `make install` inside this directory to create a python virtual environment in this directory under `.venv`

It will be automatically used when compiling the markdown into latex.

### What is installed

Pandoc filters:

- [pandoc-minted](https://github.com/nick-ulle/pandoc-minted), to use `minted` for typesetting, as the template uses.

Python dependencies:

- [pandocfilters](https://pypi.org/project/pandocfilters/), to be able to make python pandoc filters
- [pyyaml](https://pypi.org/project/PyYAML/), to be able to read yaml data for the metadata

## Usage

In order to compile the thesis from markdown into pdf, use `make md` in the repository root.

If you only need to compile the markdown into the latex files, use `make` inside this directory.

Citations are made with inline latex and bibliography is stored in the `/bib` directory

Acronyms are managed by the `acronym` package and wrapped by the `filters.py` filter. In the metadata, place all acronyms under the `acronyms` field in the following format:

```yaml
# Example
- id: <the string to replace in the text>
  short: <the short form to replace the string with>
  long: <the long form to be used in the first occurence>
```

Example:

```yaml
# Every time `ai` is written in the document, replace it with `AI`, or `Artificial Intelligence (AI)` in the first occurence
acronyms:
  - id: ai 
    short: AI
    long: Artificial Intelligence
```
