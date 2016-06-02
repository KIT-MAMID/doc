# Settable
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)

# Internal vars (extend as needed)
UMLET_PDFS = module_overview.pdf state_diagram.pdf

# Targets
all: $(UMLET_PDFS)
	pdflatex functionalSpecification.tex
	makeglossaries functionalSpecification
	pdflatex functionalSpecification.tex
	pdflatex functionalSpecification.tex

# Assets
## UMLet
$(UMLET_PDFS): %.pdf: %.uxf
	$(call UMLET_CONVERT,$<,$@)

# Cleaning
clean:
	rm -f functionalSpecification.pdf
	rm -f functionalSpecification.aux
	rm -f functionalSpecification.glo
	rm -f functionalSpecification.gls
	rm -f functionalSpecification.out
	rm -f functionalSpecification.toc
	rm -f functionalSpecification.glsdefs
	rm -f functionalSpecification.ist
	rm -f functionalSpecification.glg
	rm -f functionalSpecification.log
	rm -f glossary.aux

	$(foreach pdf,$(UMLET_PDFS), \
		rm -f $(pdf); \
	)
