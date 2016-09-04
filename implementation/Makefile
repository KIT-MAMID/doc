# Settable
SHELL ?= /bin/bash
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`
PDFLATEX ?= pdflatex -synctex=1
MAKEGLOSSARIES ?= makeglossaries
INKSCAPE_BIN ?= `which inkscape`
PDFCROP_BIN ?= `which pdfcrop`
CURL_BIN ?= `which curl`

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)
SVG2PDF = $(INKSCAPE_BIN) -A $(2) $(1)
HTTPDL = $(CURL_BIN) -o $(2) '$(1)'

# Targets
.PHONY:
all: implReport.pdf
	
implReport.pdf: *.tex
	$(PDFLATEX) implReport.tex
	$(MAKEGLOSSARIES) implReport
	$(PDFLATEX) implReport
	$(PDFLATEX) implReport

# Cleaning
clean: 
	rm -f implReport.pdf
	rm -f implReport.aux
	rm -f implReport.glo
	rm -f implReport.gls
	rm -f implReport.out
	rm -f implReport.toc
	rm -f implReport.glsdefs
	rm -f implReport.ist
	rm -f implReport.glg
	rm -f implReport.log
	rm -f glossary.aux
	rm -f class_diagram.pdf
	rm -f slave_classes.pdf
	rm -f msp_classes.pdf
	rm -f model_classes.pdf
	rm -f master_classes.pdf
	rm -f gui_classes.pdf
	rm -f implReport.pdf
	rm -f notifier_classes.pdf