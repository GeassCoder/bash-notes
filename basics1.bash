# suppress new line
echo -n “hello”

# -n will suppress the new line at the end of the output
# “;” terminate a command; output “hello world”
echo -n “hello”; echo “world”
# -e will escape \t \n etc.
echo -e "hello\t\tthere\n"

# login shell
echo $SHELL

# working shell
echo $0

# switch shells
sh 	# get in "Bourne Shell"
echo $SHELL 	# output "Bash"
echo $0 	# output "sh"
csh 	# get in "C Shell"
echo $SHELL 	# output "Bash"
echo $0 	# output "csh"
exit 	# exit C Shell
echo $0 	# output "sh"
exit 	#exit Bourne Shell
echo $0 	# output "bash"

# -k: abbreivated desc, same as apropos
# e.g.
man -k banner
apropos banner
# it also does keyword searching
# searches the database of all the commands that contain string "ban", so if you want to search for commands related to something, this is the way to go
man -k ban  	# output 2 results
# whatis also outputs abbreviated desc of the command
whatis banner
# but doesn't do keyword search
whatis ban 		# no valid command found
# if you want to store man page in a file, use col -b to not output any backspaces, otherwise the format will be messed up
man ls | col -b | file.txt


ls -a 	# display all the stuff, including hidden ones, .ssh, .DS_Store, etc.
ls -l 	# long/descriptive
ls -h 	# display size in human-readable format, useful when used with -l 
ls -lah
ls -1 	# force output to be one entry per line.
ls -d 	# directories are listed as plain files (not searched recursively)
# example
ls -d __** 		# display all the files/directories starting with __ in the current directory

# .DS_Store stores info about how the files are displayed in finder
 
# touch changes access and modification times if the file exists
# but it creates new a new file if the file doesn't exist
touch file_name

# cat concatinate multiple files
cat file1 file2
# but it just displays the file if only one file is fed
cat file
# some useful options: -n, -b, -s

# more = less on OS X
# but on origianl unix less is more efficient than more and supports backword movement
more file1
less file1
# some useful options: -N, -M, -m

head file
tail file

# -p: create parent paths when needed 
mkdir -p folder1/folder2/folder3/file

# -n: no overwriting
# -f: force overwriting, default
# -i: interactive
# -v: verbose
cp source_file target_file

# -R: recursive copy, used for directory, 
# by default it doesn't allow to cp directory
cp dir1 dir2 	(directory not copied)
cp -R dir1 dir2 	(directory copied)
cp -r dir1 dir2 	(same as -R)

# remove file
rm file
# remove directory
rm -R dir
rm -r dir
rm -rf dir
