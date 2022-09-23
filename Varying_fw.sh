chain=$1
gmt begin
	gmt grdcut blockmean_guassian2000m_${chain}.grd -R130/260/-65/65 -Gfw.grd
	gmt grdmask ${chain}_line.txt -G${chain}_mask.grd -Rpacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -N1/NaN/NaN
	gmt grdmath ${chain}_mask.grd pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd MUL = pacific_topo_1m_raw_subfloorHW_subsed_with_${chain}masks.grd
	gmt grdfilter pacific_topo_1m_raw_subfloorHW_subsed_with_${chain}masks.grd -Fmfw.grd -D2 -I10m -GMedian_${chain}.grd
	gmt grdfilter Median_${chain}.grd -Fgfw.grd -D2 -I10m -GMedian_guassian_${chain}.grd
	gmt grdsample Median_guassian_${chain}.grd -I1m -GMedian_guassian_${chain}.grd
	gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd Median_guassian_${chain}.grd SUB = Residual_minus_filter_${chain}.grd
	gmt figure Residual_minus_filter_${chain}_230
	gmt grdimage Residual_minus_filter_${chain}.grd -JM6i -B 
	gmt colorbar -B 
gmt end show