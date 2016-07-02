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
	
class_diagram.pdf: uml/drafts/slave/sketches.uxf
	$(call UMLET_CONVERT,$<,$@)

slave_classes.pdf: class_diagram.pdf
	pdfcrop --bbox "0 1300 800 2320"  class_diagram.pdf $@

msp_classes.pdf: class_diagram.pdf
	pdfcrop --bbox "700 1300 4000 2400"  class_diagram.pdf $@

model_classes.pdf: class_diagram.pdf
	pdfcrop --bbox "700 140 2400 1200"  class_diagram.pdf $@

master_classes.pdf: class_diagram.pdf
	pdfcrop --bbox "2400 0 4000 700"  class_diagram.pdf $@

design.pdf: *.tex class_diagram.pdf slave_classes.pdf msp_classes.pdf model_classes.pdf master_classes.pdf
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
	rm -f class_diagram.pdf
	rm -f slave_classes.pdf
	rm -f msp_classes.pdf
	rm -f model_classes.pdf
	rm -f master_classes.pdf
	rm -f design.pdf
