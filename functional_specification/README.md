# Compiling

## Dependencies

* git
* python3
	* => `ui/requirements.txt`
* Web Frameworks
	* => `ui/static/js/whatToPlaceHere.txt`
* TeXLive or compatible distro
* cutycapt
* xvfb-run
 
## Commands

```
git submodule update --init --remote

# Install python dependencies for ui project (ui/requirements.txt)
# Manually install javascript dependencies in ui project (ui/static/js/whatToPlaceHere.txt)
# Run ui/mamid_mock.py (needs to run for screenshot generation)

# Run make, fix dependencies as necessary
make

