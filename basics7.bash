# save everything before trying this out!!!
# require sudo
# options: 
# h: halt at specified time
# r: reboot at specified time
# s: sleep at specified time
# time format
# now, +minutes, yymmddhhmm

# shutdown examples
sudo shutdown -h now
sudo shutdown -h +45
sudo shutdown -h 2106010000 	# shutdown on June 1, 2021 at midnight

# reboot examples
sudo shutdown -r now
sudo shutdown -r +45
sudo shutdown -r 2106010000 	# reboot on June 1, 2021 at midnight

# sleep examples
sudo shutdown -s now
sudo shutdown -s +45
sudo shutdown -s 2106010000 	# sleep on June 1, 2021 at midnight

# there is a built-in sleep command but it is completely different from making the computer sleep, it will just wait for a given number of seconds
# wait for 3 seconds and do nothing, then give back the control
sleep 3

# show the current tty id
tty

# text to speech
say "unix is awesome"
# use -v option to change the voice, this can also be done from finder by command+shift+u
say "hello" -v Vicki
say "hello" -v Fred
say "hello" -v Whisper
say "hello" -v Zarbox

echo "dum dee dee dum " | say -v Bells
# it can also work with a file
cat a.txt | say
# or use the -f option, it's equivalent to the above
say -f a.txt

# output audio as aiff file using -o option
say -f a.txt -o audio.aiff

# alert when actions complete
cp -R dir1 dir2; say "directory copy done"

# use spotlight from command line, searching metadata.
# short for meta-data find
mdfind "new"	# this is the same as searching for "new" in spotlight
# use -onlyin option to narrow down the searching area
mdfind -onlyin . "new"		# search only in the current directory for "new"
# it also supports negation of the searching keyword
mdfind -onlyin . "new -join" 	# exclude results that contain "join"
# you can also specify the searching is only about the name by using -name option
mdfind -onlyin . -name "new"
# it also supports -0 option with xargs
mdfind -onlyin ~/unix_files/ -name "new" -0 | xargs -0 open 	# open each result

# short for meta data listing
# show all the metadata of the file
mdls file
