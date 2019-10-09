carr=()
sequence=""
gparr=()
draw=0
frame=0
gpstr=""
tput rc
input="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/movies/$1.txt"
while IFS= read -r line
do
    if [[ $draw -eq 0 ]]
    then
	if [[ $sequence == "" ]]
        then
	    sequence=$line
	else
	    carr+=($line)
	fi
    elif [[ ${line[0]} != "" ]]
    then
	gpstr="${gpstr}${line}\n"
    fi
    if [[ $line == "" ]]
    then
	if [[ $draw -eq 0 ]]
        then
            let draw=1
	fi
	gparr+=($gpstr)
	gpstr=""
        let frame=frame+1
    fi

    let count=count+1
done < "$input"
# draw the movie based on the sequence
for f in $(echo $sequence | sed -e 's/\(.\)/\1\n/g')
do
    tput cup 0 0
    for line in $(echo -e ${gparr[$f]})
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
#tput cup sc
