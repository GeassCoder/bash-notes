# find path expression
# this will look for someimage.jpg as the exact name
# note that -name is part of the expression, it is part of the argument instead of an option, since it comes after the path; options should always come right after the command
find ~/Documents -name "someimage.jpg"
# allow multiple paths
find ~/Documents ~/Desktop -name "someimage.jpg"

# wildcard chracters
* : 0 or more chars (glob)
? : any one char
[] : any char in the bracket

# 3 chars in extension
find ~/Documents -name "someimage.???"
# any number of chars in extension
find ~/Documents -name "someimage.*"
# someimage1.jpg, someimage2.jpg, someimage3.jpg
find ~/Documents -name "someimage[123].jpg"

# -and -or -not are all valid, -name -path work in the same way
# find any .plist files under home directory but not under *QuickTime* or *Preferences* sub-directories
find ~ -name *.plist -and -not -path *QuickTime* -and -not -path *Preferences*

# -maxdepth option
# search non-recursively, and show hidden files also
find ~ -maxdepth 1 -type f

# on Mac these should be seldom used
# check user
whoami
# check group
groups

# change ownership
# change file owner to user1 (the user name)
chown owner1 file
# change file owner to :group1 (the group name) 
chown :group1 file
# change file owner to user1:group1 (change both user and group at the same time) 
chown owner1:group1 file
# all the above also work for directory; however, this will only change the ownership of the directory itself, its content inside is not impacted
chown owner1:group1 dir
# this will also change the ownership of the directory content
chown -R owneer1:group1 dir
# sometimes need to use sudo, especially when changing ownership to someelse
sudo chown owner2:group2 file

# permissions:
permissions:		file 				directory 
read: 			read content			read content
write: 			change content			change content
execute:		run as program			search inside*
*: can make it a working directory, cd into it and do some stuff to its contents. It usually needs to work with read and write permissions; a standalone execute permission is almost useless. There are some tricky cases also. See these links:
http://unix.stackexchange.com/questions/150449/what-does-execute-permission-on-a-folder-means
http://unix.stackexchange.com/questions/21251/how-do-directory-permissions-in-linux-work

# change permission
# alpha notation
chmod ugo=rwx filename
chmod a=rwx filename # same as above
chmod u=rwx,g=rw,o=r filename
chmod ug+w filename
chmod go-w filename
# also works for directories
# only change permission of the dir itself
chmod g+w dirname 
# change permission of the dir content
chmod -R g+w dirname 

# octal notation, r=4, w=2, x=1
chmod 777 filename
chmode 762 filename

# sudo can specify username to be substituted with option -u
sudo -u linda whoami
# explicitly expire the credential so that next sudo will need type in password for sure
sudo -k

# where is the program of command. Returns all the instances of the command in $PATH.
whereis
# version of command. REturns the instance to be executed when typing in the command.
which
# desc of command
whatis
# or use options
-v, --version, -h, --help

# set env variable
PATH=...
# use $ to read env variable
echo $PATH
# usnet env variable
unset a

# time
date
uptime
time 	# running "time script.sh" will show the time elapsed when executing the script

# de-duplicate users
users
# do not de-duplicate, shows 2 users, 1 is finder (console), 1 is terminal (ttys)
who

# returns os name, which is actually the Mac's "unix" name, Darwin
uname
uname -mnrsvp
uname -ap

# useful if in network env
hostname
domainname
