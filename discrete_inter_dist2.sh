#!/bin/bash

age=$1 # Specify the age range, 6 Ma for most chains, LV and RU go to 15 Myr
chain1=$2
chain2=$3


gmt begin
	# select all data points between 0-6 Ma
	# rel_drift_rates/(chain).txt: lon, lat, age
	gmt select chain_ages/${chain1}_info.txt -i5,6,2 -Z0/${age} | gmt convert -Td > rel_drift_rates/${chain1}.txt
	gmt math rel_drift_rates/${chain1}.txt -C0 DUP 0 LT 360 MUL ADD = rel_drift_rates/${chain1}.txt #no negative longitudes
	gmt select chain_ages/${chain2}_info.txt -i5,6,2 -Z0/${age} | gmt convert -Td > rel_drift_rates/${chain2}.txt
	gmt math rel_drift_rates/${chain2}.txt -C0 DUP 0 LT 360 MUL ADD = rel_drift_rates/${chain2}.txt
	# create file with just ages
	# tmp{1,2}: age
	gmt convert rel_drift_rates/${chain1}.txt -o2 > tmp1
	gmt convert rel_drift_rates/${chain2}.txt -o2 > tmp2
	# extract uncertainties from chain 1 line, sig width, sig along and then chain 2
	# rel_drift_rates/sig_${chain}.txt: sig_width, sig_along, azimth
	gmt sample1d final_line_width_age_tables/${chain1}_line_width_age.txt -N11 -Ttmp1 -o6,14,3 > rel_drift_rates/sig_${chain1}.txt
	gmt sample1d final_line_width_age_tables/${chain2}_line_width_age.txt -N11 -Ttmp2 -o6,14,3 > rel_drift_rates/sig_${chain2}.txt
	# add uncertainties to data talbe 
	# rel_drift_rates/zero_to_6Ma_${chain1}.txt: lon, lat, age, sig width, sig along, azimuth
	gmt convert rel_drift_rates/${chain1}.txt rel_drift_rates/sig_${chain1}.txt -A > rel_drift_rates/zero_to_6Ma_${chain1}.txt
	gmt convert rel_drift_rates/${chain2}.txt rel_drift_rates/sig_${chain2}.txt -A > rel_drift_rates/zero_to_6Ma_${chain2}.txt
	# sample coeval coeval ages from chain 2 on chain 1
	# tmp{3,4}: lon, lat, age, sig_width, sig_along, azimuth
	gmt sample1d final_line_width_age_tables/${chain1}_line_width_age.txt -N11 -Ttmp2 -o0,1,11,6,14,3 > tmp3.txt
	gmt math tmp3.txt -C0 DUP 0 LT 360 MUL ADD = tmp3.txt
	# sample coeval ages from chain 1 on chain 2
	gmt sample1d final_line_width_age_tables/${chain2}_line_width_age.txt -N11 -Ttmp1 -o0,1,11,6,14,3 > tmp4.txt
	gmt math tmp4.txt -C0 DUP 0 LT 360 MUL ADD = tmp4.txt
	# combine data for chain 1 age and data for chain2 ages
	# positions1: lon1, lat1, age1, sig_width1, sig_across1, azimuth1, lon12, lat12, age12(coeval ages from chain1), sig_width12, sig_along12, azimuth12
	# positions2: lon2, lat2, age2, sig_width2, sig_along2, azimuth2, lon21, lat21, age21(coeval ages from chain2), sig_width21, sig_along21, azimuth21
	gmt convert rel_drift_rates/zero_to_6Ma_${chain1}.txt tmp4.txt -A > positions1 #chain 1 ages
	gmt convert rel_drift_rates/zero_to_6Ma_${chain2}.txt tmp3.txt -A > positions2 #chaine 2 ages
	# find distences 
	gmt mapproject positions1 -i0,1,6,7 -fg -G+v+i+ud -o4 > tmp5.txt #chain1 ages
	gmt mapproject positions2 -i0,1,6,7 -fg -G+v+i+ud -o4 > tmp6.txt #chain2 ages
	gmt mapproject positions1 -i0,1,6,7 -fg -G+v+i+uk -o4 > km1 #chain1 ages
	gmt mapproject positions2 -i0,1,6,7 -fg -G+v+i+uk -o4 > km2 #chain2 ages
	# create files for plotting in R
	# rel_drift_rates/chain1_ages_${chain1}_${chain2}.txt: lon1, lat1, age1, dist12(deg)
	gmt convert rel_drift_rates/${chain1}.txt tmp5.txt -A >  rel_drift_rates/chain1_ages_${chain1}_${chain2}.txt
	gmt convert rel_drift_rates/${chain2}.txt tmp6.txt -A >  rel_drift_rates/chain2_ages_${chain1}_${chain2}.txt
	# find azimuths with chain1 ages
	gmt mapproject positions1 -i0,1,6,7 -fg -Af+v -o4 > chain1_azi1 # azimuth from chain1 to chain2 
	gmt mapproject positions1 -i6,7,0,1 -fg -Af+v -o4 > chain1_azi2 # azimuth from chain2 to chain1
	# find azimuths with chain2 ages
	gmt mapproject positions2 -i0,1,6,7 -fg -Af+v -o4 > chain2_azi1 # azimuth from chain2 to chain1
	gmt mapproject positions2 -i6,7,0,1 -fg -Af+v -o4 > chain2_azi2 # azimuth from chain1 to chain2
	# create data table with age, lon, lat, sig width, sig along, width azimuth for chain 1, Lon, lat, sig width, sig along, width azimuth for chain 2, azi chain 1 to chain 2, azi chain 2 to chain 1, inter dist degrees, inter dist km
	gmt convert positions1 chain1_azi1 chain1_azi2 tmp5.txt km1 -A -o2,0,1,3,4,5,6,7,9,10,11,12,13,14,15 > rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}_1.txt 
	# chain2 ages
	gmt convert positions2 chain2_azi2 chain2_azi1 tmp6.txt km2 -A -o2,0,1,3,4,5,6,7,9,10,11,12,13,14,15 > rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}_2.txt
	# combine 
	gmt convert rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}_1.txt rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}_2.txt -Th > rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}.txt
gmt end

#rm -f rel_drift_rates/sig_${chain1}.txt
#rm -f rel_drift_rates/sig_${chain2}.txt
#rm -f tmp1
#rm -f tmp2
#rm -f rel_drift_rates/${chain1}.txt
#rm -f rel_drift_rates/${chain2}.txt
#rm -f tmp3.txt
#rm -f tmp4.txt
#rm -f positions1
#rm -f positions2
#rm -f chain1_azi1
#rm -f chain1_azi2
#rm -f chain2_azi1
#rm -f chain2_azi2
#rm -f km1 km2
#rm -f tmp5.txt
#rm -f tmp6.txt
#rm -f rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}_1.txt
#rm -f rel_drift_rates/discreet_inter_hotspot_distances_${chain1}_${chain2}_2.txt
