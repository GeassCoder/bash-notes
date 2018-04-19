# if b.txt doesn't exist, create it
# if b.txt exists, override its content
sort a.txt > b.txt
# use >> to append, or may use cat and > to achieve the same goal
sort a.txt >> b.txt
# this will empty file.txt
> file.txt

# get content of the file and use as input
sort < a.txt

# another example, can be simplified by using |
echo "(3*4)+(11*37)" > temp.txt
bc < temp.txt
rm temp.txt

# redirect both input and output
sort < a.txt > b.txt
# note: the thing after > or < must be file name

# pipe: redirect the output of a command to another command
# note: the thing after | must be a command
echo "hello world" | wc
# simplified example, see above 
echo "(3+4)+(11*37)" | bc
# can be chained
cat a.txt | sort | uniq > b.txt
sort < a.txt | uniq > b.txt
# this can be useful, view processes page by page (could crash though...)
ps aux | less

# suppress output
# /dev/null means the "null device", "bit bucket", or "black hole"
# unix discards any data sent there
ls -la > /dev/null
ps aux > /dev/null

# display all aliases
alias
# define an alias
alias ll="ls -lahG"
# remove alias
unalias ll

# env variables, $ is used to retrieve the value
MYNAME="Jason Li"
echo $MYNAME
# we have to use "" instead of '' when using $ to pull in the variable as below
export PATH="usr/local/bin:$PATH"
# if use '' it will take it literally and look for directory called bin:$PATH which doesn't exist

# export and declare -d will make the variable available to the subshell and subprocesses
a=123 	# suppose a is defined in the terminal, but it will not be available to a sub bash shell or a script that has been run by ./myScript.sh, to make it available we have to export it or use declare -d as below
export a=123
declare -d a=123

# export -f can export a function
export -f myFunc

# note: exported variables are just copied instead of shared to the subprocesses 

# export and env
export 	# show all the exported variables
env 	# show all the env variables

# customize prompt
PS1

# short for global regular-expression print
# grep can only search, it can't make changes to the matches of the search
# returns the lines that contain the match (contain string "apple")
grep apple fruit.txt
# the above is case sensitive match
# if want case insensitive, use option -i
grep -i apple fruit.txt
# only match apple as a whole word, so a line "pineapple" will not be matched
grep -w apple fruit.txt
# reverse match, or filter out
# find lines that do not contain "apple" as a sub-string
grep -v apple fruit.txt
# output line numbers with the matches
grep -n apple fruit.txt
# only output the count of the matches
grep -c apple fruit.txt
# only output the matching lines, do not display the file names of the matches
grep -h apple fruit.txt
# only output the file names of the matches 
grep -l apple fruit.txt

# can also be used on directories, but need to use -R for recursive
grep -R apple ~
# can also use with wildcards
grep apple *fruit.txt
# can also use with pipe
cat fruit.txt | grep apple
# another example
ps aux | grep Terminal
# can also color the matches using --color
grep --color apple fruit.txt

# use grep with regex
# same as regex in js
# but also has some classes like [:upper:], [:lower:], [:punct:], etc.
# this will not work, since it just matches chars in the bracket
echo "AaBbCcDdEe" | grep --color [:upper:]
# this will work since double brackets will make the stuff be treated as a class
echo "AaBbCcDdEe" | grep --color [[:upper:]]
# make sure to use option -E when using js-like regular expressions
# this will not work since it will look for "ap+le" literally
echo "a app apple pineapple pp pa" | grep "ap+le"
# this will work
echo "a app apple pineapple pp pa" | grep -E "ap+le"