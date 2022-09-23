#!/bin/bash

chain1=$1
chain2=$2

#make data table with hotspot pair present day lon, lat, azimuths
gmt begin
	# extract the zero age lon, lat
	gmt sample1d final_line_width_age_tables/${chain1}_line_width_age.txt -T0, -N11 -o0,1 > azimuths/hotspot_${chain1}_lon_lat.txt
	gmt sample1d final_line_width_age_tables/${chain2}_line_width_age.txt -T0, -N11 -o0,1 > azimuths/hotspot_${chain2}_lon_lat.txt
	# deal with longitudes that cross the meridian
	gmt math azimuths/hotspot_${chain1}_lon_lat.txt -C0 DUP 0 LE 360 MUL ADD = azimuths/hotspot_${chain1}_lon_lat.txt
	gmt math azimuths/hotspot_${chain2}_lon_lat.txt -C0 DUP 0 LE 360 MUL ADD = azimuths/hotspot_${chain2}_lon_lat.txt
	#create one datatable with hotspot lat lons
	gmt convert azimuths/hotspot_${chain1}_lon_lat.txt azimuths/hotspot_${chain2}_lon_lat.txt -A > tmp1
	gmt convert azimuths/hotspot_${chain2}_lon_lat.txt azimuths/hotspot_${chain1}_lon_lat.txt -A > tmp2
	# find back azimuths
	gmt mapproject tmp1 -Af+v -fg -o4 > azimuths/${chain1}_azimuths_${chain2}.txt
	gmt mapproject tmp2 -Af+v -fg -o4 > azimuths/${chain2}_azimuths_${chain1}.txt
	# create data table with azimuths for chain 1
	gmt convert azimuths/${chain1}_azimuths_${chain2}.txt azimuths/${chain2}_azimuths_${chain1}.txt -A >> azimuths/azi_${chain1}.txt
gmt end show

rm -f tmp1
rm -f tmp2