# Settable
SHELL ?= /bin/bash
UMLET_JAR ?= `which umlet`
JAVA ?= `which java`
PDFLATEX ?= pdflatex -synctex=1
MAKEGLOSSARIES ?= makeglossaries
XVFB_RUN ?= `which xvfb-run` -a --server-args="-screen 0, 1920x1080x24"
CUTYCAPT_BIN ?= `which cutycapt`
SCREENSHOTS_BASE_URL ?=http://127.0.0.1:5000
INKSCAPE_BIN ?= `which inkscape`
CURL_BIN ?= `which curl`

# Internal commands
UMLET_CONVERT = $(JAVA) -jar $(UMLET_JAR) -action=convert -format=pdf -filename=$(1) -output=$(2)
CUTYCAPT=$(XVFB_RUN) $(CUTYCAPT_BIN) --delay=$(3) --zoom=1.25 --min-width=1600 --min-height=1200 --user-style-string="html, body { max-height: 1200px; overflow: hidden;}" --url=$(SCREENSHOTS_BASE_URL)$(1) --out=$(2)
SVG2PDF = $(INKSCAPE_BIN) -A $(2) $(1)
HTTPDL = $(CURL_BIN) -o $(2) '$(1)'

# Internal vars (extend as needed)
UMLET_PDFS = module_overview.pdf state_diagram.pdf cluster_layout.pdf hardware_layout.pdf

SCREENSHOTS = dashboard slaves problems slave_edit_unknown slave_edit_active slave_edit_maintenance slave_edit_disabled risk_groups risk_groups_remove_confirmation replica_sets replica_set_overview_degraded replica_set_overview_active new_slave new_replica_set slave_remove replica_set_remove 
SCREENSHOTS := $(addprefix screenshots/,$(SCREENSHOTS))
SCREENSHOTS := $(addsuffix .png,$(SCREENSHOTS))

CLUSTER_HW_STEPWISE = $(shell seq 1 11)
CLUSTER_HW_STEPWISE := $(addprefix assets/cluster_hw_stepwise/step,$(CLUSTER_HW_STEPWISE))
CLUSTER_HW_STEPWISE := $(addsuffix .pdf,$(CLUSTER_HW_STEPWISE))

# Targets
.PHONY:
all: functionalSpecification.pdf presentation.pdf
	
	
functionalSpecification.pdf: $(SCREENSHOTS) $(UMLET_PDFS) functionalSpecification.tex
	$(PDFLATEX) functionalSpecification.tex
	$(MAKEGLOSSARIES) functionalSpecification
	$(PDFLATEX) functionalSpecification.tex
	$(PDFLATEX) functionalSpecification.tex

fast: $(SCREENSHOTS) $(UMLET_PDFS)
	$(PDFLATEX) functionalSpecification.tex

presentation.pdf: $(CLUSTER_HW_STEPWISE) $(SCREENSHOTS) assets/xkcd1289.png presentation.tex
	$(PDFLATEX) presentation.tex

# Assets
## UMLet
$(UMLET_PDFS): %.pdf: %.uxf
	$(call UMLET_CONVERT,$<,$@)

## Screenshots
.PHONY screenshots_repo: ; git submodule update --init --remote
screenshots:
	mkdir -p screenshots
$(SCREENSHOTS): %.png: screenshots
	@if [ "$(notdir $(basename $@))" = "dashboard" ]; 				then $(call CUTYCAPT,"/","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "slaves" ]; 					then $(call CUTYCAPT,"/slaves","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "problems" ]; 				then $(call CUTYCAPT,"/problems","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_unknown" ]; 			then $(call CUTYCAPT,"/slave/mksuns11/edit/unknown","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_active" ]; 			then $(call CUTYCAPT,"/slave/mksuns11/edit/active","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_maintenance" ]; 			then $(call CUTYCAPT,"/slave/mksuns11/edit/maintenance","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_edit_disabled" ]; 			then $(call CUTYCAPT,"/slave/mksuns11/edit/disabled","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "risk_groups" ]; 				then $(call CUTYCAPT,"/riskgroups","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "risk_groups_remove_confirmation" ]; 	then $(call CUTYCAPT,"/riskgroups#modal","$@","200"); fi;
	@if [ "$(notdir $(basename $@))" = "replica_sets" ]; 				then $(call CUTYCAPT,"/replicasets","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "replica_set_overview_degraded" ]; 		then $(call CUTYCAPT,"/replicaset/meteorologic_data/edit/degraded","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "replica_set_overview_active" ]; 		then $(call CUTYCAPT,"/replicaset/meteorologic_data/edit/active","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "replica_set_remove" ];             		then $(call CUTYCAPT,"/replicaset/meteorologic_data/edit/active#modal","$@","200"); fi;
	@if [ "$(notdir $(basename $@))" = "slave_remove" ];                     	then $(call CUTYCAPT,"/slave/mksuns11/edit/disabled#modal","$@","200"); fi;
	@if [ "$(notdir $(basename $@))" = "new_slave" ];             			then $(call CUTYCAPT,"/new/slave","$@","0"); fi;
	@if [ "$(notdir $(basename $@))" = "new_replica_set" ];                         then $(call CUTYCAPT,"/new/replicaset","$@","0"); fi;

# SVGs
$(CLUSTER_HW_STEPWISE): %.pdf: %.svg
	$(call SVG2PDF,$<,$@)

# HTTP DL
assets/xkcd1289.png:
	$(call HTTPDL,https://imgs.xkcd.com/comics/simple_answers.png,$@)

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
	rm -f presentation.pdf
	rm -f presentation.aux
	rm -f presentation.glo
	rm -f presentation.gls
	rm -f presentation.out
	rm -f presentation.toc
	rm -f presentation.glsdefs
	rm -f presentation.ist
	rm -f presentation.glg
	rm -f presentation.log

	rm -f assets/xkcd1289.png

	$(foreach pdf,$(UMLET_PDFS), \
		rm -f $(pdf); \
	)

	$(foreach pdf,$(CLUSTER_HW_STEPWISE), \
		rm -f $(pdf); \
	)

	rm -f module_overview.pdf

clean_screenshots:
	rm -rf screenshots
