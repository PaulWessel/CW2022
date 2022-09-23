#!/bin/bash
# code to perform a gaussin filter on the residual seamount data and find a weighted line connected height points to the data
fw=$1
chain=$2
gf=$3
median=$4
gaussian=$5
weights=$6
MATLAB=/Applications/MATLAB_R2019a.app
# Directory with the APM models on my computer
# Filtering the residual grid and asking for output just for the chain
#gmt grdcut Filter_grids/500m_contour_finial_grid_${chain}.grd -R200/220/-25/-10 -GFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 
#gmt grdmath Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 0 DENAN = Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 
#gmt grdfilter -Fg${fw} Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -I2m -D2 -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd
# Convert center line from kml to txt file
ls start_line/${chain}2_edited.kml | awk '{print substr($1,1,2)}' > /tmp/t.lis
while read tag; do
	kml2gmt start_line/${chain}2_edited.kml > start_line/${chain}2_edited.txt
done < /tmp/t.lis
# Create the cross profiles so we can plot them below
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd start_line/${chain}2_edited.txt -C400k/2/20 -fg -Ar -Dchain_lines/start_line_resampled.txt > chain_lines/cross_${fw}_${chain}.txt
gmt convert chain_lines/start_line_resampled.txt > chain_lines/start_line_resampled_${fw}_${chain}.txt
# Same, but now use -F to harvest the median and critical points
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd start_line/${chain}2_edited.txt -C400k/2/20 -fg -Ar -F > chain_lines/center.txt
gmt convert chain_lines/center.txt > chain_lines/center_${fw}_${chain}.txt
# use matlab script to find lon lat of weighted line
$MATLAB/bin/matlab -nodisplay -nojvm -batch "weight" > status.log
gmt convert chain_lines/weighted_line.txt > chain_lines/weighted_line_${fw}_${chain}.txt #renames file to keep record of fw and chain
#resample weighted line
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd chain_lines/weighted_line_${fw}_${chain}.txt -C800k/2/20 -fg -Ar -Dchain_lines/weighted_line_resampled_${chain}_${fw}.txt > temp.txt
# deal with longitudes that cross the meridian
gmt math chain_lines/weighted_line_resampled_${chain}_${fw}.txt -C0 DUP 0 LE 360 MUL ADD = distance_azi.txt
# perform 1d filter on line
gmt filter1d distance_azi.txt -Fg${gf}k -N2 -E > final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt	
# run grdtrack over smooth data, FW FOR WEIGHTS
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${weights}_ne.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C800k/1/1 -fg -Ar -F  > chain_std/smooth_width.txt #Change fw for -G option for weights if needed
# set all zeros to NANs
gmt grdmath Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 0 NAN = chain_std/500m_contour_finial_grid_${chain}_NAN.grd
# create resampled line
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd -GFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -Dfinal_smooth_weighted_line/weighted_line_filtered_resampled.txt -C800k/1/1 -fg -Ar  > chain_std/temp2.txt
gmt convert final_smooth_weighted_line/weighted_line_filtered_resampled.txt > final_smooth_weighted_line/weighted_line_filtered_resampled_${chain}_${fw}.txt
# Plotting time
gmt begin weighted_median_line_figs_2/smooth_${chain}2_${fw}_${gf}1D_new_line_weighted pdf,jpg
	# Lay down smoothed grid
	gmt grdimage Median_line_figs/smooth_${chain}_${fw}_ne.grd -JM6i -B -B+t"${chain} ${fw} km 2D Gaussian Filter Width" -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd --MAP_FRAME_TYPE=plain
	# Draw input median line
	gmt plot start_line/${chain}_edited.txt -W2p,red -l"Starting line"+ggrey
	# Draw cross-sections
	gmt plot chain_lines/cross_${fw}_${chain}.txt -Wfaint,yellow 
	# Draw the new median line by connecting the dots
	gmt plot chain_lines/center_${fw}_${chain}.txt -W1p,white -i1,2 -l"Non-weighted line"
	# ALso plot the actual center points
	#gmt plot chain_lines/center_${chain}.txt -Sc0.5p -Gwhite
	# plot weighted line
	gmt plot final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -W1,yellow -l"Weighted and filtered line"
	# Plot the left rise point
	#gmt plot chain_lines/center_${fw}_${chain}.txt -Sc1p -Glightgreen -i5,6
	# Plot the right rise point
	#gmt plot chain_lines/center_${fw}_${chain}.txt -Sc1p -Glightred -i8,9
	gmt colorbar -B+l"Filtered height (m)"
gmt end show

# finding the weighted width of each chain
gmt begin
	# draw cross profiles
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C800k/1/1 -fg -Ar > chain_std/cross.txt
	# Find standard deviations making zero point the center
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C800k/1/1 -fg -Ar -F+r  > chain_std/width.txt
	# use +b option to get a record of max z 
	gmt grdtrack -Gchain_std/500m_contour_finial_grid_${chain}_NAN.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C800k/1/1 -fg -Ar -F+b  > chain_std/max_z_${chain}.txt
	# convert width to 1 sigma
	gmt math chain_std/width.txt -C12 2 DIV = 1sigma/width_1sigma_vs_dist_${chain}.txt
	# find 99% confidence value to the right
	gmt math 1sigma/width_1sigma_vs_dist_${chain}.txt -Sf -i12 DUP LMSSCL 0.99 ZCRIT MUL EXCH MODE ADD = 1sigma/99_right.txt
	gmt convert 1sigma/99_right.txt > 1sigma/99_right_${chain}.txt
	# matlab code that finds weighted width
	$MATLAB/bin/matlab -nodisplay -nojvm -batch "width_smooth" > status.log
	# save ouput from matlab 
	gmt convert chain_std/weighted_width.txt > chain_std/weighted_width_${chain}.txt
	gmt convert chain_std/raw_weights.txt > chain_std/raw_weights_${chain}.txt
	# divide width by 2 to make 1 sigma and save file
	gmt math chain_std/weighted_width_${chain}.txt -C4 2 DIV = 1sigma/weighted_width_1sigma_vs_dist_${chain}.txt
	# save line unique to chain
	gmt convert chain_std/smooth_width.txt > chain_std/smooth_width_${chain}.txt
	gmt convert chain_std/width.txt > chain_std/width_${chain}.txt
	# filter the weighted width data
	gmt filter1d chain_std/weighted_width_${chain}.txt -i3,4 -Fm${median}k -E > chain_std/weighted_filtered_widths_median.txt
	gmt filter1d chain_std/weighted_filtered_widths_median.txt -Fg${gaussian}k -E > chain_std/weighted_filtered_widths_gaussian.txt
	gmt convert chain_std/weighted_width_${chain}.txt chain_std/weighted_filtered_widths_gaussian.txt -A > chain_std/weighted_filtered_widths_${chain}_median${median}_gaussian${gaussian}.txt
	# creates file lon,lat,azimuth,dist,sigma 
	gmt math chain_std/weighted_filtered_widths_${chain}_median${median}_gaussian${gaussian}.txt -o0,1,2,5,6 -C6 2 DIV = 1sigma/weighted_filtered_width_1sigma_vs_dist_${chain}_m${median}_g${gaussian}.txt
	# use gmt vector to plot widths in map view
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_${chain}_m${median}_g${gaussian}.txt -i0,1,2+o90,4 -fg -Ttk > chain_std/weighted_width_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_${chain}_m${median}_g${gaussian}.txt -i0,1,2+o-90,4 -fg -Ttk > chain_std/weighted_width_L.txt
	# create markings on line every 500 km
	gmt convert chain_std/weighted_width_${chain}.txt -Em500 > chain_std/500km.txt
	# plotting the results
	gmt figure weighted_median_line_figs_2/widths_weighted_${chain}2_${fw}_${median}m_${gaussian}g_${weights}w pdf,jpg
	gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -JM6i -B -B+t"${chain} ${fw} km 2D Gaussian Filter Width, ${median} km Median ${gaussian} Gaussian km 1D" 
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
	gmt plot chain_std/weighted_width_R.txt -Sc0.5p -Glightgreen -l"Weighted chain width"
	gmt plot chain_std/weighted_width_L.txt -Sc0.5p -Glightgreen
	#plot marking every 500km along the line
	gmt plot chain_std/500km.txt -Sc1p
	# colorbar
	gmt colorbar -B+l"Elevation (m)"
gmt end show 

gmt begin
	gmt figure weighted_median_line_figs_2/filter_${chain}2_median${median}_gaussian${gaussian}_weights${weights} jpg
	gmt plot chain_std/weighted_width_${chain}.txt -JX75c/10c -i3,4 -W0.5p -l"Non-filtered line" -B -BWSne+t"Weighted Chain Width vs Distance for ${chain}" -Bx+l"Distance (km)" -By+l"Weighted Width (km)" --MAP_FRAME_TYPE=plain 
	gmt plot chain_std/weighted_filtered_widths_median.txt -W0.5p,red -l"${median} km median filter"
	gmt plot chain_std/weighted_filtered_widths_${chain}_median${median}_gaussian${gaussian}.txt -i5,6 -W0.5p,blue -l"${gaussian} km gaussian filter"
gmt end show

#making datatable of line and width values
gmt begin
	gmt convert 1sigma/weighted_filtered_width_1sigma_vs_dist_${chain}_m${median}_g${gaussian}.txt -o4 > 1_sig.txt
	gmt convert final_smooth_weighted_line/weighted_line_filtered_resampled_${chain}_${fw}.txt 1_sig.txt chain_std/weighted_width_R.txt chain_std/weighted_width_L.txt -A > weighted_median_line_and_width_${chain}2.txt
	# test median line and weighted width coordinates in table
	#gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -JM6i -B -B+t"Test Plot" 
	#gmt plot weighted_median_line_and_width_${chain}.txt -W0.5p,red
	#gmt plot weighted_median_line_and_width_${chain}.txt -i,7,8 -W0.5p,lightgreen
	#gmt plot weighted_median_line_and_width_${chain}.txt -i,9,10 -W0.5p,lightgreen
gmt end show

# test dist and 1 sig values in table
#gmt begin
	#gmt plot weighted_median_line_and_width_${chain}.txt -JX75c/10c -i2,6 -W0.5p -B -BWSne+t"Weighted Chain Width vs Distance for ${chain}" -Bx+l"Distance (km)" -By+l"1 Sigma (km)" --MAP_FRAME_TYPE=plain
#gmt end show

rm -f temp.txt
rm -f temp2.txt
rm -f distance_azi.txt
rm -f chain_std/smooth_width.txt
rm -f chain_std/weighted_width_R.txt
rm -f chain_std/weighted_width_L.txt
rm -f chain_std/weighted_filtered_widths_median.txt
rm -f chain_std/weighted_filtered_widths_gaussian.txt
rm -f chain_std/500km.txt
rm -f 1_sig.txt