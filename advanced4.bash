# arguments
# args for bash scripts work in the same way as args for functions
$@: all args 	# can also use $* as $@
$#: number of args

# working with flags
# my.sh
# getopts is a built in command to parse command line args
# u:p: means it wants to look for -u -p options, : after the flag means it expects a value for that flag, if without value it doesn't have to have a trailing :
# $OPTARG is the value for a given option
while getopts u:p: option; do
	case $option in
		u) user=$OPTARG;;
		p) pass=$OPTARG;;
	esac
done
echo "User: $user / Pass: $pass"
# run script
./my.sh -u Jason -p secret 		# "User: Jason / Pass: secret"
./my.sh -p secret -u Jason 		# order doesn't matter

# more info about getopts
# http://wiki.bash-hackers.org/howto/getopts_tutorial

# since ab options don't have : afterwards, they don't need values to be passed in
while getopts u:p:ab option; do
	case $option in
		u) user=$OPTARG;;
		p) pass=$OPTARG;;
		a) echo "Got the A flag";;
		b) echo "Got the B flag";;
 		?) echo "I don't know what $OPTARG is";;
	esac
done
echo "User: $user / Pass: $pass"
# run script with only -a (it's the same with only -b)
./my.sh -u Jason -p secret -a
# output: 
# Got the A flag
# "User: Jason / Pass: secret"

# run script with both -a and -b 
./my.sh -u Jason -p secret -a -b
# output: 
# Got the A flag
# Got the B flag
# "User: Jason / Pass: secret"

# run script with both -a and -b 
./my.sh -u Jason -p secret -b -a -z
# output: 
# Got the B flag
# Got the A flag
# I don't know what $OPTARG is
# "User: Jason / Pass: secret"

# getting input during execution
# read 
echo "what is your name?"
read name

echo "what is your password?"
read -s pass 	# -s for silience, it doesn't show the typed chars

read -p "what's your favorite animal?" animal 	# -p for inline prompt

# select, another command to get user input
# example 1
select animal in "cat" "dog" "bird" "fish"
do
	echo "you selected $animal"
	break
done
# note:
# you should type in the number of the option instead of the option's content.

# example 2
select option in "cat" "dog" "quit"
do
	case $option in
		cat) echo "cats like to sleep.";;
		dog) echo "dogs like to play catch.";;
		quit) break;;
		*) echo "I'm not sure what that is.";;
	esac
done

# make script error tolerant
# example 1
if [ $# -lt 3 ]; then
	cat <<- EOM
	This command requires three args:
	username, userid, and favorite number.
	EOM
else
	# the program goes here
	echo "Username: $1"
	echo "UserID: $2"
	echo "Favorite number: $3"
fi
# example 2
read -p "favorite animal?" a
while [[ -z "$a" ]]; do
	read -p "I need an answer..." a
done
echo "$a was selected."
# example 3
read -p "what year? [nnnn]" a
while [[ ! $a =~ [0-9]{4} ]]; do 	# this is a rought test that checks if $a contains 4 digit integers, so "12345" and "ff2232" will pass while "aabb" and "ff223g1" will not.
	read -p "A year, please! [nnnn]" a
done
echo "Selected year: $a"

# guess a generated random numbeer between 1-10
#!/bin/bash
a=$((RANDOM%10+1))
read -p "A random number in [1, 10] is generated, guess what it is: " x
while [[ $x -ne $a ]]; do
	if [[ ! (($x -gt 0 ) && ($x -lt 11)) ]];
	then
		read -p "You must give me a number between 1 and 10!   " x
	else
		read -p "Your guess $x is not right, keep guessing..   " x
	fi
done
echo "You are right, the number is $a!"