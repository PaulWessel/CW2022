#!/bin/bash
ellipse=$"wheat"
vec1=$"10p"
vec2=$"18p"
ALL=$"blue"
confidence=$"0.95"
gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure defense_figs/simulated_MC2 png
	gmt subplot begin 2x2 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -A"Hotspot 1"
			gmt coast -JA171.8/-10.6/? -Gwhite
			gmt plot simulated_MC2.txt -i0,5 -Sc0.01 -Gred
			gmt velo simulated_CoVar2.txt -q0 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -L1p
			gmt velo real_vector.txt -q0 -Se11.1195/${confidence} -A${vec2}+e  -Ggreen -W0.25
			gmt plot Simulated_coVar2.txt -q0 -Sx0.2c -W1p
			echo 171.5 -10.75 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A10p+e -Gblue -W1p -L1p
			echo "171.5 -10.875 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -A"Hotspot 2"
			gmt coast -JA194.9/-1.8/? -Gwhite
			gmt plot simulated_MC2.txt -i1,6 -Sc0.01 -Gred
			gmt velo simulated_CoVar2.txt -q1 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -L1p
			gmt velo real_vector.txt -q1 -Se11.1195/${confidence} -A${vec2}+e  -Ggreen -W0.25
			gmt plot Simulated_coVar2.txt -q1 -Sx0.2c -W1p
		gmt subplot set 2 -A"Hotspot 3"
			gmt coast -JA181.2/1.3/? -Gwhite
			gmt plot simulated_MC2.txt -i2,7 -Sc0.01 -Gred
			gmt velo simulated_CoVar2.txt -q2 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -L1p
			gmt velo real_vector.txt -q2 -Se11.1195/${confidence} -A${vec2}+e  -Ggreen -W0.25
			gmt plot Simulated_coVar2.txt -q2 -Sx0.2c -W1p
		gmt subplot set 3 -A"Hotspot 4"
			gmt coast -JA173/4.2/? -Gwhite
			gmt plot simulated_MC2.txt -i3,8 -Sc0.01 -Gred
			gmt velo simulated_CoVar2.txt -q3 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -L1p
			gmt velo real_vector.txt -q3 -Se11.1195/${confidence} -A${vec2}+e  -Ggreen -W0.25
			gmt plot Simulated_coVar2.txt -q3 -Sx0.2c -W1p
	gmt subplot end	
gmt end show