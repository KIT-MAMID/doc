all: design functional_specification
	$(MAKE) -C design
	$(MAKE) -C functional_specification
	$(MAKE) -C implementation
