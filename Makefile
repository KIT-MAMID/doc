# Settable
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`
PDFLATEX ?= pdflatex -synctex=1
MAKEGLOSSARIES ?= makeglossaries
XVFB_RUN ?= `which xvfb-run` -a --server-args="-screen 0, 1920x1080x24"
CUTYCAPT_BIN ?= `which cutycapt`
SCREENSHOTS_BASE_URL ?=http://127.0.0.1:5000

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)
CUTYCAPT=$(XVFB_RUN) $(CUTYCAPT_BIN) --min-width=1024 --min-height=600 --url=$(SCREENSHOTS_BASE_URL)$(1) --out=$(2)

# Internal vars (extend as needed)
UMLET_PDFS = module_overview.pdf state_diagram.pdf cluster_layout.pdf hardware_layout.pdf

SCREENSHOTS = dashboard slaves problems slave_edit_unknown slave_edit_active slave_edit_maintenance slave_edit_disabled risk_groups replica_sets
SCREENSHOTS := $(addprefix screenshots/,$(SCREENSHOTS))
SCREENSHOTS := $(addsuffix .png,$(SCREENSHOTS))

# Targets
all: $(SCREENSHOTS) $(UMLET_PDFS)
	$(PDFLATEX) functionalSpecification.tex
	$(MAKEGLOSSARIES) functionalSpecification
	$(PDFLATEX) functionalSpecification.tex
	$(PDFLATEX) functionalSpecification.tex

# Assets
## UMLet
$(UMLET_PDFS): %.pdf: %.uxf
	$(call UMLET_CONVERT,$<,$@)

## Screenshots
.PHONY: screenshots_dir screenshots
screenshots: | screenshots_dir $(SCREENSHOTS)
screenshots_dir:
	mkdir screenshots
$(SCREENSHOTS): %.png: screenshots_dir
	@if [ "$(notdir $(basename $@))" = "dashboard" ]; 		then $(call CUTYCAPT,"/","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "slaves" ]; 			then $(call CUTYCAPT,"/slaves","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "problems" ]; 		then $(call CUTYCAPT,"/problems","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_unknown" ]; 	then $(call CUTYCAPT,"/slave/mksuns11/edit/unknown","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_active" ]; 	then $(call CUTYCAPT,"/slave/mksuns11/edit/active","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_maintenance" ]; 	then $(call CUTYCAPT,"/slave/mksuns11/edit/maintenance","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_disabled" ]; 	then $(call CUTYCAPT,"/slave/mksuns11/edit/disabled","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "risk_groups" ]; 		then $(call CUTYCAPT,"/riskgroups","$@"); fi;
	@if [ "$(notdir $(basename $@))" = "replica_sets" ]; 		then $(call CUTYCAPT,"/replicasets","$@"); fi;

# Cleaning
clean: clean_screenshots
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
	rm -f module_overview.pdf

clean_screenshots:
	rm -rf screenshots
