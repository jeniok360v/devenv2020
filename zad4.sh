#!bin/bash 
(
	cd $1 ;
	wordsStr=$( cat  $(find . -maxdepth 64 -type f)  |tr '[A-Z]' '[a-z]' |tr ' \t' '\n\n'|sed -e "/^$/d" |sort |uniq | tr '\n' ' ' )
	words=($wordsStr)

	filesStr=$(find . -maxdepth 64 -type f)
	files=($filesStr)

	declare -a wordlist
	for (( i = 0; i < ${#words[@]}; i++ )); 
	do
		wordlist[i]=${words[i]};
	done

	for((j=0;j<${#files[@]};j++))
	do
		for((k=0;k<${#words[@]};k++))
		do
			tmp=$(awk "BEGIN{IGNORECASE = 1};/${words[k]}/{print NR}" ${files[j]} | tr '\n' ' ')
			if [ ! -z "$tmp" ]
			then
				wordlist[k]="${wordlist[k]} ${files[j]}: $tmp"
			fi
		done 
	done

	printf '%s\n' "${wordlist[@]}"
)