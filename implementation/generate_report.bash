#!/usr/bin/env bash
# Dependencies:
#   git           https://git-scm.com
#   git-extras    https://github.com/tj/git-extras
#   cloc          https://github.com/AlDanial/cloc

# Arguments: $1 path to the code git repository
#            $2 text-based git line-summary
#            $3 LaTeX cloc output

set -e

SUMMARYOUT=$(readlink -f $2)
LATEXOUT=$(readlink -f $3)

pushd $1


GIT_REV=$(git rev-parse HEAD)
OWN_DIRS=$(git archive HEAD | tar t | cut -d / -f 1 | sort | uniq | \
           xargs -I{} bash -c "test -d '{}' && echo '{}'" | \
           egrep -v '(vendor)' | \
           egrep -v 'gui/static/(css/bootstrap|fonts|img)' | \
           egrep -v 'gui/static/js/(c3|d3|angular|jquery|bootstrap)')

# remove the first line because it contains 
cloc --quiet --csv-delimiter='  &  ' $OWN_DIRS | egrep -v '^$' | sed '1d' | sed 's/$/ \\\\/' > $LATEXOUT


echo "Git SHA1: $GIT_REV" > $SUMMARYOUT
for i in $OWN_DIRS; do
        pushd $i > /dev/null
        git line-summary | sed 's/ project  :/ directory:/' >> $SUMMARYOUT
        popd > /dev/null
done 

