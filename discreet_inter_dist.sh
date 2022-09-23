#!/bin/bash

age=$1 # Specify the age range, 6 Ma for most chains, LV and RU go to 15 Myr
chain1=$2
chain2=$3

gmt begin
	# select all data points between 0-6 Ma
	gmt select chain_ages/${chain1}_info.txt -i5,6,2 -Z0/${age} | gmt convert -Td > rel_drift_rates/${chain1}.txt
	gmt math rel_drift_rates/${chain1}.txt -C0 DUP 0 LT 360 MUL ADD = rel_drift_rates/${chain1}.txt #no negative longitudes
	gmt select chain_ages/${chain2}_info.txt -i5,6,2 -Z0/${age} | gmt convert -Td > rel_drift_rates/${chain2}.txt
	gmt math rel_drift_rates/${chain2}.txt -C0 DUP 0 LT 360 MUL ADD = rel_drift_rates/${chain2}.txt
	# create file with just ages
	gmt convert rel_drift_rates/${chain1}.txt -o2 > tmp1
	gmt convert rel_drift_rates/${chain2}.txt -o2 > tmp2
	# extract uncertainties from chain 1 line, sig width, sig along and then chain 2
	gmt sample1d final_line_width_age_tables/${chain1}_line_width_age.txt -N11 -Ttmp1 -o6,14,3 > rel_drift_rates/sig_${chain1}.txt
	gmt sample1d final_line_width_age_tables/${chain2}_line_width_age.txt -N11 -Ttmp2 -o6,14,3 > rel_drift_rates/sig_${chain2}.txt
	# add uncertainties to data talbe for lon, lat, age, sig width, sig along
	gmt convert rel_drift_rates/${chain1}.txt rel_drift_rates/sig_${chain1}.txt -A > rel_drift_rates/zero_to_6Ma_${chain1}.txt
	gmt convert rel_drift_rates/${chain2}.txt rel_drift_rates/sig_${chain2}.txt -A > rel_drift_rates/zero_to_6Ma_${chain2}.txt
	# sample coeval chain 1 and chain  values and output lon, lat, age, sig width, sig along
	gmt sample1d final_line_width_age_tables/${chain1}_line_width_age.txt -N11 -Ttmp2 -o0,1,11,6,14,3 > tmp3.txt
	#gmt sample1d final_line_width_age_tables/${chain1}_line_width_age.txt -N11 -T0, -o0,1,11,6,14,3 >> tmp3.txt #add zero age to chain 1
	gmt math tmp3.txt -C0 DUP 0 LT 360 MUL ADD = tmp3.txt
	gmt convert tmp3.txt rel_drift_rates/zero_to_6Ma_${chain1}.txt -Th | gmt convert -N2 > rel_drift_rates/zero_to_6Ma_${chain1}_sampled_${chain2}.txt
	gmt sample1d final_line_width_age_tables/${chain2}_line_width_age.txt -N11 -Ttmp1 -o0,1,11,6,14,3 > tmp4.txt
	#gmt sample1d final_line_width_age_tables/${chain2}_line_width_age.txt -N11 -T0, -o0,1,11,6,14,3 >> tmp4.txt #add zero age to chain 2
	gmt math tmp4.txt -C0 DUP 0 LT 360 MUL ADD = tmp4.txt
	gmt convert tmp4.txt rel_drift_rates/zero_to_6Ma_${chain2}.txt -Th | gmt convert -N2 > rel_drift_rates/zero_to_6Ma_${chain2}_sampled_${chain1}.txt
	# combine the tables to creat chain1: lon,lat,age,sig_width,sig_along and same for chain2
	gmt convert rel_drift_rates/zero_to_6Ma_${chain1}_sampled_${chain2}.txt rel_drift_rates/zero_to_6Ma_${chain2}_sampled_${chain1}.txt -A > positions
	# find distances
	gmt mapproject positions -i0,1,6,7 -fg -Af+v -o4 > azi1
	gmt mapproject positions -i6,7,0,1 -fg -Af+v -o4 > azi2
	gmt mapproject positions -i0,1,6,7 -fg -G+v+i+ud -o4 > degrees
	gmt mapproject positions -i0,1,6,7 -fg -G+v+i+uk -o4 > distances
	# create data table with age, lon, lat, sig width, sig along, width azimuth for chain 1, Lon, lat, sig width, sig along, width azimuth for chain 2, azi chain 1 to chain 2, azi chain 2 to chain 1, inter dist degrees, inter dist km
	gmt convert positions azi1 azi2 degrees distances -A -o2,0,1,3,4,5,6,7,9,10,11,12,13,14,15 > rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}.txt 
gmt end

rm -f rel_drift_rates/sig_${chain1}.txt
rm -f rel_drift_rates/sig_${chain2}.txt
rm -f tmp1
rm -f tmp2
rm -f rel_drift_rates/${chain1}.txt
rm -f rel_drift_rates/${chain2}.txt
rm -f tmp3.txt
rm -f tmp4.txt
rm -f positions
rm -f azi2
rm -f azi1
rm -f degrees
rm -f distances