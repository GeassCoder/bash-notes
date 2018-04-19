# short for "disk free space"
df
# -h: humanize, base 1024, the real number
df -h
# -H: bigger number, base 1000, the ads number
df -H

# short for "disk usage"
# better provide a path that we want to look at 
du path
# humanize, this only shows disk usage of directories in the path
du -h path
# this will also show files
du -ah path
# it can specify depth
# this will go only 1 level down the current directory
du -hd 1 ~
# this just go in the current directory
du -hd 0 ~
# note that the sizes du outputs are space allocated for the directories/files, they are not the real sizes, the real sizes can be found by ls -l
du -ah 	# space of blocks allocated to the directories
ls -l 	# real size

# short for "process status"
# by default this only shows the processes owned by me and under my control (so not the background ones)
ps
# this shows all the processes except background ones, including ones owned by root
ps -a
# this is the same as above, as it is a different implementation of ps, and combined to the first implementation for backwards compatibility. 
ps a
# a: show all processes regardless who they are owned by,
# u: show the users explicitly in a separate column, and also show some other process info
# x: show background processes
ps ax
ps aux
# note: 
# VSZ: virtual memory size taken up
# TT: terminal, if showing ? it means the process is os launched

# ps only shows a snapshot of the processes, whereas top is dynamic and up-to-date
# -n: how many to show, by default it depends on the size of the window
# -o: specify order by which property
# -s: refresh rate, by default it refreshes every one second
# -U: filter by user
top -n 10 -o cpu -s 3 -U GeassCoder
# you can also press ? when top is running to see different options

# kill process
kill pid
# force kill
kill -9 pid

# text file helpers
# output 3 number, 1: # of lines, 2: # of words, 3: # of chars
# note: lines are separated by \n, not the same as lines on the screen, so a long paragraph may be one line although it is wrapped up into multiple lines on the screen
wc text_file
# sort doesn't change the original file but only outputs the sorted result on screen
sort text_file
# -r: reverse
# -f: case insensitive
# -u: only display unique items in result, remove duplicates 
sort -rfu text_file

# de-dup immediate duplicates (dups next to each other)
# doesn't change the orginal file
uniq text_file
# -d: only show the duplicates that are immedate dups
# -u: completely remove the lines that are immediate dups

# calendar
cal
# month year
cal 12 2020
# -y: full year
cal -y 2020
# current year
cal -y
# ncal is transposed version of cal
ncal

# bench calculator
bc
# may need to change precision by setting 'scale'
# type 'quit' to quit
# -l: define the standard math library.

# evaluate expression
# bc does heavier calculation, whereas expr does lighter ones
# make sure to put space for args
expr 1 + 1
# make sure escape wildcards
expr 4 \* 2
# error: cannot handle float numbers 
expr 3.14 + 1
# 

# convert units
units

# history
# bash stores all the history commands in ~/.bash_history
# note: bash writes to this history file whenever it quits. So the most recent ones may not present in the history file yet.
# -d: delete a history entry
history -d line_number
# clear all the commands in history
history -c

# shortcuts
# previous command
!!
# args of previous command
!$
# execute previous n command
!-n