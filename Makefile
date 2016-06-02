CUTYCAPT=xvfb-run -a --server-args="-screen 0, 1920x1080x24" cutycapt --min-width=1920 --min-height=1080  --user-style-string="html, body { max-height: 1080px; overflow: hidden;}"
SCREENSHOTS_BASE_URL=http://127.0.0.1:5000

all: module_overview.pdf
	pdflatex functionalSpecification.tex
	makeglossaries functionalSpecification
	pdflatex functionalSpecification.tex
	pdflatex functionalSpecification.tex

module_overview.pdf: module_overview.uxf screenshots
	java -jar `which umlet` -action=convert -format=pdf -filename=module_overview.uxf -output=module_overview.pdf

screenshots screenshots/:
	mkdir screenshots
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL) --out=screenshots/dashboard.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/slaves --out=screenshots/slaves.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/problems --out=screenshots/problems.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/slave/mksuns11/edit/unknown --out=screenshots/slave_edit_unkown.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/slave/mksuns12/edit/active --out=screenshots/slave_edit_active.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/slave/mksuns11/edit/maintenance --out=screenshots/slave_edit_maintenance.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/slave/mksuns11/edit/disabled --out=screenshots/slave_edit_disabled.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/riskgroups --out=screenshots/risk_groups.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/replicasets --out=screenshots/replica_sets.png
	-$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/replicaset/mksuns11/edit/degraded --out=screenshots/replica_set_overview_degraded.png
	 -$(CUTYCAPT) --url=$(SCREENSHOTS_BASE_URL)/replicaset/mksuns11/edit/active --out=screenshots/replica_set_overview_active.png

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

	rm -rf screenshots
