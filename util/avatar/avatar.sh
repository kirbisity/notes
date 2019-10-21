carr=()
section=0
input="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/images/$1"
echo $input
while IFS= read -r line
do
    # blank lines separate color and picture
    if [[ $line == "" ]]
    then
        let section=section+1
    fi
    # first section is color definition
    if [[ $section -eq 0 ]]
    then
        carr+=($line)
    # second section is picture
    elif [[ ${line[0]} != "" ]]
    then
        for i in $(echo $line | sed -e 's/\(.\)/\1\n/g')
        do
            if [[ $i =~ [0-9] ]]
            then
                printf "\e[${carr[i]}m \e[${carr[0]}m"
	    else
		printf -v j "%d" "'$i"
		let j=$((j - 87))
                printf "\e[${carr[j]}m \e[${carr[0]}m"
	    fi
        done
        echo
    fi
    let count=count+1
done < "$input"
