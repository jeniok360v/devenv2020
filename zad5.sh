#!bin/bash
(
	cd $1 ;
	sed -i -e 's/a/A/g' $(find . -maxdepth 64 -type f)
)