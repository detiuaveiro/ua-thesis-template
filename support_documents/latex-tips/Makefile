
all: clean tipsetricks

tipsetricks: tipsetricks.tex
	pdflatex -synctex=1 -interaction=nonstopmode tipsetricks.tex
	pdflatex -synctex=1 -interaction=nonstopmode tipsetricks.tex

clean:
	rm -f *.toc *.lof *.aux *.blg *.out *.xml *.bbl *.log *-blx.bib *.synctex.gz
