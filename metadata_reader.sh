#!/bin/bash
# Author: Ian Stroszeck

openfile=~/CSEC471/openshare/*
openshare=~/CSEC471/openshare/

header() {
	echo ''
	echo '**********************************************************'
	echo $1
	echo '**********************************************************'
}

# I was going to try this but never mind. It's not necessary
#filext_rename() {
#	# For every file, fun the file command to check what file type it is 
#	# Rename the file extension to match if different
#	for f in $openfile; do
# 		cd $f; # recursively go to that directory
#		header "Currently in folder: $f"; 
#		ext_match=file * | awk '{print $1,$2}';
#		
#	done
#}

main() {
	cd $openshare
	header 'Show all files and subdirs'
	ls -R
	echo ''
	
	header 'Show all basic file metadata'
	for folder in $openfile;do
		cd $folder;
		file * > ../out/basic_meta.txt
		cd $folder;
	done
	echo ''

	header 'Advanced file metadata'
	cd $openshare
	exiftool -a -u -g1 * >  ../out/adv_meta.txt
	echo ''

	header 'Show all tags used'
	cd $openshare
	exiftool -l -T * | awk '{print $1}' | sort | uniq > ../out/meta_tags.txt
	echo ''

	#header 'Rename file Extensions to match content'
	#filext_rename
	#echo ''

	header 'Scrubbing Data and Printing Results'
	cd $openshare
	exiftool -all= * # Remove all mutable data
	exiftool -a -u -g1 * > ../out/Scrubbed_data.txt
	echo ''

	
}

main
