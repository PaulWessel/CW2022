#!/bin/bash
fw=$1
chain=$2
gmt begin
	gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd chain_lines/weighted_line_${fw}_${chain}.txt -C800k/2/20 -fg -Ar -Dchain_lines/weighted_line_resampled_${chain}_${fw}.txt > temp.txt
	# deal with longitudes that cross the meridian
	gmt math chain_lines/weighted_line_resampled_${chain}_${fw}.txt -C0 DUP 0 LE 360 MUL ADD = distance_azi.txt
	# perform 1d filter on line
	gmt filter1d distance_azi.txt -Fg200k -N2 -E > final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt
	# run grdtrack over smooth data
	gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C800k/1/5 -fg -Ar -F  > chain_std/smooth_width.txt
	# set all zeros to NANs
	gmt grdmath Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 0 NAN = chain_std/500m_contour_finial_grid_${chain}_NAN.grd
	# draw cross profiles
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C400k/1/5 -fg -Ar > chain_std/cross.txt
	# Find boundary points based on standard deviations
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C400k/1/5 -fg -Ar -F+b  > chain_std/width.txt
	#divide width by 2 to make 1 sigma and save file
	gmt math chain_std/width.txt -C12 2 DIV = 1sigma/width_1sigma_vs_dist_${chain}.txt
	# save line unique to chain
	gmt convert chain_std/smooth_width.txt > chain_std/smooth_width_${chain}.txt
	gmt convert chain_std/width.txt > chain_std/width_${chain}.txt
	# plotting the results
	gmt figure chain_std/std_${chain}_${fw}_nCP pdf,jpg
	gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -JM6i -B
	# plot the cross profiles
	#gmt plot chain_std/cross.txt -Wfaint,yellow
	# plot the line
	gmt plot final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -W0.5,red #-l"Weighted line"
	# Plot the left rise point
	gmt plot chain_std/width.txt -Sc0.5p -Glightred -i6,7 -l"Chain width"
	# Plot the right rise point
	gmt plot chain_std/width.txt -Sc0.5p -Glightred -i9,10
	# plot max width
	#gmt plot chain_std/75_width_line_R.txt -Sc1p -Gpurple -l"75th quantile width"
	#gmt plot chain_std/75_width_line_L.txt -Sc1p -Gpurple
	# plot weighted width
	#gmt plot mean_chain_width/weighted_width_${fw}_${chain}_R.txt -Sc1p -Glightgreen -l"Weighted chain width"
	#gmt plot mean_chain_width/weighted_width_${fw}_${chain}_L.txt -Sc1p -Glightgreen
	# colorbar
	gmt colorbar -B+l"Elevation (m)"
gmt end show 
rm -f temp.txt
