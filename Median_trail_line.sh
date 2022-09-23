#!/bin/bash
fw=$1
chain=$2
# Directory with the APM models on my computer
# Filtering the residual grid and asking for output just for the chain
#gmt grdfilter -Fg${fw} Filter_grids/500m_contour_finial_grid_${chain}.grd -RFilter_grids/500m_contour_finial_grid_${chain}.grd -I2m -D2 -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd
# Convert center line from kml to txt file
ls start_line/${chain}_edited.kml | awk '{print substr($1,1,2)}' > /tmp/t.lis
while read tag; do
	kml2gmt start_line/${chain}_edited.kml > start_line/${chain}_edited.txt
done < /tmp/t.lis
# Create the cross profiles so we can plot them below
#gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd start_line/${chain}_edited.txt -C400k/2/20 -fg -Ar -Dchain_lines/start_line_resampled_${chain}.txt > chain_lines/cross_${chain}.txt
# Same, but now use -F to harvest the median and critical points
#gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd start_line/${chain}_edited.txt -C400k/2/20 -fg -Ar -F+b > chain_lines/center_${chain}.txt
# Plotting time
#gmt begin Median_line_figs/smooth_${chain}_${fw}_ne png
gmt begin median_line_figs/smooth_${chain}_${fw}_new_line jpg
	# Lay down smoothed grid
	gmt grdimage Median_line_figs/smooth_${chain}_${fw}_ne.grd -R180/230/-60/-20 -JM6i -B
	# Draw input median line
	gmt plot start_line/${chain}_edited.txt -W0.5p,red -l"Starting line"
	# Draw cross-sections
	#gmt plot chain_lines/cross_${chain}.txt -Wfaint,yellow 
	# Draw the new median line by connecting the dots
	gmt plot chain_lines/center_${chain}.txt -W0.25p,white -l"Non-weighted line"
	# ALso plot the actual center points
	gmt plot chain_lines/center_${chain}.txt -Sc0.5p -Gwhite
	# Plot the left rise point
	#gmt plot chain_lines/center_${chain}.txt -Sc1p -Glightgreen -i5,6
	# Plot the right rise point
	#gmt plot chain_lines/center_${chain}.txt -Sc1p -Glightred -i8,9
	gmt colorbar -B+l"Elevation (m)"
gmt end show