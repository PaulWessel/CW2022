gmt begin
	gmt grdfilter Masked_residual_emperor.grd -Fm260k -D2 -I10m -GEmperor_median.grd
	gmt grdfilter Emperor_median.grd -Fg260k -D2 -I10m -GEmperor_median_guassian.grd
	gmt grdsample Emperor_median_guassian.grd -I1m -Gtmp.grd
	gmt grdmath -R166/174/39/49 Masked_residual_emperor.grd tmp.grd SUB = Residual_minus_filters_emperor.grd
	gmt grdmath -R166/174/39/49 pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd Residual_minus_filters_emperor.grd SUB = residual_minus_residualfilter.grd
	gmt figure residual_minus_residualfilter_260
	gmt grdimage -R166/174/39/49 residual_minus_residualfilter.grd -JM6i -B 
	gmt colorbar -B
gmt end show