#!bin/bash 
(
	cd $1;
	for FILE in $(find . -maxdepth 64 -type f);
	do
		cat $FILE| tr '[A-Z]' '[a-z]' |tr ' \t' '\n\n'|sed -e "/^$/d" |sort |uniq ;
	done | sort | uniq -c | sort -nr
)

