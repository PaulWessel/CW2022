#!/bin/bash
# script used to smooth the azumiths of the weighted median trail line
fw=$1
chain=$2
lfw=$3
gmt begin
	# deal with longitudes that cross the meridian
	gmt math chain_lines/weighted_line_resampled_${chain}_${fw}.txt -C0 DUP 0 LE 360 MUL ADD = line_smoothing/distance_azi_${chain}_${fw}.txt
	# perform 1d filter on line
	gmt filter1d line_smoothing/distance_azi_${chain}_${fw}.txt -Fg${lfw}k -N2 -E > line_smoothing/line_filtered_${chain}_${fw}_${lfw}.txt
	# use grdtrack to plot the new cross profiles
	gmt grdtrack -GFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd line_smoothing/line_filtered_${chain}_${fw}_${lfw}.txt -C800k/2/20 -fg -Ar -Dline_smoothing/line_filtered_resampled_${chain}_${fw}_${lfw}.txt > line_smoothing/cross_${chain}_${fw}_${lfw}.txt
	# plotting the line and cross profiles
	gmt figure line_smoothing/line_filtered_${chain}_${fw}_${lfw} pdf,jpg
	gmt grdimage Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -JM6i -B
	gmt plot chain_lines/weighted_line_resampled_${chain}_${fw}.txt -W0.25 -l"Non-filtered line"
	gmt plot line_smoothing/line_filtered_${chain}_${fw}_${lfw}.txt -W0.25,red -l"${lfw} km gaussian filtered line"
	gmt plot line_smoothing/cross_${chain}_${fw}_${lfw}.txt -Wfaint,yellow
gmt end show

gmt begin
	# plots azimuth vs distance for given filter width
	gmt figure line_smoothing/dist_azm_${chain}_${fw}_${lfw} pdf,jpg
	gmt plot chain_lines/weighted_line_resampled_${chain}_${fw}.txt -i2,3 -JX6i -l"Non-filtered line"+jBR -B -BWSne+t"Azimuth vs Distance for ${chain}" -Bx+l"Distance (km)" -By+l"Azimuth (degrees)" --MAP_FRAME_TYPE=plain
	gmt plot line_smoothing/line_filtered_resampled_${chain}_${fw}_${lfw}.txt -i2,3 -Wred -l"${lfw} km gaussian filtered line"
gmt end show
