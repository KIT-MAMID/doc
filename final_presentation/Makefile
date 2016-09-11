# Settable
SHELL ?= /bin/bash
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`
PDFLATEX ?= pdflatex -synctex=1
CUTYCAPT_BIN ?= `which cutycapt`
INKSCAPE_BIN ?= `which inkscape`
DOT_BIN ?= `which dot`
PDFCROP_BIN ?= `which pdfcrop`

UMLET_PDFS = 
SVGS = mamid3_web gh_punchcard contrib/angularjs/AngularJS_logo contrib/postgres/PostgreSQL_logo contrib/gopher/gopher
SVGS := $(addprefix assets/,$(SVGS)) 
SVGS := $(addsuffix .pdf,$(SVGS)) 
DOTS = assets/mongod_states.eps assets/mongod_states_old.eps assets/module_graph.eps

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)
SVG2PDF = $(INKSCAPE_BIN) -A $(2) $(1)
DOT_CMD = $(DOT_BIN) -Efontsize=24 -Nfontsize=28 -Teps $(1) -o $(2)
# Targets
.PHONY:
all: final_presentation.pdf

final_presentation.pdf: final_presentation.tex $(SVGS) $(DOTS) assets/cloc.tex assets/class_diagram.pdf assets/slave_classes.pdf assets/msp_classes.pdf assets/master_classes.pdf assets/gui_classes.pdf assets/notifier_classes.pdf
	$(PDFLATEX) $<

$(DOTS): %.eps: %.dot
	$(call DOT_CMD,$<,$@)	

# Assets
## UMLet
$(UMLET_PDFS): %.pdf: %.uxf
	$(call UMLET_CONVERT,$<,$@)

# SVGs
$(SVGS): %.pdf : %.svg
	$(call SVG2PDF,$<,$@)

assets/class_diagram.pdf: assets/class_diagram.uxf
	$(call UMLET_CONVERT,$<,$@)

assets/slave_classes.pdf: assets/class_diagram.pdf
	$(PDFCROP_BIN) --bbox "0 100 600 600"  $< $@

assets/msp_classes.pdf: assets/class_diagram.pdf
	$(PDFCROP_BIN) --bbox "300 300 1000 600"  $< $@

assets/master_classes.pdf: assets/class_diagram.pdf
	$(PDFCROP_BIN) --bbox "300 0 1100 400"  $< $@

assets/gui_classes.pdf: assets/class_diagram.pdf
	$(PDFCROP_BIN) --bbox "1000 0 1500 200"  $< $@

assets/notifier_classes.pdf: assets/class_diagram.pdf
	$(PDFCROP_BIN) --bbox "1000 100 1600 400"  $< $@

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
	rm -f assets/mongod_states*.eps

