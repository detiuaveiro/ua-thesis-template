
all: cover matter thesis

commit: clean
	find . -type f |xargs git add
	git add -u
	git commit -m "Commit"
	git push

bib:
	biber matter

cover:
	latexmk -pdf -g cover.tex

matter: cover
	latexmk -pdf -g matter.tex

thesis: matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=out/thesis-print.pdf matter.pdf

publish: clean matter
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=out/thesis-ebook.pdf matter.pdf
	#scp somehwere

clean-out:
	rm -f out/*

clean: clean-out
	latexmk -C
