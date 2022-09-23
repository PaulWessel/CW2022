#!/bin/bash

chain=$1

##Paleopoles
#pole=$(awk '{if ($3 == 73) printf "%s/%s\n", $1, $2}' APM/data/Pacific_Paleomagpoles.txt)

#gmt sample1d final_line_width_age_tables/${chain}_line_width_age.txt -T73, -N11 -o0,1,2,11 | gmt mapproject -G${pole}+ud | gmt convert -i0,1,2,3,4+s-1+o90 >> P_lat/${chain}_plat_poles.txt

#Spin axes
pole=$(awk '{if ($3 == 32) printf "%s/%s\n", $1, $2}' APM/data/Pacific_PaleoSpinAxes.txt)

gmt sample1d final_line_width_age_tables/${chain}_line_width_age.txt -T32, -N11 -o0,1,2,11 | gmt mapproject -G${pole}+ud | gmt convert -i0,1,2,3,4+s-1+o90 >> P_lat/${chain}_plat_spin.txt

##Paleo Lats

#gmt sample1d final_line_width_age_tables/${chain}_line_width_age.txt -T74.20, -N11 -o0,1,2,11 > line_sample.txt
#gmt sample1d P_lat/${chain}_Paleolats.txt -T74.20, -N0 -o1,2,3,4 > plat_sample.txt
#gmt convert line_sample.txt plat_sample.txt -A >> P_lat/${chain}_dist_age_plat.txt

#rm -f line_sample.txt
#rm -f plat_sample.txt
