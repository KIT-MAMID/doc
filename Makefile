all: functionalSpecification.pdf module_overview.pdf
	pdflatex functionalSpecification.tex
	makeglossaries functionalSpecification
	pdflatex functionalSpecification.tex
	pdflatex functionalSpecification.tex

module_overview.pdf: module_overview.uxf
	java -jar `which umlet` -action=convert -format=pdf -filename=module_overview.uxf -output=module_overview.pdf
