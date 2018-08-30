.PHONY: cover matter print ebook cleanall clean

# Vars
SRC     := ${PWD}/src
OUT     := ${PWD}/out
SCRIPTS := ${PWD}/scripts

# Commands
LATEXMK := latexmk
LATEXMK_FLAGS := -pdf
#LATEXMK_FLAGS += -silent
LATEXMK_FLAGS += -outdir=${OUT}
LATEXMK_FLAGS += -pdflatex="pdflatex -file-line-error -synctex=1 --shell-escape %O %S"

all: cover matter

cover:
	${LATEXMK} ${LATEXMK_FLAGS} -cd ${SRC}/$@.tex

matter: cover
	${LATEXMK} ${LATEXMK_FLAGS} -cd ${SRC}/$@.tex

print: matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-print.pdf ${OUT}/matter.pdf
	./scripts/simplify-colors.sh ${OUT}/thesis-print.pdf

ebook: clean matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-ebook.pdf ${OUT}/matter.pdf

clean:
	${LATEXMK} ${LATEXMK_FLAGS} -c

cleanall:
	rm -f out/*
