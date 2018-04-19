# if
# all the formats below are valid
if [ condition ]; then
	#statements
fi

# when condition needs to use regex [[]] should be used, [] is not sufficient
if [[ condition ]]; then
	#statements
fi

# (()) can be used only when condition is about an integer comparison
if (( condition )); then
	#statements
fi

if condition ; then
	#statements
fi

if condition
then
	#statements
fi

# with else
if condition
then
	#statements
else
	#statements
fi

# with elif
if condition
then
	#statements
elif condition; then
	#statements
fi

# loops
i=0;
while [ $i -le 10 ]; do
	echo i: $i
	((i++))
done

# until loop is the counterpart of while loop
j=0;
until [ $j -ge 10 ]; do
	echo j: $j
	((j++))
done

# for loop
for i in 1 2 3
do
	echo $i
done

for i in {1..100}
do
	echo $i
done

for (( i=0; i<=10; i++ ))
do
	echo $i
done
# work with array
arr=("apple" "banana" "cherry")
arr[3]="pear"

for i in ${arr[@]}
do
	echo $i
done
# work with associate arrays, but only on bash 4
declare -A arr
arr["name"]="Jason"
arr["id"]="123"
for i in "${!arr[@]}"
do
	echo "$i: ${arr[$i]}"
done
# work with commands
for i in $(ls)
do
	echo "$i"
done
# for loop can access folders/files directly
# this is the same as ls
for i in *
do
	echo $i
done
# list all the file whose names are of format "* *" in the current directory 
for i in *\ *
do
	echo $i
done
# note:
# 1. This only works when there exists at least one file/folder whose name is of format "* *", otherwise it will just echo all the files/folders.
# 2. If the space in "* *" is not escaped, ti will just echo all the files/folders in . twice.

# access folders/files in a different directory 
for i in ../*
do
	echo $i
done

# case
a="cat"
case $a in
	cat) echo "Feline";;
	dog|puppy) echo "Canine";;
*) echo "No match";;
esac

# functions
function greet {
	echo "Hi there!"
}
greet
# call function with args
# note: when the number of args is greater than 10, we need to put the number in {}, like ${10}
function greet {
	echo "Hi $1"
}
greet Jason

# shift positional params
shift moves $2 into $1, $3 into $2, etc.

# access all the args
function foo {
	i=1
	for f in $@; do
		echo $i: $f
		((i++))
	done
}
foo $(ls)
# local vs global variables
a=123
b=456
function foo {
	loc a=111
	b=444
}
foo
echo $a 	# 123
echo $b 	# 444
# return value from function
# method 1
function foo {
	local a=1+2+3
	echo $a 	# echo out the variable to be returned
}
b=$(foo) 	# accept the echoed out variable
c=$(foo args) 	# can pass in args as well

# method 2
function foo {
	loc a=1+2+3
	return $a 	# return will set the error code of the function call
}
foo
b=$? 	# retrieve returned variable from error code

# exit command
exit 123  	# similar as return, exit also sets the exist status, represented by $? 
# but exit terminates the whole shell process, not just the function


