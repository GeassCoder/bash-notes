 # expansions
# brack extension
# equivalent to applying touch on each element in {}
touch {apple,banana,cherry,durian}
# dot extension
touch file{1..10}.txt 	# note that this will sort the files alphabetically instead of numerically 
# in bash 4, padding an 0 in the front could make all the file names of the same length and sorted numerically
touch file{01..10}.txt 		# but it doesn't work on bash 3
echo {1..10} 	# output: 1 - 10
# in bash 4, we can also specify the step
echo {1..10..2}		# output: 1 3 5 7 9, but only works in bash 4
# dot extension also works with letters
echo {A..Z}

# we can use multiple expansions together
touch {apple,banana,cherry}_{1..5}{a..d}		# create 3*5*4=60 files

# redirect the success and error respectively, 0: stdin, 1: success (stdout), 2: error (stderr)
# suppose some of the files in the current directory do not give permission to copy, so some files will raise error while others will be fine
cp -v * ./folder 1> ./success.txt 2> ./error.txt
# &> is a shortcut for both 1> and 2>
cp -v * ./folder &> log.txt 	# both sucess and error are logged in the same file
# 2>&1 also redirects both stdout and stderr to the same place but this is used with |
ls * ./folder 2>&1 | echo
# |& is the same as 2>&1 but 2>&1 is portable to other shells while |& is a shortcut in bash.
# &>> works in the similar way to &>, it appends stdout and stderr to the end of the file instead of overriding the file.
# note: by default, only stdout is piped to |
ls * ./folder | grep grub 	# only stdout is piped to grep, all errors will be displayed via stderr directly
ls * ./folder |& grep grub  	# this will pipe both stdout and stderr to grep

# bash script
bash file.bash
# or put this at the beginning, and including the directory of the bash file into PATH env variable
#!bin/bash
# then file.bash will run also
# if its directory is not included in PATH, ./file.bash will also work
# note: the file extension could be either bash or sh

# quotes for echo
# no quotes: always try to find the stuff based on the bash context, all the keywords and special chars need to be escaped by \
# single quotes: take everything literally, no bash context based interpretation, even if it is an env variable
# double quotes: compromise the previous 2, env variables will still be interpreted based on bash context, but other stuff will be taken literally without needing to be escaped by \; variables can also be escaped by \ which means they will be taken literally
echo hello world! 	# hello world!
echo hello (world) 	# error, ( has special meaning in bash)
# set an env variable
AA=123
echo 'value is $AA. ( parenthisis do not need to be escaped )' 	# $AA is taken literally instead of interpreted based on bash context
echo "value is $AA. ( parenthisis do not need to be escaped )" 	# $AA is interpreted based on bash context
echo "value is \$AA." (using \ will escape the env variable)

# add attributes to variables
# -i: value is of integer type
# -r: value is readonly
# -l: value always converted to lowercase. (this option can only be used on bash 4)
# -u: value always converted to uppercase. (this option can only be used on bash 4)
declare -i d=123 
# when set to a non integer value, it's reset to 0 automatically
d=hello
echo $d 	# output 0
d=3
echo $d 	# output 3
declare -r e=456
e=1 	# error, e is readonly variable
# the 2 below can only be used on bash 4
declare -l f="LOLCats"
declare -u g="LOLCats"

# built-in variables
$PWD
$MACHTYPE 	# machine type
$HOSTNAME 	# system name
$BASH_VERSION
$SECONDS 	# number of seconds the bash session has run (in the terminal, it is how long the terminal has been open; in script, it is how long the script has run; in subshell, it is how long the subshell has been open)
$0 	# name of the script (if used for commands in terminal directly, just return -bash, which is useless)

# command substitution
# it runs the command first, then stores the result of the command into the variable
# this makes programming in bash handy as otherwise we have to store the result in a temp file and when task is completed, we also need to clean up the temp files
d=$(pwd) 	# store the result of pwd (the current directory) in variable d
echo $d
l=$(ls) 	# store the result of ls (the docs in current directory) in variable l
echo $ls

# working with numbers
# note: only works with integers, cannot work with float numbers
d=3.14
echo $d 	# 3.14
e=$((d+1)) 		# error, do not support float numbers
# wrap up the expression into (()) to tell the interpreter you want to do math
# start with $ to assign the result to a variable
# expression inside (()) can use numbers and variables 
d=2
e=$((d+2))
echo $e 	# 4
((e++))
echo $e 	# 5
((e--))
echo $e 	# 4
echo 
((e+=5)) 
echo $e 	# 9
((e*3))
echo $e 	# 27
((e/3))
echo $e 	# 9
((e-=5))
echo $e 	# 4
# note: += can also be used without (()) but it will treat the value as string literal
e=5
e+=2
echo $e 	# 52, not 7
# if it's not in math context, e+=2 and e=e+2 or e=$e+2 are not equivalent.
e=5
e=e+2
echo $e 	# e+2
e=5
e=$e+2
echo $e 	# 5+2
# the other operators (increment, decrement, *=, /=, -=, etc.) only make sense in the (())
e-=3 	# error, -= can only be used in the math context
# **: exponentiation
e=2
d=$((e**3))
echo $d 	# 8
# note: if you want to work with float numbers, use bc
f=$((1/3))
echo $f 	# ouptut 0
g=$(echo 1/3 | bc -l)
echo $g 	# .33333333333333333333