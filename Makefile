all: functionalSpecification.pdf
	pdflatex functionalSpecification.tex
	makeglossaries functionalSpecification
	pdflatex functionalSpecification.tex
	pdflatex functionalSpecification.tex
