#!/bin/bash

HS=$1
# create new file
rm -f ${HS}_age_dist_copy.txt
touch ${HS}_age_dist_copy.txt

# convert O,A, or K to number value
while read dist age dt ty name; do
	# if type is observed
	if [ "$ty" == "O" ]; then
		echo "$dist 	$age 	$dt 	0" >> ${HS}_age_dist_copy.txt
	fi
	# if type is Ar/Ar
	if [ "$ty" == "A" ]; then
		echo "$dist 	$age 	$dt 	1" >> ${HS}_age_dist_copy.txt
	fi
	# if type is K/Ar
	if [ "$ty" == "K" ]; then
		echo "$dist 	$age 	$dt 	2" >> ${HS}_age_dist_copy.txt
	fi
done < ${HS}_age_dist.txt