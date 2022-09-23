chain=$1
gmt begin
	#gmt grdmath Filter_grids/420_filter_envelope_HI.grd Filter_grids/420_filter_envelope_LV.grd DENAN Filter_grids/420_filter_envelope_CR.grd DENAN Filter_grids/420_filter_envelope_PC.grd DENAN Filter_grids/420_filter_envelope_MQ.grd DENAN Filter_grids/420_filter_envelope_SA.grd DENAN Filter_grids/420_filter_envelope_KO.grd DENAN Filter_grids/420_filter_envelope_FD.grd DENAN Filter_grids/420_filter_envelope_CB1.grd DENAN Filter_grids/420_filter_envelope_CB2.grd DENAN = Contour_map_420.grd
	# makes finial grid with varying filter width with all chains except SA
	#gmt grdmath Filter_grids/Varying_filter_envelope_HI.grd Filter_grids/Varying_filter_envelope_LV.grd DENAN Filter_grids/Varying_filter_envelope_CR.grd DENAN Filter_grids/Varying_filter_envelope_PC.grd DENAN Filter_grids/Varying_filter_envelope_MQ.grd DENAN Filter_grids/420_filter_envelope_SA.grd DENAN Filter_grids/Varying_filter_envelope_KO.grd DENAN Filter_grids/Varying_filter_envelope_FD.grd DENAN Filter_grids/Varying_filter_envelope_CB1.grd DENAN Filter_grids/Varying_filter_envelope_CB2.grd DENAN Filter_grids/Varying_filter_envelope_RU.grd DENAN = Contour_map_Varying.grd
	#gmt grdmath Contour_map_Varying.grd DUP 500 SUB 0 LT 1 NAN ADD = 500m_contour_finial_grid.grd
	#gmt grdmath Contour_map_Varying.grd DUP 0 SUB 0 LT 1 NAN ADD = no_contour_finial_grid.grd
	# makes finial grid for specific chains
	#gmt grdmath Filter_grids/Varying_filter_envelope_${chain}.grd DUP 500 SUB 0 LT 1 NAN ADD = Filter_grids/500m_contour_finial_grid_${chain}.grd
	# turn NANs to zeros
	gmt grdmath Filter_grids/500m_contour_finial_grid_${chain}.grd 0 DENAN = Filter_grids/500m_contour_finial_grid_${chain}.grd
	#gmt figure Contours/500m_contour_finial_grid.grd jpg
	gmt grdimage Filter_grids/500m_contour_finial_grid_${chain}.grd -JM6i -B
	#gmt plot APM/data/Envelopes/HI_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/LV_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/CR_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/PC_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/MQ_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/SA_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/KO_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/FD_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/CB1_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/CB2_envelope.txt -W0.25p,red
	#gmt plot APM/data/Envelopes/RU_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/${chain}_envelope.txt -W0.25p,red
	gmt colorbar -B
	#gmt figure Contours/Contour_map_420
	#gmt grdimage Contour_map_420.grd -JM6i -B
	#gmt colorbar -B
	#gmt grdmask APM/data/Envelopes/*_envelope.txt -Gall_chains_envelope.grd -RContour_map_Varying.grd -NNaN/1/1
	#echo "0 red 2 red" > t.cpt
    #echo "N gray" >> t.cpt
	#gmt grdimage all_chains_envelope.grd -JM6i -B -Ct.cpt
gmt end show