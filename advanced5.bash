# () can open up another process while {} will not
a=1
(a=2)
echo $a 	# 1
b=1
{b=2}
echo $b 	# 2

# enable will list all the built in commands
enable

# time can timing a process, output real elpased time, time spent on user space, and time spent in kernel
time sleep 2

# source a file
source file.sh
. file.sh 	# same as above
# note: the shell excutes the script in the shell's own process instead of in a new process; so sourcing is a common way to import variable assignments or function, which is kinda opposite of export

# let allows for convenient arithmetics, same as $(())
let x++
let x=x**2

# typeset and declare are the same but the former is more portable (e.g. also can be used in ksh, etc.) while the latter is more preferable in bash; 
# when use in functions, declare, typeset and local will all make the defined variable a local variable.

# seq generates a sequence of numbers
seq 1 5 	# 1 2 3 4 5, each number is on its own line
# this is the same as using expansions except all numbers are on the same line
echo {1..5} 	# 1 2 3 4 5, all numbers are on the same line in the result
echo {1..5} | xargs -n1 echo 	# this will fix it
# and vice versa this will output all numbers on the same line
seq 1 5 | xargs echo

# you can also specify the step for seq
# format: seq start step end
seq 1 2 10 		# 1 3 5 7 9

# seq used with loops
for num in `seq 1 5`
# same as 
for num in {1..5}
# or
for num in $(seq 1 5)
# backquote here is like $(), but it's deprecated in favor of $() because $() can more easily nest the commands like $($(...))

# nl: line number a file
nl a.txt

# file descriptor (fd)
# exec: execute a command, but when used with fd and file, it means open the file with the given fd number
# lsof: list what file descriptors for a process are open
# $$ is the pid of the current shell
exec 19<data_file 	# associate fd 19 with data_file for input
lsof -p $$ 	# show all the files the current process has opened, including fd's
cat 0<&19 	# have stdin be whatever fd 19 refers to
exec 7>&1 	# open up fd 7 as the same thing as where stdout refers to right now
exec 1>&- 	# closes stdout
lsof -p $$ 	# show some output, but since stdout is closed, there is no way to direct the output stream, so it will do nothing unless there are error msg.
cat 	# no stdout now
exec 1>&7 	# copy 7 back to stdout
cat

# background process
# makeoutput.sh
for i in {1..100}
do
	read a b c d e << END
		$(date)
	END
	echo $d
	sleep 1
done
# use & at the end to make it a background process
./makeoutput.sh >output &
# -f means follow the file
# -n5 means print the last 5 lines of the file
# so this will follow the last 5 lines of the output file on the fly
tail -n5 -f output

# use \ to keep it as if in one line
ps -el | \
grep "this is a very long string" | wc -l
# the above is equivalent to 
ps -el | grep "this is a very long string" | wc -l

# ternary operator
x=2
(( y= x==2 ? 1 : 0 ))
echo $y 	# 1

# use :- to specify default value of a variable
# the return value is Hotdog if var is unset or null, otherwise it will be var
unset x
a=${x:-Hotdog}
echo a is $a 	# a is Hotdog
echo x is $x 	# x is 

# use := to assign value to a variable if that variable is unset or null
unset x
a=${x:=Hotdog}
echo a is $a 	# a is Hotdog
echo x is $x 	# x is Hotdog

# use :? to stop a script and display an error if a variable is unset or null
unset x
a=${x:?} 	# error: x: parameter null or not set
echo Will not get here 		# since it has raised an error on the previous line, it would not get here

# :+ returns nothing if the variable is unset or null, while return the variable value if that variable is set

# work with string
${str:offset} 	# get substring starting from offset
${str:offset:len}	# get substring starting from offset up to length len
${#str} 	# get length of str
${var#pre} 		# remove prefix pre
${var%post} 	# remove suffix post
# example of removing prefix and suffix
p="/usr/local/bin/hotdog.sh"
echo ${p#/*local/} 	# bin/hotdog.sh
echo ${p%.sh} 	# /usr/local/bin/hotdog
# is there a way to remove both prefix and suffix together???

# debug scripts with -x and -u
# -x: echo commands after processing; can also do set -x and set +x inside of script
bash -x script.sh
# -x in the script will turn on the feature of displaying every command while +x will turn it off

# -n: do not execute commands, check for syntax errors only
bash -n script.sh
# -u: report usage of an unset variable (a variable that is not assigned a value but used somewhere)
# in debug1.sh
#!bin/bash
set -u 
set -x
a=1
echo my PID is $$
set +x
b=2
set -x
echo a is $a b is $b c is $c

# redirect output to multiple files, copies stdin to stdout and any files given as args. This is useful when you want not only to send some data down a pipe but also to save a copy.
ps -ax | tee processes.txt | more

# trap, used for signal handling
# 1. change behavior of signals within a script
# 2. ignore signals during critical sections in a script
# 3. allow a script to die n 
# 4. perform some operations when a signal is received
# control + c: interrupt signal, INT (terminate the whole shell script)
# control + \: quit signal, QUIT (terminal the current command in execution)

# note: 
# 1. if empty string is provided to the trap, the signal will just be ignored
# 2. it allows nested trap, e.g. set the command to do for the next trap though the first trap does not do anything explicitly.

# show all the signals on the OS
kill -l 