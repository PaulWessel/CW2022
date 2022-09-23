#!/bin/bash
# code to perform a gaussin filter on the residual seamount data and find a weighted line connected height points to the data
fw=$1
chain=$2
gf=$3
MATLAB=/Applications/MATLAB_R2019a.app
# Directory with the APM models on my computer
# Filtering the residual grid and asking for output just for the chain
#gmt grdcut Filter_grids/500m_contour_finial_grid_${chain}.grd -R210/230/-15/-3 -GFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 
#gmt grdmath Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 0 DENAN = Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 
#gmt grdfilter -Fg${fw} Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -I2m -D2 -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd
# Convert center line from kml to txt file
ls start_line/${chain}_edited.kml | awk '{print substr($1,1,2)}' > /tmp/t.lis
while read tag; do
	kml2gmt start_line/${chain}_edited.kml > start_line/${chain}_edited.txt
done < /tmp/t.lis
# Create the cross profiles so we can plot them below
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd start_line/${chain}_edited.txt -C400k/2/20 -fg -Ar -Dchain_lines/start_line_resampled.txt > chain_lines/cross_${fw}_${chain}.txt
gmt convert chain_lines/start_line_resampled.txt > chain_lines/start_line_resampled_${fw}_${chain}.txt
# Same, but now use -F to harvest the median and critical points
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd start_line/${chain}_edited.txt -C400k/2/20 -fg -Ar -F > chain_lines/center.txt
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
# run grdtrack over smooth data
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -C800k/1/1 -fg -Ar -F  > chain_std/smooth_width.txt
# set all zeros to NANs
gmt grdmath Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd 0 NAN = chain_std/500m_contour_finial_grid_${chain}_NAN.grd
# create resampled line
gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd -GFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -Dfinal_smooth_weighted_line/weighted_line_filtered_resampled.txt -C800k/1/1 -fg -Ar  > chain_std/temp2.txt
gmt convert final_smooth_weighted_line/weighted_line_filtered_resampled.txt > final_smooth_weighted_line/weighted_line_filtered_resampled_${chain}_${fw}.txt
# Plotting time
gmt begin weighted_median_line_figs_2/smooth_${chain}_${fw}_${gf}1D_new_line_weighted pdf,jpg
	# Lay down smoothed grid
	gmt grdimage Median_line_figs/smooth_${chain}_${fw}_ne.grd -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -JM6i -B -B+t"${chain} ${fw} km 2D Gaussian Filter Width" 
	# Draw input median line
	gmt plot start_line/${chain}_edited.txt -W0.5p,red -l"Starting line"+ggrey
	# Draw cross-sections
	gmt plot chain_lines/cross_${fw}_${chain}.txt -Wfaint,yellow 
	# Draw the new median line by connecting the dots
	gmt plot chain_lines/center_${fw}_${chain}.txt -W0.25p,white -i1,2 -l"Non-weighted line"
	# ALso plot the actual center points
	#gmt plot chain_lines/center_${chain}.txt -Sc0.5p -Gwhite
	# plot weighted line
	gmt plot final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -W0.25,yellow -l"Weighted line"
	# Plot the left rise point
	#gmt plot chain_lines/center_${fw}_${chain}.txt -Sc1p -Glightgreen -i5,6
	# Plot the right rise point
	#gmt plot chain_lines/center_${fw}_${chain}.txt -Sc1p -Glightred -i8,9
	gmt colorbar -B+l"Elevation (m)"
gmt end show

#chain cuts
#HI -160/210/10/60
#LV -180/230/-60/-20
#CR -140/170/0/15
#CB -200/240/40/60
#FD -220/260/-45/-25
#KO -200/240/40/65
#MQ -210/230/-15/-3
#PC -210/240/-30/-15
#RU -160/220/-30/20
#SA -175/195/-20/-5
