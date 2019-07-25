HERE_THERE_LIST="$HOME/.here_there_locations"
HERE_THERE_LIST_TMP="$HERE_THERE_LIST.tmp"

function here {
    local name="$1"

    if [ "$name" == "" ]; then
        name="-"
    fi

    touch "$HERE_THERE_LIST"
    echo "$name $PWD" >> "$HERE_THERE_LIST"
}

function there {
    local name="$1"

    if [ "$name" == "" ]; then
        name="-"
    fi

    if [[ "$name" == "-l" || "$name" == "--list" ]]; then
        cat "$HERE_THERE_LIST" | sort
        return
    fi

    if [[ "$name" == "-c" || "$name" == "--clear" ]]; then
        echo -n "" > "$HERE_THERE_LIST"
        return
    fi

    _there_prepare_locations

    location="$(_there_find_by_name $name)"

    if [ -d "$location" ]; then
        cd "$location"
    elif [ -e "$location" ]; then
        echo "Error: '$location' is not a directory"
    else
        echo "Error: '$location' not found"
    fi
}

function _there_prepare_locations() {
    touch "$HERE_THERE_LIST"

    cat "$HERE_THERE_LIST" | awk '
    {
        line = $0;
        location = $1;
        locations[location] = line;
    }
    END {
        for (location in locations) {
            print locations[location];
        }
    }' > "$HERE_THERE_LIST_TMP"

    mv "$HERE_THERE_LIST_TMP" "$HERE_THERE_LIST"
}

function _there_find_by_name() {
    local name="$1"

    cat "$HERE_THERE_LIST" | awk '
    {
        location = $1;
        $1 = "";
        locations[location] = $0;
    }
    END {
        print locations["'$name'"];
    }' | sed 's/^ *//g'
}
