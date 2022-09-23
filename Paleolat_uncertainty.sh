#!/bin/bash

chain=$1
age="73"

pole=$(awk '{if ($3 == 73) printf "%s/%s\n", $1, $2}' APM/data/Pacific_Paleomagpoles.txt)
pole2=$(awk '{if ($3 == 73) printf "%s %s\n", $1, $2}' APM/data/Pacific_Paleomagpoles.txt)

#check for which uncertainty is larger for given age, 6 is cross track and 14 is along track
#gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -qo1 -T32 -N11 -o0,1,11,3,6,14 > axis_length.txt

#gmt mapproject axis_length.txt -Ab${lon}/${lat} > pole.txt

#creates data table of hotspot lon, lat, azumith, GS azumith, cross track, along track, age
gmt sample1d final_line_width_age_tables/${chain}_line_width_age.txt -T${age}, -N11 -o0,1,11,3,6,14 | gmt mapproject -Ab${pole} -fg -o0,1,3,6,4,5,2 > azimuth1.txt

HS=$(awk '{printf "%s/%s\n", $1, $2}' azimuth1.txt)
HS2=$(awk '{printf "%s %s\n", $1, $2}' azimuth1.txt)

echo ${pole2} | gmt mapproject -Ab${HS} -fg -o2 > azimuth2.txt

#creates data table of paleopole lon, lat, azumith, major and semi axis, GS azimuth, hotspot lon, lat, azimith, GS azimith, cross track, along track, age
gmt sample1d APM/data/Pacific_Paleomagpoles.txt -T${age}, -N2 -o0,1,3,4,5 > pole.txt
gmt convert pole.txt azimuth2.txt azimuth1.txt -A > P_lat/pole_to_HS_uncert.txt 

gmt begin
	gmt coast -Rg -JG190/30/12c -Glightgray -Bg
	gmt plot P_lat/pole_to_HS_uncert.txt -i0,1,2,3+s100,4+s100 -SE -Glightpink -W0.25p
	gmt plot P_lat/pole_to_HS_uncert.txt -i6,7,8,10+s10,11+s10 -SE -Glightpink -W0.25p
	gmt plot -W1p <<- EOF
	${pole2}
	${HS2}
EOF
gmt end show