#!/bin/bash

lon1=200
lat1=20
lon2=250
lat2=-50
gmt begin
	# plot synthetic points
	gmt coast -Rg -JG200/10/6i -Glightgrey -Bg 
	echo ${lon1} ${lat1} | gmt plot -Sc0.2 -W1p -Gred
	echo ${lon2} ${lat2} | gmt plot -Sc0.2 -W1p -Gred
	gmt plot -W1p <<- EOF 
	${lon1} ${lat1}
	${lon2} ${lat2}
	EOF
	# calculate inter-hotspot distnce
	echo ${lon1} ${lat1} ${lon2} ${lat2} | gmt mapproject -fg -G+v+i+uk -o4 > test1
	gmt math -Q ${lat1} ${lat2} SUB ABS = tmp1
	gmt math -Q ${lon1} ${lon2} SUB ABS = tmp2
	# create table with inter-hotspot distance, latitude separation and longitude  separation
	gmt convert test1 tmp1 tmp2 -A > test0 
gmt end show

rm -f test1
rm -f tmp1
rm -f tmp2