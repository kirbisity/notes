sequence=""
carr=()
gparr=()
gpstr=""
tput rc
input="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/movies/$1"
# number of blank separated sessions
section=0
while IFS= read -r line
do
    # blank lines separate sequence, color and picture sessions
    if [[ $line == "" ]]
    then
        let section=section+1
	if [[ $gpstr != "" ]]
        then
	    gparr+=($gpstr)
	    gpstr=""
	fi
	continue
    fi
    # first section is frame sequence
    if [[ $section -eq 0 ]]
    then
	sequence=$line 
    # second section is color definition
    elif [[ $section -eq 1 ]]
    then
	carr+=($line)
    # the rest sections are all pictures
    elif [[ ${line[0]} != "" ]]
    then
	gpstr="${gpstr}${line}\n"
    fi
done < "$input"
gpstr=""

clear
# draw the movie based on the sequence
for f in $(echo $sequence | sed -e 's/\(.\)/\1\n/g')
do
    j=0
    if [[ $f =~ [0-9] ]]
    then
        let j=$f
    else
	printf -v j "%d" "'$f"
	let j=$((j - 87))
    fi
    tput cup 2 0
    for line in $(echo -e ${gparr[$j]})
    do
	for i in $(echo $line | sed -e 's/\(.\)/\1\n/g')
        do
            if [[ $i =~ [0-9] ]]
            then
                printf -v t "\e[${carr[i]}m \e[${carr[0]}m"
		gpstr="$gpstr$t"
	    else
		printf -v j "%d" "'$i"
		let j=$((j - 87))
                printf -v t "\e[${carr[j]}m \e[${carr[0]}m" 
                gpstr="$gpstr$t"	
	    fi
	done
        gpstr="${gpstr}\n"
    done
    printf "$gpstr"
    gpstr=""
    sleep 0.1
done
tput cup sc
