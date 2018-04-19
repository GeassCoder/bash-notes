# comparison
# format: [[ expression ]]
# note: it's important to keep the spaces between the sets of brackets and the expression. The expression returns 1 for failure and 0 for success
# string coparators: < > <= >= == = !=
[[ "cat" == "cat" ]]
echo $? 	# 0 (success)
[[ "dog" == "cat" ]]
echo $? 	# 1 (failure)
# single = also works
[[ "cat" = "cat" ]]
echo $? 	# 0 (success)
[[ "dog" = "cat" ]]
echo $? 	# 1 (failure)
# note: the operands are compared as string literals, so number comparisons will not work
[[ 20 > 100 ]]
echo $? 	# 0 (success), since 20 and 100 are treated as strings "20" and "100"

# number operators: -lt -gt -le -ge -eq -ne
[[ 20 -gt 100 ]]
echo $? 	# 1 (failure), now it's working right

# logic operators: && || !
a=3
b=5
[[ $a -gt $b && 2 -lt 4 ]]
# or 
[[ ($a -gt $b) && (2 -lt 4) ]]
echo $? 	# 1

# operators to test if a string is null or not null: -z -n
# -z: isNull
# -n: isNotNull
[[ -z $a ]]
echo $? 	# 1
[[ -z $c ]]
echo $? 	# 0
d=""
[[ -z $d ]]
echo $? 	# 0
[[ -n $a ]]
echo $? 	# 0

# operators to test files/directories
# success if X is a directory
[[ -d X ]]
# success if X is a regular file
[[ -f X ]]
# success if X exists and not empty
[[ -s X ]]
# success if you have x permission on X 
[[ -x X ]]
# success if you have w permission on X
[[ -w X ]]
# success if you have r permission on X
[[ -r X ]]

# working with strings
# concatinate strings
a="aaa"
b="bbb"
c=$a$b
# get length of a string
echo ${#a} 	# 3
# get substring
d=${c:4} 	# bb
e=${c:2:4} 		# abbb, skip first 2 chars, start from 3rd char and get the next 4 chars
f=${c: -4} 		# abbb, negative means counting backward from the end, note that you must put a space before -
g=${c: -4:3} 	# abb
# replace a substring
fruit="apple banana banana cherry"
# only replace the first occurence
echo ${fruit/banana/durian} 	# apple durian banana cherry
# replace all the occurences
echo ${fruit//banana/durian} 	# apple durian durian cherry
# use # will make the replacement only if the searching string is at the beginning
echo ${fruit/#apple/durian} 	# durian banana banana cherry
# since banana is not at the beginning, the result will be unchanged
echo ${fruit/#banana/durian} 	# apple banana banana cherry
# use % will make the replacement only if the searching string is at the end
echo ${fruit/%cherry/durian} 	# apple banana banana durian
# since banana is not at the end, the result will be unchanged
echo ${fruit/%banana/durian} 	# apple banana banana cherry
# we can also use * 
echo ${fruit/c*/durian} 	# apple banana banana durian

# note: it is suggested to use ${} even $ is sufficient to work
a=123
echo $a
echo ${a} 	# same as above, but considered good programming practice
# benefits:
# 1. this can make things consistent with ${10}, ${arr[2]}, ${a:2} etc.
# 2. this can avoid some ambiguious cases like $foo_$bar.jpg where the fact that _ is also part of the variable name can throw you off

# indirection, go one level deeper
a=b
b=123
# get the value of b via a
echo ${!a}
eval echo \${$a} 	# in general eval should be avoided as js
# note: these will not work
echo ${${a}} 	# error, bad substitution
echo ${$a} 	# error, bad substitution
echo $($a) 	# error, b is not a command
# note: ${!} goes only one level down
a=b
b=c
c=123
echo ${!a} 	# output c

# coloring and styling text
# there are 2 ways to do this
# 1. ANSI escape codes
# use -e for echo to enable the escape sequences
# \033[34;42m is an escaped sequence, m at the end means its end.
# \033[0m is another escaped sequence to reset the colors
echo -e '\033[34;42mColor Text\033[0m'
# example, the 5 in \033[5;31;40m is for styling; the \033[0m clear-up sequence is necessary, otherwise the who message will be blinking
echo -e "\033[5;31;40mError: \033[0m\033[31;40mSomething went wrong.\033[0m"
# refactoring, store the escaped sequence in variables
flashred="\033[5;31;40m"
red="\033[31;40m"
none="\033[0m"
echo -e $flashred"Error: "$none$red"Something went wrong."$none
# 2. tput
# setab: set background color; setaf: set foreground color
flashred=$(tput setab 0; tput setaf 1; tput blink)
red=$(tput setab 0; tput setaf 1)
none=$(tput sgr0)
echo -e $flashred"Error: "$none$red"Something went wrong."$none

# working with date
# checkout other format specifiers on the man page of date
date
date +"%d-%m-%Y" 	# date-month-year
date +"%H-%M-%S" 	# hour-minute-second

# printf
# %s: string specifier, %d: digit specifier, $04d: pad to 4 digit with 0's 
printf "Name:\t%s\nID:\t%04d\n" "Scott" "12"
# http://wiki.bash-hackers.org/commands/builtin/printf

# working with arrays
a=()
b=("apple" "banana" "cherry")
echo ${b[2]}
b[5]="kiwi" 	# allow sparse array
b+=("mango") 	# append an element to the array, make sure to use (), otherwise it will be appended to the first element in the array which is "apple"
b+="peach" 		# the first element will be come applepeach
echo ${b[@]} 	# print out the whole array
echo ${b[@]: -1} 	# grab the last element using negative index, this is the same as strings
# get hte number of elements in the array
echo ${#b[@]}

# associate arrays, only works on bash 4
declare -A myArray 		# declare as associate array
myArray[color]=black
myArray["office building"]="DC5"
echo ${myArray["office building"]} is ${myArray[color]}

# read a file line by line as the input of a loop
i=1
while read f; do 	# f will be each line of the file
	echo "line $i: $f"
	((i++))
done < file.txt

# read can also read lines into multiple variables, 
# format: read a b c ... (can have any number of vars)
i=1
while read a b; do 	# a will be the 1st word of each line, b will be the 2nd word
	echo "line $i: $a $b"
	((i++))
done < file.txt

# command output can be piped to loops also
ls -l | while 
	read a b c d
do
	if [[ -n $c ]]; then
		echo owner is $c
	fi
done

# here document
# allows you to specify input freely up to a specified limit string
cat << EndOfText 	# the limit string can be any string but has to be unique so that it won't appear in the text
This is a 
multiline
text string
EndOfText

# put a dash after << will strip off the leading tabs (only works in bash 4?)
cat <<- EndOfText > file.log 	# can redirect the home doc to a file using >
	This is a 
	multiline
	text string
EndOfText

# work with loop
# every iteration it reads a line of the here doc, and store the tokens of that line in a, b or c
while 
	read a b c 
do
	echo a: $a b: $b c:$c
done << EOF
	one two three four
	five six seven eight nine ten
	eleven twelve
EOF
# output:
# a: one b: two c:three four
# a: five b: six c:seven eight nine ten
# a: eleven b: twelve c:
