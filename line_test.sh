#!/bin/bash
fw=$1
chain=$2

gmt begin
	gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -JM6i -B
	gmt plot final_smooth_weighted_line/weighted_line_filtered_${chain}_${fw}.txt -W0.25,red
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_${chain}_${fw}.txt -W0.25,black
gmt end show