BIB_FILES = \
    bib.plain.bbl \
    bib.unsrt.bbl \
    bib.abbrv.bbl \
    bib.alpha.bbl

EXTRA_BIB_FILES = \
    bib.plain.bbb \
    bib.unsrt.bbb \
    bib.abbrv.bbb \
    bib.alpha.bbb

EXTRA_TEX_FILES = \
    bib.plain.tex \
    bib.unsrt.tex \
    bib.abbrv.tex \
    bib.alpha.tex

all: $(BIB_FILES) $(EXTRA_BIB_FILES) $(EXTRA_TEX_FILES)

bib.%.bbl: bib.%.aux bib.bib
	bibtex bib.$*

bib.%.bbb: bib.%.bbl
	sed -e "s/\(bibitem[^{]*{\)/\1$*./" < $^ > $@

bib.%.tex: bib.tex
	sed -e s/cite{/cite{$*./ < $^ > $@


