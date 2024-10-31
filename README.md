# University of Aveiro Thesis Template

A thesis LaTeX template that complies with the University of Aveiro's
guidelines and provides a simple CLI workflow around `make` that was developed
and tested for cross-compatibility on Linux (Slackware, ArchLinux, Debian, Ubuntu) and macOS.

This template was developed by professors and students. 
We will try to keep up to date with thesis requirements but some discrepancies may exist.
Feel free to open issues and pull requests with new options, packages and fixes.

## Usage

Optional: In debian and ubuntu you can install all dependencies automatically:

```
make setup
```

Build a development version of the document:

```
make [build]
```

Continuously build the development version of the document:

```
make preview
```

This option is great when paired with a document viewer (such as Okular) which
automatically reloads the document on file change. This means you can keep
writing and on save the updated document is compiled and displayed!

Build versions of the document for publishing:

```
make print
make ebook
```

Run linters (for now only [proselint](http://proselint.com/)) against a TeX
file (e.g. chapter 1):

```
make lint [texfile=chapter1.tex]
```

If you do not specify the `texfile` to lint, then all TeX files in `chapters/`
will be linted.

Clean the build directory:

```
make clean[all]
```

`clean` will leave the output products (the PDFs) in place, while `cleanall`
will remove these too. If your document is not compiling for some reason and
you think you've already solved the problem in the LaTeX sources, maybe try a
`cleanall` before insisting. Sometimes the underlying build programs (namely
`latexmk`) get stuck in inconsistent temporary files.


Compile it from markdown using pandoc:

```
make md
```

`md` will compile all the markdown files inside `/markdown/content/`, merged alphabetically, into a two latex files that **will overwrite** `cover.tex` and `matter.tex`.
After this, the `build` target will run.
For more information please read `/markdown/README.md`

## How to use the template

This is all great, but how can this repository be used as a starting point for
writing your own thesis?

In our opinion you have mostly three options:
- Download/clone the repository and copy *all* files to a directory of your
  desire, for instance to inside some special folder within you own thesis
  repository.  
  Notice that this will not allow you to easily keep up with this template
  should it change.
- Fork the repository to your own and work there. If you want to include it
  within your own thesis repository, you can use `git submodules` for this.
- Use `git subtree` to pull this repository to your main thesis repository and
  work directly there. Changes in your copy will be versioned by your main
  thesis repo, while you will still be able to pull new updates from here
  should they appear.

The last of these options mas be the most adquate, as it seems to be the most flexible and
easy-to-use alternative. Here follow the main commands you will need should you
choose to go along with this too.
```
$ mkdir mythesis
$ git init .
$ git commit --allow-empty -n -m "Initial commit."
$ git subtree add  --prefix document https://github.com/detiuaveiro/ua-thesis-template.git master --squash;
$ git subtree pull --prefix document https://github.com/detiuaveiro/ua-thesis-template.git master --squash;
```

- The first line will init a new repository for your thesis
- It will create an initial commit
- It will pull this repository for the first time to `document`
- The second is used for subsequent pulls.

The result should be a git repository for your thesis work. In the `$DESTDIR` (e.g. `document`)
you will have the document to edit. If you wish you can add a reference to another git repository
to track your own changes.

## Use as a template in github

Please check the [github instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)
to create your own repository using this as a template.

## Use it in [Overleaf](https://www.overleaf.com)

It is possible to use this template in overleaf.

To enable it:

- in `matter.tex` change `\def\useoverleaf{0}`to 1
- add `fc-portuges.def` to the project the file be can found in [here](http://mirrors.ctan.org/install/macros/latex/contrib/fmtcount.tds.zip) 
- change the main document to `matter.tex`

## Dependencies

- A TeX distribution: TeX Live or MacTeX
- gs (for `make print`, `make ebook` and `simplify-colors.sh`)
- pandoc (for `make lint`)
- imagemagick and poppler (for `simplify-colors.sh`)
- pygments (for minted)

As for pygments and proselint, those can by installed with pip by issuing `pip
install -r requirements.txt` at the root of this repository.

On Ubuntu relatives the following dependencies, installable with `apt` may
also be required
- biber
- texlive-bibtex-extra
- texlive-latex-extra
- texlive-science

These endorsed dependencies which may or may not come with the TeX Live package
distributed with your Linux distribution.

Usually TeX Live is split into a minimal package and a `texlive-extra` which is
filled with the remainder of TeX Live, be it fonts, styles, language support,
and so on. So, if a LaTeX dependency is missing on your installation, do verify
that you are not missing one of these packages.

## Authors

Tomás Oliveira e Silva created the [original
template](http://sweet.ua.pt/tos/TeX/ua_thesis.tgz) which was later picked up
by João Paulo Barraca who [improved and maintained it for
years](http://code.ua.pt//projects/latex-ua/repository).

This is a fork by Fábio Maia and Ricardo Jesus who wanted to further improve
the template and setup a clean environment and workflow for writing their MSc
thesis.
