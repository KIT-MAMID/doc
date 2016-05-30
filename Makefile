all: module_overview.pdf
	pdflatex functionalSpecification.tex
	makeglossaries functionalSpecification
	pdflatex functionalSpecification.tex
	pdflatex functionalSpecification.tex

module_overview.pdf: module_overview.uxf
	java -jar `which umlet` -action=convert -format=pdf -filename=module_overview.uxf -output=module_overview.pdf

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

	rm -f module_overview.pdf
