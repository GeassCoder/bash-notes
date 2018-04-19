# short for "execute as arguments"
wc filename
# this will not work as expected because wc will take "filename" as a string literal
echo "filename" | wc
# instead, we can use xargs to tell wc to treat "filename" as an argument (in this case, the name of the file, instead of the string literal)
echo "filename" | xargs wc 		# same as wc filename
# we can see what it does under the hood by using -t option
echo "filename" | xargs -t wc
# these 2 below are equivalent
echo "file1 file2" | xargs -t wc
wc file1 fiel2
# we may not want to apply the command on all hte arguments together, instead we want to loop through the arguments and apply the command on each of them respectively, then use -n option to specify how many args to be passed to the command each iteration of the loop
echo "file1 file2" | xargs -t -n1 wc
# the above is equivalent to 
wc file1
wc file2
# -n
echo 1 2 3 4 | xargs -t -n2 	# pass 2 args each loop, since there is no command, it will just display the args each loop
ls | xargs -n3

# by default xargs -n uses spaces and new lines as separators for the args
# suppose in the current directory there are 2 files "file 1" and "file 2"
# this may not give the result as expected
ls | xargs -n1
# output:
# file
# 1
# file
# 2

# option -0 tells xargs -n to use null char as separators instead of spaces and new lines
# use -I option to use placeholders 
# this will give a different output
ls | xargs -0 -n1
# ??? -0 and -n may not work together, this gives the same result
ls | xargs -0

# output:
# file 1
# file 2

ls | xargs -I {} echo "haha: {}"
# use other symbols to indicate placeholders
ls | xargs -I :stuff: echo "haha: :stuff:" 		# works in the same way as above 

# practical uses
# this will concatinate all the files in the current directory (suppose file names don't contain spaces...)
ls | xargs cat | less
# when file names contain spaces, it gets tricky
#??? -0 and -n may not work together,this doesn't work as expected
ls | xargs -0 -n1 cat 
#  this works as expected since -0 and -print0 are expected to work together
find . -maxdepth 1 -and -not -name ".*" -print0 | xargs -0 cat
# or 
find . -depth 1 -and -not -name ".*" -print0 | xargs -0 cat

# this creats a folder under ~/Desktop/fruits for each entry in the file
cat fruit.txt | sort | uniq | xargs -I {} mkdir -p ~/Desktop/fruits/{}

# chmod all files in test1/ directory
# the -print0 special option of the find command ensures the result to be separated by null char, this special option is usually used with -0 option of xargs 
find test1/ -type -f -print0 | xargs -0 chmod 755

# copy all the *fruit.txt files in the current directory to ~/Desktop/ directory and rename them by appending .backup extension
find . -name "*fruit.txt" -depth 1 -print0 | xargs -0 -I {} cp {} ~/Desktop/{}.backup

# search in all the *fruit.txt files in the current directory and all the sub-directories for string "programming", and display the files containing "programming" in the result
find . -name "*fruit.txt" -print0 | xargs -0 grep -li "programming"

# other examples
find ~/my_website/ -name "*.html" -print0 | xargs -0 grep -l "<h3>"

# mac-only commands and techniques
# open
# -a: specify which app to use to open the file
# -f: specify the input from stdin instead of a file
ls -la | open -f
# both below should work
cat urls.txt | xargs -n1 open
cat urls.txt | open 

# pb is short for paste-board
ls -lah | pbcopy
cut -f 2,6 us_presidents.csv | pbcopy
pbcopy < a.txt

pbpaste
pbpaste > b.txt
alias pbsort="pbpaste | sort | pbcopy"

# there are 4 clipboards in unix: general, find, font, ruler
# use -pboard option to switch the clipboard
# by default (without -pboard option) it uses the general clipboard
# in browsers, command + f uses the find clipboard
# use general
echo 1 | pbcopy
pbpaste 	# output 1
# this is the same as not using -pboard at all
echo 2 | pbcopy -pboard general
pbpaste 	# output 2
# use find
echo 3 | pbcopy -pboard find
pbpaste -pboard find 	# output 3
pbpaste 	# output 2 still as -pboard option is not used and so it defaults to the general
# use font
echo 4 | pbcopy -pboard font
pbpaste -pboard font 	# output 4
pbpaste 	# output 2 still
# use ruler
echo 5 | pbcopy -pboard ruler
pbpaste -pboard ruler 	# output 5
pbpaste 	# output 2 still

# screen capture
# by default it's like command+shift+3 and the saved image is of png format
screencapture img.png
# -i: interactive mode, just like command+shift+4, click esc to cancel
screencapture -i img.png
# -m: main monitor only, by default Mac captures all the monitors if there are mulitple monitors
# -C: show cursor, by default the cursor is not shown in the screen capture.
# -t: specify the format of the saved picture (png, pdf, jpg, tiff)
# -T: delay in seconds, wait a few seconds before taking the screen shot 
screencapture -T 5 img.png
# -P: open file with preview
# -M: open file in mail message
# -c: capture directly to clipboard
