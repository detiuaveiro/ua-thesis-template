# ua-thesis-template

A thesis LaTeX template that complies with the University of Aveiro's
guidelines and provides a simple CLI workflow around `make` that was developed
and tested for cross-compatibility on Linux (Slackware, ArchLinux) and macOS
(High Sierra 10.13.6).

## Usage

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

Clean the working directory:

```
make clean[all]
```

`clean` will leave the output products (the PDFs) in place, while `cleanall`
will remove these too. If your document is not compiling for some reason and
you think you've already solved the problem in the LaTeX sources, maybe try a
`cleanall` before insisting. Sometimes the underlying build programs (namely
`latexmk`) get stuck in inconsistent temporary files.

## Dependencies

- A TeX distribution: TeX Live or MacTeX
- gs (for `make print`, `make ebook` and `simplify-colors.sh`)
- imagemagick and poppler (for `simplify-colors.sh`)
- pygments (for minted)

## Authors

Tomás Oliveira e Silva created the [original
template](http://sweet.ua.pt/tos/TeX/ua_thesis.tgz) which was later picked up
by João Paulo Barraca who [improved and maintained it for
years](http://code.ua.pt//projects/latex-ua/repository).

This is a fork by Fábio Maia and Ricardo Jesus who wanted to further improve
the template and setup a clean environment and workflow for writing their MSc
thesis.
