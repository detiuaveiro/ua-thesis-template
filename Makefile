.PHONY: cover matter print ebook cleanall clean

# Vars
SRC			:= ${PWD}/src
OUT 		:= ${PWD}/out
SCRIPTS 	:= ${PWD}/scripts

# Commands
LATEXMK 		:= latexmk
LATEXMK_FLAGS	:= -pdf -silent -outdir=${OUT} -cd ${SRC}

all: cover matter

cover: ${SRC}/cover.tex
	${LATEXMK} ${LATEXMK_FLAGS} $<

matter: ${SRC}/matter.tex
	${LATEXMK} ${LATEXMK_FLAGS} $<

print: matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-print.pdf ${OUT}/matter.pdf
	./scripts/simplify-colors.sh ${OUT}/thesis-print.pdf

ebook: clean matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${OUT}/thesis-ebook.pdf ${OUT}/matter.pdf

clean:
	${LATEXMK} ${LATEXMK_FLAGS} -c

cleanall: clean
	rm -f out/*
