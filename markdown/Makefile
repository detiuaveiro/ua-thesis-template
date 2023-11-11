#SHELL := /bin/bash

all:
	. .venv/bin/activate && \
	pandoc \
		-f markdown /dev/null \
		-o ../cover.tex \
		--template=./templates/cover_template.tex \
		--metadata-file=metadata.yaml && \
	pandoc \
		--filter ./filters/filters.py \
		--filter ./filters/pandoc-minted/pandoc-minted.py \
		--template=./templates/matter_template.tex \
		-o ../matter.tex \
		--metadata-file=metadata.yaml \
		./content/*.md

install:
	python3 -m venv .venv
	. .venv/bin/activate && \
	pip3 install -r requirements.txt

	cd filters && \
	git clone https://github.com/nick-ulle/pandoc-minted.git
