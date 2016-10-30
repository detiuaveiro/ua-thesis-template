UNAME 	:= 	$(shell uname)
TEXDEPS := 	blindtext collection-fontsrecommended morewrites csquotes datetime fmtcount \
			anyfontsize comment pdfcomment marginnote bezos biblatex logreq biblatex-ieee \
			acronym bigfoot xstring pgf-umlsd siunitx circuitikz lipsum placeins soul

# Simple tests
HAS_LATEX := $(shell pdflatex --version >/dev/null 2>&1)

# Vars
ifeq ($(UNAME), Darwin)
	CASK_PKGS	:= basictex
	SRC_PKGS 	:= homebrew/tex/latex-mk
	LATEXMK 	:= latex-mk
	BIB 		:= bibtex
else
	LATEXMK 	:= latexmk
	BIB 		:= biber
endif

# Commands
ifeq ($(UNAME), Darwin)
	CMD_COVER	:= ${LATEXMK} --pdflatex cover.tex
	CMD_IDEPS_CASK	:= brew cask install ${CASK_PKGS}
	CMD_IDEPS_SRC	:= brew install ${SRC_PKGS}
	CMD_IDEPS_PKGS	:= sudo tlmgr update --self && sudo tlmgr update --all && sudo tlmgr install ${TEXDEPS}
	CMD_MATTER 	:= ${LATEXMK} --pdflatex --pdflatex='pdflatex -file-line-error --shell-escape -synctex=1' matter.tex
	CMD_CLEAN	:= ${LATEXMK} --clean cover matter thesis
else
	CMD_COVER	:= ${LATEXMK} -pdf -g cover.tex
	CMD_MATTER	:= ${LATEXMK} backend=bibtex -pdf -g matter.tex
	CMD_BIB 	:= ${BIB} matter
	CMD_CLEAN	:= ${LATEXMK} -C
endif


all: cover matter thesis

ideps:
ifndef HAS_LATEX
	${CMD_IDEPS_CASK}
	${CMD_IDEPS_SRC}
endif
	${CMD_IDEPS_PKGS}
	
udeps:
	brew uninstall ${SRC_PKGS}
	brew cask uninstall ${CASK_PKGS}

commit: clean
	find . -type f |xargs git add
	git add -u
	git commit -m "Commit"
	git push

bib:
	${BIB} matter

cover:
	${CMD_COVER}

matter: cover
	${CMD_MATTER}

thesis: matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=out/thesis-print.pdf matter.pdf

publish: clean matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=out/thesis-ebook.pdf matter.pdf
	#scp somehwere

clean-out:
	rm -f out/*

clean: clean-out
	${CMD_CLEAN}
	rm -f *.bbl *.lpc *.mw *.run.xml *.upa *.aux *.log *.idx *.bcf *.blg *.lof *.lot *.toc *.old *.bib
