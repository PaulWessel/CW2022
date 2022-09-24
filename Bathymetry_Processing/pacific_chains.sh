gmt begin
		# extracting pacific topography data at 2min
	#gmt grdcut -R130/260/-65/65 earth_relief_v2_01m.grd -GPacific_topo_1m.grd
		# plot raw data
	gmt figure raw_topo_1m_jet jpg
	gmt grdimage Pacific_topo_1m.grd -JM6i -B -Cjet
	#gmt plot APM/data/Envelopes/*_envelope.txt -W0.5,red
		# subtact old grdcut from new one and plot it
	#gmt grdcut -R130/260/-65/65 @earth_relief_02m -Gpacific_topo_2m.grd
	#gmt grdsample Pacific_topo_2m.grd -I1m -GOld_pacific_topo_1m.grd
	#gmt grdmath Pacific_topo_1m.grd Old_pacific_topo_1m.grd SUB = new_sub_old_pactopo.grd
	#gmt figure New_features
	#gmt grdimage new_sub_old_pactopo.grd -JM6i -B
		# extract age curve data and convert to 1m
	#gmt grdcut -R130/260/-65/65 agegrid_final_mask_2m_0.grd -GAge_curve.grd
	#gmt grdsample Age_curve.grd -I1m -GAge_curve_1m.grd
	#gmt figure Pacific_ages_plot jpg
	#gmt grdimage Age_curve_1m.grd -JM6i -B
		# convert age to depth using Hillier and Watts, 2005 N Pacific model
	#gmt grdmath Age_curve_1m.grd SQRT 307 MUL 3010 ADD Age_curve_1m.grd 78.25 LT MUL Age_curve_1m.grd 0.026 MUL NEG EXP 3010 MUL 6120 SUB NEG Age_curve_1m.grd 78.25 GE MUL ADD NEG = hw.grd
	#gmt figure hw_plot jpg
	#gmt grdimage hw.grd -JM6i -B
		# subtracting the age/distance data from raw data
	#gmt grdmath hw.grd 0 DENAN =  hw_noNAN.grd
	#gmt grdmath Pacific_topo_1m.grd hw_noNAN.grd SUB = raw_sub_floor.grd
	#gmt figure raw_sub_floor_plot jpg
	#gmt grdimage raw_sub_floor.grd -JM6i -B
		# extracting sediment thickness data
	#gmt grdcut -R130/260/-65/65 sedthick_world_v2.grd -Gsedthick_pacific_v2.grd
	#gmt grdsample sedthick_pacific_v2.grd -I1m -Gsedthick_pacific_v2_1m.grd
	#gmt figure sed_thick_plot jpg
	#gmt grdimage sedthick_pacific_v2_1m.grd -JM6i -B
		# subtracting sediment thickness from raw_sub_age grid
	#gmt grdmath sedthick_pacific_v2_1m.grd 0 DENAN = sedthick_pacific_v2_1m_noNAN.grd
	#gmt grdmath raw_sub_floor.grd sedthick_pacific_v2_1m_noNAN.grd SUB = pacific_topo_1m_raw_subfloorHW_subsed.grd
	#gmt figure raw_subageHW_subsed_plot jpg
	#gmt grdimage pacific_topo_1m_raw_subfloorHW_subsed.grd -JM6i -B
		# adding the masks
    #gmt grdmask Pacific_Masks_Improved.txt -GPacific_masks.grd -Rpacific_topo_1m_raw_subfloorHW_subsed.grd -N1/1/NAN
    #gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed.grd Pacific_masks.grd MUL = pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd
    #gmt figure raw_subfloorHW_subsed_with_masks_plot pdf,jpg
    #gmt grdimage pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -JM6i -B
    	# apply spatial median filter with width 420km 
    #gmt grdfilter pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -Gpacific_topo_median_filter_420_5m.grd -R140/250/-60/60 -Fm420 -D2 -I5m -Vd
    #gmt grdsample pacific_topo_median_filter_420_5m.grd -I1m -Gpacific_topo_median_filter_420_5m_to1m.grd
    #gmt figure pacific_chains_median_5m pdf,jpg
    #gmt grdimage pacific_topo_median_filter_420_5m_to1m.grd -JM6i -B
     # running a filter at 10m to compare with 5m
    #gmt grdfilter pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -Gpacific_topo_median_filter_420_10m.grd -R140/250/-60/60 -Fm420 -D2 -I10m -Vd
    #gmt grdsample pacific_topo_median_filter_420_10m.grd -I1m -Gpacific_topo_median_filter_420_10m_to1m.grd
    #gmt grdmath pacific_topo_median_filter_420_5m_to1m.grd pacific_topo_median_filter_420_10m_to1m.grd SUB = 5m_sub_10m.grd 
    #gmt figure 5m_sub_10m jpg 
    #gmt grdimage 5m_sub_10m.grd -JM6i -B
    	# adding the gaussian filter
    #gmt grdfilter pacific_topo_median_filter_420_5m_to1m.grd -Gpacific_topo_median_gaussian_420_5m.grd -R140/250/-60/60 -Fg420 -D2 -I5m -Vd
    #gmt grdsample pacific_topo_median_gaussian_420_5m.grd -Gpacific_topo_median_gaussian_420_5m_to1m.grd -I1m
    #gmt figure pacific_chains_median_guassian_420 pdf,jpg
    #gmt grdimage pacific_topo_median_gaussian_420_5m_to1m.grd -JM6i -B
    	# subtracting the median gaussian filter
    #gmt grdcut pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -Gpacific_topo_1m_raw_subfloorHW_subsed_with_masks_cut.grd -R140/250/-60/60
    #gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed_with_masks_cut.grd pacific_topo_median_gaussian_420_5m_to1m.grd SUB = pacific_topo_sub_median_gaussian_420.grd
    #gmt figure pacific_topo_sub_median_gaussian_420_plot pdf,jpg
    #gmt grdimage pacific_topo_sub_median_gaussian_420.grd -JM6i -B 
    	# make mask isolating the chains
    #gmt grdmask APM/data/Envelopes/*_envelope.txt -Genvelope_masks.grd -Rpacific_topo_sub_median_gaussian_420.grd -NNaN/1/1
    #echo "0 red 2 red" > t.cpt
    #echo "N gray" >> t.cpt
    #gmt figure envelope_masks jpg
    #gmt grdimage envelope_masks.grd -JM6i -B -Ct.cpt
    	# multiply masks with grid
    #gmt grdmath pacific_topo_sub_median_gaussian_420.grd envelope_masks.grd MUL = pacific_topo_sub_median_gaussian_420_raw_envelope.grd
    #gmt grdmath pacific_topo_sub_median_gaussian_420.grd envelope_masks.grd MUL DUP 400 SUB 0 LT 1 NAN ADD = pacific_topo_sub_median_gaussian_420_raw_envelope_400.grd
    #gmt figure pacifc_chains_envelope_400 pdf,jpg
    #gmt grdimage pacific_topo_sub_median_gaussian_420_raw_envelope_400.grd -JM6i -B
	gmt colorbar -B
gmt end show
