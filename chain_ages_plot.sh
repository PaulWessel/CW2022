#!/bin/bash
fw=$1
chain=$2

gmt begin
gmt figure chain_ages/${chain}_ages pdf
	gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -JM6i -B
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_${chain}_${fw}.txt -W1p,red
	gmt plot chain_ages/${chain}_info.txt  -Sc0.1 -Gred -W0.5
	gmt plot chain_ages/${chain}_info.txt -i5,6 -Sc0.1 -Ggreen -W0.5
	# plot bend distance range for bend ages 
	#gmt plot chain_ages/Bend_${chain}.txt -W1p,yellow
gmt end show