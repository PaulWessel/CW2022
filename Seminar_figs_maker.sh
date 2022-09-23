#MAKING FIGURES FOR SEAFLOOR FILTERING
gmt begin
	# colorblind friendly cpt
	#gmt makecpt -Cpolar -T-11000/11000
	# raw data
	#gmt figure Seminar_figs/raw_topo_1m_HI jpg
	#gmt grdimage Pacific_topo_1m.grd -R150/220/0/60 -JM6i -B -B+t"Raw Topography Data"
	#gmt colorbar -B+l"Elevation (m)"
	# Zoom in on Hawa
	#gmt figure Seminar_figs/raw_topo_1m_HI_line_ages jpg
	#gmt grdimage Pacific_topo_1m.grd -R160/210/10/60 -JM6i -B
	#gmt plot start_line/HI_edited.txt -W1p,red
	#gmt makecpt -T0/100 -Ccyclic
	#gmt plot APM/data/Pacific_Ages_copy.txt -i0,1,2 -Sc0.1c -W0.5 -C
	#gmt colorbar -B+l"Age (Ma)"
	# subtracting ocean floor depth
	#gmt figure Seminar_figs/raw_sub_floor jpg
	#gmt grdimage raw_sub_floor.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# subtracting sediment 
	#gmt figure Seminar_figs/pacific_topo_1m_raw_subfloorHW_subsed jpg
	#gmt grdimage pacific_topo_1m_raw_subfloorHW_subsed.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# adding masks
	#gmt figure Seminar_figs/pacific_topo_1m_raw_subfloorHW_subsed_with_masks jpg
	#gmt grdimage pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# cut grd image to match size after filter
	#gmt grdcut pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -R140/250/-60/60 -Gpacific_topo_1m_raw_subfloorHW_subsed_with_masks_cut.grd
	#gmt figure Seminar_figs/pacific_topo_1m_raw_subfloorHW_subsed_with_masks_cut jpg
	#gmt grdimage pacific_topo_1m_raw_subfloorHW_subsed_with_masks_cut.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# filtering and subtracting the filters
	#gmt figure Seminar_figs/pacific_topo_sub_median_gaussian_420 jpg
	#gmt grdimage pacific_topo_sub_median_gaussian_420.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# adding envelopes
	#gmt figure Seminar_figs/pacific_topo_sub_median_gaussian_420_envelopes jpg
	#gmt grdimage pacific_topo_sub_median_gaussian_420.grd -JM6i -B
	#gmt plot APM/data/Envelopes/*_envelope.txt -W0.5p,black
	#gmt colorbar -B+l"Elevation (m)"
	# making everything outside envelopes
	#gmt figure Seminar_figs/Contour_map_Varying jpg
	#gmt grdimage Contour_map_Varying.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# adding 500m contour
	#gmt figure Seminar_figs/500m_contour_finial_grid jpg
	#gmt grdimage 500m_contour_finial_grid.grd -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# zooming in on Hawaii
	#gmt figure Seminar_figs/500m_contour_finial_grid_HI jpg
	#gmt grdimage 500m_contour_finial_grid.grd -R160/210/16/60 -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# Guassian filter over finial grid
	#gmt figure Seminar_figs/smooth_HI_500 jpg
	#gmt grdimage Median_line_figs/smooth_HI_500_ne.grd -R160/210/16/60 -JM6i -B
	#gmt colorbar -B+l"Elevation (m)"
	# plot starting line
	#gmt figure Seminar_figs/HW_start_line jpg
	#gmt grdimage Median_line_figs/smooth_HI_500_ne.grd -R160/210/16/60 -JM6i -B
	#gmt plot start_line/HI_edited.txt -W1p,red
	#gmt colorbar -B+l"Elevation (m)"
gmt end show