#!bin/bash
(
	cd $1 ;
	cat  $(find . -maxdepth 64 -type f)  |tr '[A-Z]' '[a-z]' |tr ' \t' '\n\n'|sed -e "/^$/d" |sort |uniq -c |sort -nr
)