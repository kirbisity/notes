# UNIX

[Back](README.md)

List of contents

* [Basic commands](#basic-commands)
* [Shell](#shell)

## Basic Commands

Basic commands and their commonly used options. Look up man for more info.

* `man -s <number>`   search for something in man page

  * 1: User Commands
  * 2: System Calls
  * 3: Library Calls
  * 4: Special Files
  * 5: File Formats and Conventions
  * 6: Games et. al
  * 7: Miscellaneous
  * 8: System Administration tools and Daemons

* `ls`  list files

  * `-i`  list files with i-node
  * `-l`  long listing, including file mode
  * `-d`  list directory without contents
  * `-a`  list hidden files

* cat  read file and writes to output

* echo  output argument string to destination

  * e.g. `  echo "hello world" > file1`  write text to file

* `pwd`  current working directorry

* `mkdir`  make directory

  * `-p`  create intermediate sub-directories if not exist

* `rm`  remove

  * `-r`  remove recursively
  * `-f`  remove forcefully

* rmdir  remove empty directory

* `sort`  print input lines (from file) sorted

* `cp`  copy files or directories

* `mv`  move/rename files

* `ln`  hard link

  * e.g. `ln f1 f3`  let f3 point to the same i-node as f1
  * `* -s`  symbolic link, similar to short cut

* `chmod`  change file mode

  * e.g. `chmod a=r fileA`  all user read permission
  * e.g. `chmod a+x,u+x fileA`  all user add execute permission, user can write
  * e.g. `chmod 754 fileA`  change file mode to `-rwxr-xr--` ( 111  101  100 = 754)

* `umask`  current default permission, add `umask` command to `.profile` to change default

  * e.g `umask 022`  change umask value

* `chown`  change file's UID and GID

* `chgrp`  change file's GID

* `ps`  display information about running process

* Process controls

  * ^Z suspends a foreground job
  * ^C terminates a foreground job
  * fg resumes suspended job in the foreground
  * bg resumes a suspended job in the background
  * jobs lists active jobs
  * stop suspends a background job
  * kill sends a signal to a job

  [Back To Top](#unix)

## Shell

* metacharacters
  * Wildcards * ? []
  * $ substitutes variables values
  * \ quotes next character only
  * " " prohibits wildcards and single quotes, but allow variable substitution
  * ' ' prohibits wildcards, double quotes, command and variables substitution
  *   and $ substitutes a command for its results
* `alias`  replace a command with abbreviation
  * e.g. `alias lsl='ls -l'`
* I/O redirect
  * `ls -l > listingFile`  redirect output
  * `cat < index.md`  redirect input
  * `ls -l 2> errorFile`  redirect stderr
  * `ls -l > listingFile 2>&1`  redirect output and stderr to same file
* Complex commands and Sub-shells
  * `sleep 1; date`  sequential composition, commands run in order
  * `touch me & touch you`  parallel composition, commands run at the same time
  * `mkdir home && cd home`  conjunctive composition, next command only runs if previous command is run
  * `sleep you || rm you`  disjunctive composition, next command only runs if previous command is unsuccessful
  * `(date; mkdir home && cd home; touch you & touch me; ln you me; sleep 1) > out`  group commands
* `grep`  search for files for a specific regular expression
  * e.g. `grep 'RE'` file search for all lines with RE
  * `-v`  only display lines not matching the RE
  * `-i`  case insensitive search
  * `-n`  display the line numbers where matches were found
  * `-l`  list the filenames where matches were found
  * Anchors
    - e.g. `grep '!$' fileA`  list lines ending with !
    - `^`  beginning of line
    - `$`  end of line
  * Character classes
    * `[0-9]` or `[[:digit:]]`  any digit
    * `[a-z]` or `[[:lower:]]`  lower case letters
    * `\w`  word character
    * `\s`  white space
* Filter
  * `head -5 fileA`  get first 5 lines 
  * `tail -5 fileA`  get last 5 lines
  * `cat fileA | head -5`  cat file, pipe to next command to get first 5 lines
* `cut`  remove certain fields from a file
* `sed`  filter and transform text
  * `sed -n '6,9p' fileA`  print line 6 - 9 of fileA
  * `sed '/[0-9]/d' fileA`  delete all the lines from file which contain digits
* `tr`  translate character from input to output
  * `tr 'aeiou' 'AEIOU' < fileA`
  * `tr -d 'aeiou'`  delete characters

[Back To Top](#unix)

## Shell Scripting

* `./script.sh`  run a shell script

* condition

  ```sh
  if [<condition>]
  then 
  	<commands>
  elif [<condition>] 
  then 
  	<commands>
  else 
  	<commands>
  fi
  ```

* loop

  ```sh
  for x in <list>
  do
  	<commands>
  done
  ```

  ```sh
  while <condition>
  do
  	<commands>
  done
  ```

* command line arguments
  * `$0`  script name
  * `$1` - `$9`  first 9 arguments
  * `shift`  removes and argument, shift other by one to get remaining arguments
  * `$#`  number of command line arguments
  * `$-`  options in effect
  * `$?`  exit value of last executed command
  * `$$`  process id of current process
  * $!  process id of last background process
  * `$*` or `$@` or `"$*"` or `"$@"`  all command line arguments combined