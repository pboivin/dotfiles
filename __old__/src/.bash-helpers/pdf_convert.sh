function pdf_to_png {
    if [ "$1" == "" ]; then
        echo "Usage: pdf_to_png input.pdf"
        return 1
    fi

    local outfile=$(echo "$1" | sed 's/\.pdf//g')
    pdftoppm "$1" "$outfile" -png
}

function pdf_to_jpg {
    if [ "$1" == "" ]; then
        echo "Usage: pdf_to_jpg input.pdf"
        return 1
    fi

    local outfile=$(echo "$1" | sed 's/\.pdf//g')
    pdftoppm "$1" "$outfile" -jpeg
}
