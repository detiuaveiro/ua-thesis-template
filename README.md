# ua-thesis-template

A thesis LaTeX template that complies with the University of Aveiro's guidelines and provides a simple CLI workflow around `make` that was developed and tested for cross-compatibility on Linux (Slackware, ArchLinux) and macOS (High Sierra 10.13.6).

## Usage

Build a development version of the document:

```
make
make build
```

Continuously build the development version of the document:

```
make preview
```

Build versions of the document for publishing:

```
make print
make ebook
```

Clean the working directory:

```
make clean
make cleanall
```

## Dependencies

- TeX Live or MacTeX
- gs (for `make print` and `make ebook`)
- imagemagick and poppler (for `simplify-colors.sh`)
