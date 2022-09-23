gmt begin dist_age_data jpg
	gmt grdimage 500m_contour_finial_grid.grd -RMedian_line_figs/smooth_HI_500_ne.grd -JM6i -B
	gmt plot chain_lines/center_HI.txt -W0.5p,white
	#gmt plot HI_info.txt -i0,1 -Sc0.1
	gmt plot HI_info.txt -i5,6 -Sc0.1
gmt end show