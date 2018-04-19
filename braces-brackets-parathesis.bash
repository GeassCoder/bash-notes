{}	# create expansion
	{1..10}
	{1..10..2}
	{a,b,c}

()	# create array
	r=(a b c) 
	r[0]=aa
	## may need to use with $ to retrieve values
	${r[2]}
	${r[@]}
	${b[@]: -1}
	# another way to use () is to open another process

[]	# evaluate bool
	## simlar to [[]]


{{}}

(())	# do math
	((1+2))
	## may need to use with $ to retrieve values
	a=$((3+2))

[[]]	# evaluate bool
	## more powerful than [], e.g. support regex, etc.
	[[ $a > $b ]]
	[[ $c = $d ]] # same as ==
	[[ 5 -gt 3 ]]
	[[ $a -gt $b && 2 -lt 4 ]]

$()		# save result of a command or a function call into a variable
	$(command)
	$(func args)

${} 	# process string
	${a} ## same as $a
	${#a}
	${a:4}
	${a:2:4}
	${a: -4}
	${a: -4:2}
	${a/str1/str2}
	${a/#str1/str2}
	${a/%str1/str2}
	${a/str1*/str2}
	${!a}