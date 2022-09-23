#!/bin/bash
chain1=$1
chain2=$2

age=15.57

gmt begin
	# chain 1 lon, lat, age, sig_width, sig_along
	gmt convert final_line_width_age_tables/${chain1}_line_width_age.txt -o0,1,11,6,14,3 > ${chain1}
	gmt math ${chain1} -C0 DUP 0 LT 360 MUL ADD = ${chain1}
	# chain 2 lon, lat, age, sig_width, sig_along
	gmt convert final_line_width_age_tables/${chain2}_line_width_age.txt -o0,1,11,6,14,3 > ${chain2}
	gmt math ${chain2} -C0 DUP 0 LT 360 MUL ADD = ${chain2}
	# equally sample each dataset, max age for the younger chain
	gmt sample1d ${chain1} -T0/${age}/0.01 -N2 > tmp1
	gmt sample1d ${chain2} -T0/${age}/0.01 -N2 > tmp2
	# combine the tables to creat chain1: lon,lat,age,sig_width,sig_along and same for chain2
	gmt convert tmp1 tmp2 -A > positions
	# find distances
	gmt mapproject positions -i0,1,6,7 -fg -Ab+v -o4 > azi1 # i think its right with the back azimuths
	gmt mapproject positions -i6,7,0,1 -fg -Ab+v -o4 > azi2
	gmt mapproject positions -i0,1,6,7 -fg -G+v+i+ud -o4 > degrees 
	gmt mapproject positions -i0,1,6,7 -fg -G+v+i+uk -o4 > distances
	# add distance column to datatable
	gmt convert positions azi1 azi2 degrees distances -A -o2,0,1,3,4,5,6,7,9,10,11,12,13,14,15 > inter_dist_tables/inter_hotspot_distances_${chain1}_${chain2}.txt
gmt end show

#max age
#HI: 85.23
#RU: 81.95
#LV: 76.29
#CB: 29.36
#KO: 25.61
#FD: 21.93
#PC: 17.75
#SA: 15.57
#CR: 14.75
#MQ: 6.02
#SO: 5.37


rm -f ${chain1}
rm -f ${chain2}
rm -f tmp1
rm -f tmp2
rm -f positions
rm -f degrees
rm -f distances
rm -f azi1
rm -f azi2