#!/bin/bash
# run git-review -l and then offer to download the one that is picked.

# pesci '*' in juju lines meaning "selected" model end up globbing in the script
set -o noglob

function get_reviews {
        local IFS=$'\n'
        reviews=(`git review -ll`)
        local i
        local j
        for (( i=0; i<${#reviews[@]} -1; i++ )) ; do
                j=$(( $i+1 ))
                echo "$j: ${reviews[$i]}"
        done
}

echo "Which review to download?\n"

get_reviews
len=$(( ${#reviews[@]} -1))

read -r -p "Choose: 1..$len:" response

if (( $response < 1 || $response > $len )); then
        echo "$response is not in range 1..$len"
        exit 1
fi

index=$(($response-1))
line=${reviews[$index]}
review=`echo $line | cut -d " " -f 1`

echo "review will be $review"
git review -d $review
git st
