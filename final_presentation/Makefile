# Settable
SHELL ?= /bin/bash
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`
PDFLATEX ?= pdflatex -synctex=1
CUTYCAPT_BIN ?= `which cutycapt`
INKSCAPE_BIN ?= `which inkscape`

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)
SVG2PDF = $(INKSCAPE_BIN) -A $(2) $(1)

# Internal vars (extend as needed)
UMLET_PDFS = 

# Targets
.PHONY:
all: final_presentation.pdf
	
final_presentation.pdf: final_presentation.tex
	$(PDFLATEX) $<

# Assets
## UMLet
$(UMLET_PDFS): %.pdf: %.uxf
	$(call UMLET_CONVERT,$<,$@)
# Cleaning
clean: 
	rm -f final_presentation.pdf
	rm -f final_presentation.aux
	rm -f final_presentation.glo
	rm -f final_presentation.gls
	rm -f final_presentation.out
	rm -f final_presentation.toc
	rm -f final_presentation.glsdefs
	rm -f final_presentation.ist
	rm -f final_presentation.glg
	rm -f final_presentation.log
	rm -f final_presentation.pdf
	rm -f final_presentation.pdfpc

