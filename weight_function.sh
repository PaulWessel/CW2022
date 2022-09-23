#!/bin/bash
fw=$1
chain=$2
median=$3
gaussian=$4
MATLAB=/Applications/MATLAB_R2019a.app
gmt begin
	gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd chain_lines/weighted_line_${fw}_${chain}.txt -C800k/2/20 -fg -Ar -Dchain_lines/weighted_line_resampled_${chain}_${fw}.txt > temp.txt
	# deal with longitudes that cross the meridian
	gmt math chain_lines/weighted_line_resampled_${chain}_${fw}.txt -C0 DUP 0 LE 360 MUL ADD = distance_azi.txt
	# perform 1d filter on line
	gmt filter1d distance_azi.txt -Fg200k -N2 -E > final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt
	# run grdtrack over smooth data
	gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -Dfinal_smooth_weighted_line/weighted_line_filtered_resampled.txt -C800k/1/5 -fg -Ar -F  > chain_std/smooth_width.txt
	# set all zeros to NANs
	gmt grdmath Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 0 NAN = chain_std/500m_contour_finial_grid_${chain}_NAN.grd
	# draw cross profiles
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C400k/1/5 -fg -Ar > chain_std/cross.txt
	# Find standard deviations making zero point the center
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C400k/1/5 -fg -Ar -F+r  > chain_std/width.txt
	# use +b option to get a record of max z 
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C400k/1/5 -fg -Ar -F+b  > chain_std/max_z_${chain}.txt
	# convert width to 1 sigma
	gmt math chain_std/width.txt -C12 2 DIV = 1sigma/width_1sigma_vs_dist_${chain}.txt
	# find 99% confidence value to the right
	gmt math 1sigma/width_1sigma_vs_dist_${chain}.txt -Sf -i12 DUP LMSSCL 0.99 ZCRIT MUL EXCH MODE ADD = 1sigma/99_right.txt
	gmt convert 1sigma/99_right.txt > 1sigma/99_right_${chain}.txt
	# matlab code that finds weighted width
	$MATLAB/bin/matlab -nodisplay -nojvm -batch "weight_function_for_ss" > status.log 
	# filter the weighted width data
		# linear function
	gmt filter1d chain_std/weighted_width_linear.txt -i3,4 -Fm${median}k -E > chain_std/weighted_filtered_widths_median_linear.txt
	gmt filter1d chain_std/weighted_filtered_widths_median_linear.txt -Fg${gaussian}k -E > chain_std/weighted_filtered_widths_gaussian_linear.txt
	gmt convert chain_std/weighted_width_linear.txt chain_std/weighted_filtered_widths_gaussian_linear.txt -A > chain_std/weighted_filtered_widths_linear.txt
		# cos function
	gmt filter1d chain_std/weighted_width_cos.txt -i3,4 -Fm${median}k -E > chain_std/weighted_filtered_widths_median_cos.txt
	gmt filter1d chain_std/weighted_filtered_widths_median_cos.txt -Fg${gaussian}k -E > chain_std/weighted_filtered_widths_gaussian_cos.txt
	gmt convert chain_std/weighted_width_cos.txt chain_std/weighted_filtered_widths_gaussian_cos.txt -A > chain_std/weighted_filtered_widths_cos.txt
		# shifted cos function
	gmt filter1d chain_std/weighted_width_shifted.txt -i3,4 -Fm${median}k -E > chain_std/weighted_filtered_widths_median_shifted.txt
	gmt filter1d chain_std/weighted_filtered_widths_median_shifted.txt -Fg${gaussian}k -E > chain_std/weighted_filtered_widths_gaussian_shifted.txt
	gmt convert chain_std/weighted_width_shifted.txt chain_std/weighted_filtered_widths_gaussian_shifted.txt -A > chain_std/weighted_filtered_widths_shifted.txt
	# creates file lon,lat,azimuth,dist,sigma 
	gmt math chain_std/weighted_filtered_widths_linear.txt -o0,1,2,5,6 -C6 2 DIV = weighted_width_1sigma_vs_dist_linear.txt
	gmt math chain_std/weighted_filtered_widths_cos.txt -o0,1,2,5,6 -C6 2 DIV = weighted_width_1sigma_vs_dist_cos.txt
	gmt math chain_std/weighted_filtered_widths_shifted.txt -o0,1,2,5,6 -C6 2 DIV = weighted_width_1sigma_vs_dist_shifted.txt
	# use gmt vector to plot widths in map view
		# linear function
	gmt vector weighted_width_1sigma_vs_dist_linear.txt -i0,1,2+o90,4 -fg -Ttk > chain_std/weighted_width_linear_R.txt
	gmt vector weighted_width_1sigma_vs_dist_linear.txt -i0,1,2+o-90,4 -fg -Ttk > chain_std/weighted_width_linear_L.txt
		# cos function
	gmt vector weighted_width_1sigma_vs_dist_cos.txt -i0,1,2+o90,4 -fg -Ttk > chain_std/weighted_width_cos_R.txt
	gmt vector weighted_width_1sigma_vs_dist_cos.txt -i0,1,2+o-90,4 -fg -Ttk > chain_std/weighted_width_cos_L.txt
		# shifted cos function
	gmt vector weighted_width_1sigma_vs_dist_shifted.txt -i0,1,2+o90,4 -fg -Ttk > chain_std/weighted_width_shifted_R.txt
	gmt vector weighted_width_1sigma_vs_dist_shifted.txt -i0,1,2+o-90,4 -fg -Ttk > chain_std/weighted_width_shifted_L.txt
	# create markings on line every 500 km
	gmt convert chain_std/weighted_width_${chain}.txt -Em100 > chain_std/500km.txt
	# plotting the results
	gmt figure chain_std/weight_function_${chain} pdf,jpg
	gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -JM6i -B
	# plot the cross profiles
	#gmt plot chain_std/cross.txt -Wfaint,yellow
	# plot the line
	gmt plot final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -W0.5,red #-l"Weighted line"
	# plot the raw widths
		# left rise point
	gmt plot chain_std/width.txt -Sc0.5p -Gpurple -i6,7 #-l"Raw chain width"
		#right rise point
	gmt plot chain_std/width.txt -Sc0.5p -Gpurple -i9,10
	# plot the weighted widths
		# linear
	gmt plot chain_std/weighted_width_linear_R.txt -W0.25p,lightblue -l"Linear weighted function"
	gmt plot chain_std/weighted_width_linear_L.txt -W0.25p,lightblue
		# cosine
	gmt plot chain_std/weighted_width_cos_R.txt -W0.25p,lightred -l"Cosine ramp function"
	gmt plot chain_std/weighted_width_cos_L.txt -W0.25p,lightred
		# shifted
	gmt plot chain_std/weighted_width_shifted_R.txt -W0.25p,yellow -l"Shifted cosine ramp function"
	gmt plot chain_std/weighted_width_shifted_L.txt -W0.25p,yellow
	#plot marking every 500km along the line
	gmt plot chain_std/500km.txt -Sc1p
	# colorbar
	#gmt colorbar -B+l"Elevation (m)"
gmt end show

gmt begin
	# plot weights vs distance for each function
	gmt figure chain_std/weight_vs_distance_${chain} jpg
	gmt plot chain_std/NORM_max_z_${chain}_DENAN.txt  -i0,5 -W0.5p -l"Raw Z max normalized"+jTL -JX100c/10c -B -BWSne+t"Weight vs Distance for ${chain}" -Bx+l"Distance (km)" -By+l"Weight" --MAP_FRAME_TYPE=plain
	gmt plot chain_std/weight_vs_distance.txt -i0,1 -W0.5p,blue -l"Linear weigtht function"
	gmt plot chain_std/weight_vs_distance.txt -i0,2 -W0.5p,red -l"Cosine ramp weigtht function"
	gmt plot chain_std/weight_vs_distance.txt -i0,3 -W0.5p,green -l"Shifted cosine ramp weigtht function"
gmt end show 


rm -f temp.txt
rm -f distance_azi.txt
rm -f chain_std/smooth_width.txt
rm -f chain_std/500km.txt

rm -f weighted_width_1sigma_vs_dist_linear.txt
rm -f weighted_width_1sigma_vs_dist_cos.txt
rm -f weighted_width_1sigma_vs_dist_shifted.txt

rm -f chain_std/weighted_filtered_widths_median_linear.txt
rm -f chain_std/weighted_filtered_widths_gaussian_linear.txt
rm -f chain_std/weighted_filtered_widths_linear.txt
rm -f chain_std/weighted_filtered_widths_median_cos.txt
rm -f chain_std/weighted_filtered_widths_gaussian_cos.txt
rm -f chain_std/weighted_filtered_widths_cos.txt

rm -f chain_std/weighted_width_linear_R.txt
rm -f chain_std/weighted_width_linear_L.txt
rm -f chain_std/weighted_width_cos_R.txt
rm -f chain_std/weighted_width_cos_L.txt
rm -f chain_std/weighted_width_shifted_R.txt
rm -f chain_std/weighted_width_shifted_L.txt

rm -f chain_std/weight_vs_distance.txt