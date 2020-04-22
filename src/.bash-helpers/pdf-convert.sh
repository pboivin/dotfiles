function pdftopng {
    if [ "$1" == "" ]; then
        echo "Usage: pdftopng input.pdf"
        return 1
    fi

    local outfile=$(echo "$1" | sed 's/\.pdf//g')
    pdftoppm "$1" "$outfile" -png
}

function pdftojpg {
    if [ "$1" == "" ]; then
        echo "Usage: pdftojpg input.pdf"
        return 1
    fi

    local outfile=$(echo "$1" | sed 's/\.pdf//g')
    pdftoppm "$1" "$outfile" -jpeg
}
