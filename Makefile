.PHONY: all build preview print ebook cleanall clean

# Vars
SRC     := ${PWD}/src
OUT     := ${PWD}/out
SCRIPTS := ${PWD}/scripts

# Commands
LATEXMK := latexmk
LATEXMK_FLAGS := -pdf
#LATEXMK_FLAGS += -silent
LATEXMK_FLAGS += -view=none
LATEXMK_FLAGS += -auxdir=${OUT}
LATEXMK_FLAGS += -outdir=${OUT}
LATEXMK_FLAGS += -pdflatex="pdflatex -file-line-error -synctex=1 --shell-escape %O %S"
LATEXMK_FLAGS += -e '$$makeindex=qq/sh -c "cd "`dirname "%D"`" ; makeindex %O -o "`basename "%D"`" "`basename "%S"`""/;'

all: build

build:
	cd ${OUT} ; ${LATEXMK} ${LATEXMK_FLAGS} -cd ${SRC}/cover.tex
	cd ${OUT} ; ${LATEXMK} ${LATEXMK_FLAGS} -cd ${SRC}/matter.tex

preview:
	${LATEXMK} ${LATEXMK_FLAGS} -pvc -cd ${SRC}/cover.tex &
	${LATEXMK} ${LATEXMK_FLAGS} -pvc -cd ${SRC}/matter.tex &

print: clean build
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-print.pdf ${OUT}/matter.pdf
	${SCRIPTS}/simplify-colors.sh ${OUT}/thesis-print.pdf

ebook: clean build
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-ebook.pdf ${OUT}/matter.pdf

clean:
	${LATEXMK} ${LATEXMK_FLAGS} -c ${SRC}/cover.tex
	${LATEXMK} ${LATEXMK_FLAGS} -c ${SRC}/matter.tex

cleanall:
	rm -rf out/*
