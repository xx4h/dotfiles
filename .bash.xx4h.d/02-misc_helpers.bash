# Misc Helpers

# Returns summary of all lines (default column 1)
function add () {
    COLUMN=${1:-1}
    if ! [[ $COLUMN =~ ^[0-9]+$ ]]; then
        echo "Column needs to be a number!"
        exit
    fi
    # maybe add version which prints all lines and sum=
    # awk '{sum+=$'$COLUMN' ; print $0} END{print "sum=",sum}'
    awk '{sum+=$'$COLUMN'} END{print sum}'
}
