no="\e[0m"
pink="\e[48;5;217m"
magenta="\e[48;5;161m"
black="\e[48;5;16m"
blue="\e[48;5;25m"
deeppink="\e[48;5;168m"
deepred="\e[48;5;52m"
white="\e[48;5;159m"

input="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/avatar.txt"
echo $input
while IFS= read -r line
do
	for i in $(echo $line | sed -e 's/\(.\)/\1\n/g')
	do
		if [[ $i -eq 0 ]] 
		then
			printf " "
		elif [[ $i -eq 1 ]] 
		then
			printf "${pink} ${no}"
		elif [[ $i = 2 ]] 
		then
			printf "${magenta} ${no}"
		elif [[ $i = 3 ]] 
		then
			printf "${black} ${no}"
		elif [[ $i = 4 ]] 
		then
			printf "${blue} ${no}"
		elif [[ $i = 5 ]] 
		then
			printf "${deeppink} ${no}"
		elif [[ $i = 6 ]] 
		then
			printf "${deepred} ${no}"
		elif [[ $i = 7 ]] 
		then
			printf "${white} ${no}"
		fi
	done
	echo
done < "$input"
