#!/usr/bin/env bash

set -e

export NN="$PWD/nn"
export TESTING=yes

mkdir -p .test_results
cd .test_results
rm -rf *.md

function print_file() {
    for md in *.md; do
        echo "================================================="
        echo "File: $md"
        echo "================================================="
        cat "$md"
    done
}

#----------------------------------------------------------
# it creates a daily file
#----------------------------------------------------------
OUTPUT=$("$NN")
print_file
rm -rf *.md

#----------------------------------------------------------
# it creates a file with a date and title
#----------------------------------------------------------
OUTPUT=$("$NN" "A file with a date and title")
print_file
rm -rf *.md

#----------------------------------------------------------
# it creates a file without a date
#----------------------------------------------------------
OUTPUT=$("$NN" -t "A file without a date")
print_file
rm -rf *.md

