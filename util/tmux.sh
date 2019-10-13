#!/bin/bash
envir=""
sbash="source ~/.bashrc"
n=${1:-1}
argcm=${2:-""}

tmux new-session -d

i=0 # counter, for 8 windows, i will be in range(0, 2)
c=0 # counter
t=0 # the panel number
l=1 # the limit of 1,2,4,8,16... sequence
while [ $i -lt `expr $n - 1` ];
do
	if [[ $c -ge $l ]]
	then
		let c=0
		let t=0
		let l=l*2
	fi
	if [[ $i -lt $((($n - 1) / 2)) ]]
	then
		tmux split-window -d -t $t -h
	else
		tmux split-window -d -t $t -v
	fi
	let i=i+1
	let c=c+1
	let t=t+2
done

images=("kirby" "creeper" "darksouls" "metaknight" "enderman")
let i=0
while [ $i -lt $n ];
do
	tmux send-keys -t $i "$envir" C-m
	tmux send-keys -t $i "$sbash" C-m
	color=`expr 41 + $i % 6`	
	tmux send-keys -t $i "echo -e \"\e[${color}mThis is panel ${i}! \e[0m\"" C-m
	path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/avatar/animation.sh"
	tmux send-keys -t $i "$path ${images[`expr $i % 5`]}" C-m
	tmux send-keys -t $i "$argcm" C-m
	let i=i+1
done

tmux -2 attach-session -d
