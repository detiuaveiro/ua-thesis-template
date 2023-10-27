.PHONY: all build preview print ebook clean cleanall setup

# Vars
SRC     := ${PWD}
OUT     := ${PWD}/build
SCRIPTS := ${PWD}/scripts

# Commands
LATEXMK := $(or $(shell command -v latexmk),latexmk)
LATEXMK_FLAGS := -pdf
#LATEXMK_FLAGS += -silent
LATEXMK_FLAGS += -view=none
LATEXMK_FLAGS += -auxdir=${OUT}
LATEXMK_FLAGS += -outdir=${OUT}
LATEXMK_FLAGS += -pdflatex="pdflatex -file-line-error --shell-escape %O %S"
# LATEXMK_FLAGS += -e '$$makeindex=q/sh -c "cd `dirname "%D"`" ; makeindex %O -o "`basename "%D"`" "`basename "%S"`";/'


all: build

setup:
	@sudo apt install texlive-latex-base texlive-lang-portuguese texlive-lang-english biber texlive-latex-extra texlive-science python3-pygments python3-proselint pandoc imagemagick latexmk ghostscript 

build: 
	@mkdir -p ${OUT}/chapters
	cd ${OUT} ; ${LATEXMK} ${LATEXMK_FLAGS} -cd ${SRC}/cover.tex ${SRC}/matter.tex

preview: build
	(${LATEXMK} ${LATEXMK_FLAGS} -pvc -cd ${SRC}/cover.tex & ${LATEXMK} ${LATEXMK_FLAGS} -pvc -cd ${SRC}/matter.tex)

print: build
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-print.pdf ${OUT}/matter.pdf
	${SCRIPTS}/simplify-colors.sh ${OUT}/thesis-print.pdf

ebook: build
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-ebook.pdf ${OUT}/matter.pdf

clean: 
	@find ${OUT} -type f ! -name '*.pdf' -delete
	@find ${OUT}/* -type d -delete

cleanall: 
	@rm -rf ${OUT}/* 

lint:
ifeq ($(strip $(texfile)),)
	+@for f in `ls -v chapters/*.tex`; do  \
		echo "* $$f";  \
		make --no-print-directory lint texfile="$$f";  \
	done
else
	@lacheck "$(texfile)"
	@chktex -q --verbosity=3 "$(texfile)"
	$(eval txtfile := $(shell echo "$(OUT)/`basename "$(texfile)" .tex`.txt"))
	@pandoc -s "$(texfile)" -o "$(txtfile)"
	@proselint "$(txtfile)" || true
endif
