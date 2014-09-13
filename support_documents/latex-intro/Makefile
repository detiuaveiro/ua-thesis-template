
all: clean latex-intro-pt

pt: latex-intro-pt

latex-intro-pt: latex-intro-pt.tex
	pdflatex -shell-escape latex-intro-pt.tex
	bibtex latex-intro-pt
	pdflatex -shell-escape latex-intro-pt.tex
	pdflatex -shell-escape latex-intro-pt.tex

clean:
	rm -f *.toc *.lof *.aux *.blg *.out *.xml *.bbl *.log *-blx.bib
