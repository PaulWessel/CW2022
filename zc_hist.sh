#!/bin/bash
chain=$1

gmt begin
	#gmt math chain_std/width_${chain}.txt -C5 0 DENAN = chain_std/width_${chain}_DENAN.txt
	#gmt figure chain_std/zc_hist_${chain} jpg
	#gmt subplot begin 1x2 -Fs8c
		#gmt subplot set
		#gmt histogram chain_std/smooth_width_${chain}.txt -i5+s1 -T10 -Glightblue -N0+p0.5p,red -N1+p0.5p,green -N2+p0.5p,blue -B -BWSne+t"Smooth Data (${chain})" -Bx+l"Zc (m)" -By+l"Frequency"
		#gmt subplot set
		#gmt histogram chain_std/width_${chain}_DENAN.txt -i5+s1 -T100 -R0/5000/0/500 -Glightblue -N0+p0.5p,red -N1+p0.5p,green -N2+p0.5p,blue -B -BWSne+t"Raw Data (${chain})" -Bx+l"Zc (m)" #-By+l"Frequency"
	#gmt subplot end
	# turn all NANs into zeros
	gmt math chain_std/max_z_${chain}.txt -C5 0 DENAN = chain_std/max_z_${chain}_DENAN.txt
	# normalize zc values
	gmt math chain_std/smooth_width_${chain}.txt -C5 NORM = chain_std/NORM_smooth_width_${chain}.txt
	gmt math chain_std/max_z_${chain}_DENAN.txt  -C5 NORM = chain_std/NORM_max_z_${chain}_DENAN.txt 
	gmt figure chain_std/zmax_vs_dist_${chain}_NORM jpg
	gmt plot chain_std/NORM_max_z_${chain}_DENAN.txt  -i0,5 -W0.5p,red -l"Raw Z max"+jBL -JX100c/10c -B -BWSne+t"Z Max vs Distance for ${chain}" -Bx+l"Distance (km)" -By+l"Z max normalized" --MAP_FRAME_TYPE=plain
	gmt plot chain_std/NORM_smooth_width_${chain}.txt -i0,5 -W0.5p,blue -l"Smooth Z max"
	gmt plot chain_std/raw_weights_${chain}.txt -W0.5p,black -l"Weight toward raw width"
gmt end show