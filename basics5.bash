# short for translate
# tr searching_str replacement_str
echo 'a,b,c' | tr ',' '-' 	# outputs 'a-b-c'
# note: it maps each char in the searching_str into the corresponding char in the replacement_str
echo "1425223" | tr "123456" "EBGDAE" 	# outputs EDBABBG, so 1 is mapped to E, 2 mapped to B, etc.
# it also allows the use of -
echo "This is ROT-13 hashed." | tr "A-Za-z" "N-ZA-Mn-za-m"
# the example below will map b to x, and map everything else in the searching string to z
echo "abcd1234eeeef56" | tr "bedf5-9" "xz"
echo "abcd1234eeeef56" | tr "bedf5-9" "xzzzzzzz" 	# same 
# we can also use tr with regex classes
tr '[:upper:]' '[:lower:]' < a.txt
tr 'A-Z' 'a-z' < a.txt
# replace commas with tabs
tr ',' '\t' < a.csv > b.tsv

# tr can also be used for deleting and squeezing chars
# options:
# -d: delete chars in listed set
# -s: squeeze repeats in listed set
# -c: use complementary set
# -dc: delete chars not in listed set
# -sc: squeeze chars not in listed set
echo "abc1233deee567f" | tr -d [:digit:] 	# abcdeeef, delete all digits
echo "abc1233deee567f" | tr -dc [:digit:] 	# 1233567, delete all non-digits
echo "abc1233deee567f" | tr -s [:digit:] 	# abc123deee567f, squeeze all digits
echo "abc1233deee567f" | tr -sc [:digit:] 	# abc1233de567f, squeeze all non-digits
echo "abc1233deee567f" | tr -ds [:digit:] [:alpha:] 	# abcdef, first class for delete, second class for squeeze
echo "abc1233deee567f" | tr -dsc [:digit:] [:digit:] 	# 123567, option c only applies to delete
# practical use cases
# remove non-printable chars from file1 and output to file2
tr -dc [:print:] < file1 > file2
# remove surplus carriage return and end of file character, these chars are usually used in windows os and so removing them will make them compatible with mac os or unix
tr -d "\015\032" < window_file > unix_file
# remove repeated spaces from file1
tr -s ' ' < file1 > file2

# short for stream editor, it modifies a stream of input according to a list of commands before passing it on to the output.
# format: sed 's/a/b/', where s means substitution, a is search string, b is replacement string
# note: it's not the same as tr given that it doesn't translate/map the chars one by one, instead it replace the search string with the replacement string entirely
echo 'upstream' | sed 's/up/down/'
# note: by default it doesn't search/substitute globally, so the example below will only replace the first occurence
echo 'upstream and upward' | sed 's/up/down/' 	# output "downstream and upward"
# use g option in the regex to search/substitue globally
echo 'upstream and upward' | sed 's/up/down/g'	# output "downtream and downward"
# note: other separators other than / can also be used in the regex, such as : or | 
# so these work in the same as above
echo 'upstream and upward' | sed 's:up:down:g'
echo 'upstream and upward' | sed 's|up|down|g'
# this could be useful in some cases where the original string contains /
# using | is cleaner in the example below
echo "Mac OS X/Unix: awesome." | sed "s|Mac OS X/Unix:|sed is|" 
# otherwise we have to use \/ to escape the /, so this gives the same result
echo "Mac OS X/Unix: awesome." | sed "s/Mac OS X\/Unix\:/sed is/"
# it can also work with files directly
sed "s/pear/mango/" fruit.txt
# using the redirect also works
sed "s/pear/mango/" < fruit.txt
# note: sed can work with files directly whereas tr cannot, tr has to work with < 
# note: sed treats each line of the file as a stream, so even without /g at the end of regex, it will still go through every line of the file, but will only substitute the first occurence of every stream/line

# sed can also substitue multiple things in one shot with the -e option, -e is for edit
echo "During daytime we have sunlight." | sed -e "s/day/night/" -e "s/sun/moon/"
# it can also substitue multiple things without using -e option
echo "During daytime we have sunlight."  sed "s/day/night/; s/sun/moon/"

# sed works with regex as grep
echo "Who needs vowels?" | sed "s/[aeiou]/_/g"
echo "Who needs vowels?" | sed -E "s/[aeiou]+/_/g" 	# since it uses + we have to use -E to enable extended features
# sed works with capturing parenthisis
echo "daytime" | sed -E "s/(...)time/\1light/"
echo "daytime" | sed "s/\(...\)time/\1light/" 	# if not having -E the capturing parenthisis need to be escaped
# this trick can also be used to swap two words
echo "Dan Stevens" | sed -E "s/([A-Za-z]+) ([A-Za-z]+)/\2, \1/"

# sed can run a script that is composed of commands for sed on a given (text) file
# sedscript
s/a/A/
s/B/BBB/
# file.txt
now we have
some words and
fruit like apple cherry orange peach
and BIG things like
cruise ship, skyscraper, Bigfoot
# run this will apply the sed commands in sedscript on the text in file.txt
sed -f sedscript file.txt

# cut, can cut chars and fields
# cut 2-10 chars of the fed input
echo "abcdjiaowejg;aij" | cut -c 2-10
# cut 2-10 chars of each line in file
cut -c 2-10 file

# it can also cut multiple parts
# cut 3 columns of the file
cut -c 2-10,30-35,49- file
# by default take tabs as delimiters
cut -f 2,6 a.tsv > b.tsv
# if you want to change the dilimiter, use -d option
cut -f 2,6 -d "," a.csv > b.csv

# diff
# format: diff file1 file2

# comparison options: 
# -i: case insensitive
# -b: ignore changes to blank chars
# -w: ignore all whitespace
# -B: ignore blank lines
# -r: recursively compare directories
# -s: show identical files

# output formats options:
# -c: copied context
# -u: unified context
# -y: side by side
# -q: only whether files differ