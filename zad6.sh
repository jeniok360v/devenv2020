#!bin/bash 
NEWLINE=$'\n'
(
	cd $1/ ;
	wordsStr=$( cat  $(find . -maxdepth 64 -type f)  |tr '[A-Z]' '[a-z]' |tr ' \t' '\n\n'|sed -e "/^$/d" |sort |uniq | tr '\n' ' ' )
	words=($wordsStr)

	filesStr=$(find . -maxdepth 64 -type f)
	files=($filesStr)

	declare -a wordlist

	for((j=0;j<${#files[@]};j++))
	do
		for((k=0;k<${#words[@]};k++))
		do
			tmp=$(grep -o -i ${words[k]} ${files[j]} | wc -l)
			tmp2=$(grep -n -i ${words[k]} ${files[j]})
			if [ $tmp -ge 2 ]
			then
				if [  wordlist[k]=="" ]
				then
					wordlist[k]=${words[k]};
				fi
				wordlist[k]="${wordlist[k]} ${files[j]}: ${NEWLINE}$tmp2${NEWLINE}"
			fi
		done 
	done

	printf '%s\n' "${wordlist[@]}"
)

