function grepi {
    local cmd="grep -nri $1 ."
    local i

    if [ $# -lt 1 ]; then
        echo "Error: need at least one argument"
        return
    fi

    # build grep chain with function arguments
    i=2
    while [ $i -le $# ]; do
        eval 'cmd="$cmd | grep -i $'$i'"'
        let i+=1
    done

    # run grep chain
    eval "$cmd"
}
