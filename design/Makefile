# Settable
SHELL ?= /bin/bash
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`
PDFLATEX ?= pdflatex -synctex=1
MAKEGLOSSARIES ?= makeglossaries
INKSCAPE_BIN ?= `which inkscape`
CURL_BIN ?= `which curl`

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)
SVG2PDF = $(INKSCAPE_BIN) -A $(2) $(1)
HTTPDL = $(CURL_BIN) -o $(2) '$(1)'

# Targets
.PHONY:
all: design.pdf
	

design.pdf: *.tex
	$(PDFLATEX) design.tex
	$(MAKEGLOSSARIES) design
	$(PDFLATEX) design
	$(PDFLATEX) design

# Cleaning
clean: 
	rm -f design.pdf
	rm -f design.aux
	rm -f design.glo
	rm -f design.gls
	rm -f design.out
	rm -f design.toc
	rm -f design.glsdefs
	rm -f design.ist
	rm -f design.glg
	rm -f design.log
	rm -f glossary.aux

	rm -f design.pdf
