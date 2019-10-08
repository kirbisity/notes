carr=()
draw=0
input="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/data/$1.txt"
while IFS= read -r line
do
	if [[ $draw -eq 0 ]]
	then
		carr+=($line)
	elif [[ ${line[0]} != "" ]]
	then
		for i in $(echo $line | sed -e 's/\(.\)/\1\n/g')
		do
			printf "\e[${carr[i]}m \e[${carr[0]}m"
		done
		echo
	fi
	if [[ $line == "" ]]
	then
		let draw=1
	fi
	let count=count+1
done < "$input"
