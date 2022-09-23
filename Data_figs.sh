#!/bin/bash

#make cpt for HI
gmt makecpt -Cturbo -T0/6000 --COLOR_NAN=white > t.cpt
gmt makecpt -Cturbo -T-1/1700 --COLOR_NAN=white > t_smooth.cpt
#make cpt for LV
gmt makecpt -Cturbo -T-1/300 --COLOR_NAN=white > t_smooth_LV.cpt
# figure showing raw seafloor, filtered seafloor and contour threshold
gmt begin
	#make grid of all varying filters
	#gmt grdmath Filter_grids/Varying_filter_MQ.grd Filter_grids/Varying_filter_PC.grd AND Filter_grids/Varying_filter_FD.grd AND Filter_grids/420_filter_SA.grd AND = Filter_grids/varying_all_chains.grd
	#make grid of all filtered chains in their envelopes
	#gmt grdmath Filter_grids/Varying_filter_envelope_HI.grd Filter_grids/Varying_filter_envelope_LV.grd AND Filter_grids/420_filter_envelope_SA.grd AND Filter_grids/Varying_filter_envelope_RU.grd AND Filter_grids/Varying_filter_envelope_CB.grd AND Filter_grids/Varying_filter_envelope_KO.grd AND Filter_grids/Varying_filter_envelope_FD.grd AND Filter_grids/Varying_filter_envelope_PC.grd AND Filter_grids/Varying_filter_envelope_CR.grd AND Filter_grids/Varying_filter_envelope_MQ.grd AND Filter_grids/Varying_filter_envelope_SO.grd AND = Filter_grids/all_chains_envelope.grd
	# make grid of all 500m contour chains
	#gmt grdmath Filter_grids/500m_contour_finial_grid_SA.grd Filter_grids/500m_contour_finial_grid_RU.grd AND Filter_grids/500m_contour_finial_grid_HI.grd AND Filter_grids/500m_contour_finial_grid_LV.grd AND Filter_grids/500m_contour_finial_grid_CB.grd AND Filter_grids/500m_contour_finial_grid_KO.grd AND Filter_grids/500m_contour_finial_grid_FD.grd AND Filter_grids/500m_contour_finial_grid_PC.grd AND Filter_grids/500m_contour_finial_grid_CR.grd AND Filter_grids/500m_contour_finial_grid_MQ.grd AND Filter_grids/500m_contour_finial_grid_SO.grd AND = 500m_contour_finial_grid.grd
	#plotting
	#gmt figure seafloor_filtering png
	#gmt subplot begin 1x4 -Fs8c -R148/250.5/-52/58 -A+gwhite+o0.3c/-3.2c
		#gmt subplot set
		#gmt grdimage Pacific_topo_1m.grd -Cgeo -JM9c -BSWNe --MAP_FRAME_TYPE=plain
		#gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
		#gmt subplot set
		#gmt grdimage pacific_topo_sub_median_gaussian_420.grd -JM9c -BwSNe --MAP_FRAME_TYPE=plain
		#gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
		#gmt subplot set
		#gmt grdimage Filter_grids/all_chains_envelope.grd -JM9c -BwSNe -Ct.cpt --MAP_FRAME_TYPE=plain 
		#gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 -Ct.cpt --FONT_ANNOT_PRIMARY=6p
		#gmt subplot set
		#gmt grdimage 500m_contour_finial_grid.grd -JM9c -BwSNE -Ct.cpt --MAP_FRAME_TYPE=plain
		#gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 -Ct.cpt --FONT_ANNOT_PRIMARY=6p
	#gmt subplot end
gmt end show

# figure showing raw seafloor, filtered seafloor and contour threshold, try with 2x2
gmt begin
	#make grid of all varying filters
	#gmt grdmath Filter_grids/Varying_filter_MQ.grd Filter_grids/Varying_filter_PC.grd AND Filter_grids/Varying_filter_FD.grd AND Filter_grids/420_filter_SA.grd AND = Filter_grids/varying_all_chains.grd
	#make grid of all filtered chains in their envelopes
	#gmt grdmath Filter_grids/Varying_filter_envelope_HI.grd Filter_grids/Varying_filter_envelope_LV.grd AND Filter_grids/420_filter_envelope_SA.grd AND Filter_grids/Varying_filter_envelope_RU.grd AND Filter_grids/Varying_filter_envelope_CB.grd AND Filter_grids/Varying_filter_envelope_KO.grd AND Filter_grids/Varying_filter_envelope_FD.grd AND Filter_grids/Varying_filter_envelope_PC.grd AND Filter_grids/Varying_filter_envelope_CR.grd AND Filter_grids/Varying_filter_envelope_MQ.grd AND Filter_grids/Varying_filter_envelope_SO.grd AND = Filter_grids/all_chains_envelope.grd
	# make grid of all 500m contour chains
	#gmt grdmath Filter_grids/500m_contour_finial_grid_SA.grd Filter_grids/500m_contour_finial_grid_RU.grd AND Filter_grids/500m_contour_finial_grid_HI.grd AND Filter_grids/500m_contour_finial_grid_LV.grd AND Filter_grids/500m_contour_finial_grid_CB.grd AND Filter_grids/500m_contour_finial_grid_KO.grd AND Filter_grids/500m_contour_finial_grid_FD.grd AND Filter_grids/500m_contour_finial_grid_PC.grd AND Filter_grids/500m_contour_finial_grid_CR.grd AND Filter_grids/500m_contour_finial_grid_MQ.grd AND Filter_grids/500m_contour_finial_grid_SO.grd AND = 500m_contour_finial_grid.grd
	# plotting
	#gmt figure thesis_figs/seafloor_filtering png
	#gmt subplot begin 2x2 -Fs10c/13c -R148/250.5/-52/58 -A+gwhite+o0.5c/0.3c
	#	gmt subplot set
	#	gmt grdimage Pacific_topo_1m.grd -Cgeo -BWsNe -JM? --MAP_FRAME_TYPE=plain
	#	gmt colorbar -Bxaf -By+l"m" -DJBC+o-2.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
	#	gmt subplot set
	#	gmt grdimage pacific_topo_sub_median_gaussian_420.grd -JM? -BwsNE --MAP_FRAME_TYPE=plain
	#	gmt colorbar -Bxaf -By+l"m" -DJBC+o-2.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
	#	gmt text -F+a+f9p+jCM -Gwhite <<- EOF
		#	180 40 0 HR
		#	158 40 0 SR
		#	180 13 0 MM
		#	174 -40 0 HP
		#	203 -7 0 MP 
		#	158 -10 0 OP
		#EOF
		#gmt subplot set
		#gmt grdimage Filter_grids/all_chains_envelope.grd -JM? -BWSne -Ct.cpt --MAP_FRAME_TYPE=plain 
		#gmt colorbar -Bxaf -By+l"m" -DJBC+o-2.8c/-1c+w3c/0.3 -Ct.cpt --FONT_ANNOT_PRIMARY=6p
		#gmt subplot set
		#gmt grdimage 500m_contour_finial_grid.grd -JM? -BwSnE -Ct.cpt --MAP_FRAME_TYPE=plain
		#gmt colorbar -Bxaf -By+l"m" -DJBC+o-2.8c/-1c+w3c/0.3 -Ct.cpt --FONT_ANNOT_PRIMARY=6p
	#gmt subplot end
gmt end show

# plot showing smoothed seamounts with cross profiles and the median trail line for HI
#gmt makecpt -Chaxby -T0/5000 -H > t.cpt

gmt begin
		# get width in 95 confidence
	#gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_HI_M300_g300.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_std/weighted_width_R.txt
	#gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_HI_M300_g300.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_std/weighted_width_L.txt
		#plot
	#gmt figure thesis_figs/SE_HI_median_line png
	#gmt set FONT_HEADING 28p,Helvetica,black MAP_FRAME_TYPE plain
	#gmt subplot  begin 4x1 -Fs8c/0 -JM8c -R170/208/17/32 -A+gwhite -SCb -SRl -M0 #-B -SR -SC --MAP_FRAME_TYPE=plain 
	#	gmt subplot set #residual data with starting line
	#	gmt grdimage 500m_contour_finial_grid.grd -Ct.cpt --COLOR_NAN=white #--MAP_FRAME_TYPE=plain -BWsNE
	#	gmt plot start_line/HI_edited.txt -W1p,black -l"Starting line"+ggrey
	#	gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -Ct.cpt
	#	gmt subplot set #smooth grid with cross profiles
	#	gmt grdimage Median_line_figs/smooth_HI_700_ne.grd -Ct_smooth.cpt #--MAP_FRAME_TYPE=plain -BWsnE
	#	gmt plot chain_lines/cross_700_HI.txt -Wfaint,yellow -l"Cross-profiles"+ggrey
	#	gmt plot start_line/HI_edited.txt -W1p,black #-l"Starting line"
	#	gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -Ct_smooth.cpt -F+gwhite+p1p
	#	gmt subplot set #median trail line
	#	gmt grdimage Median_line_figs/smooth_HI_700_ne.grd -Ct_smooth.cpt #--MAP_FRAME_TYPE=plain -BWsnE
	#	gmt plot chain_lines/cross_700_HI.txt -Wfaint,yellow 
	#	gmt plot start_line/HI_edited.txt -W1p,black #-l"Starting line"
	#	gmt plot chain_lines/center_700_HI.txt -W1p,red -i1,2 -l"Medial trail line"+ggrey
	#	gmt subplot set # chain width
	#	gmt grdimage 500m_contour_finial_grid.grd -Ct.cpt --COLOR_NAN=white #--MAP_FRAME_TYPE=plain -BWSnE
	#	gmt plot final_line_width_age_tables/HI_line_width_age.txt -W1p,red #-l"Inferred hotspot trail"+ggrey
	#	gmt plot chain_std/weighted_width_R.txt -W1p,purple -l"95%% confidence"+ggrey
	#	gmt plot chain_std/weighted_width_L.txt -W1p,purple
	#gmt subplot end
gmt end show

#Now showing Louisville and Weighted line
#gmt begin
	#gmt figure thesis_figs/SE_LV_weighted_line png
	#gmt set FONT_HEADING 28p,Helvetica,black MAP_FRAME_TYPE plain
	#gmt subplot  begin 3x1 -Fs8c/0 -JM8c -R195/225/-52/-40 -A+gwhite -SCb -SRl -M0
	#gmt subplot  begin 3x1 -Fs8c/0 -JM8c -R195/225/-52/-40 -A+gwhite #-B -SC -SR 
	#	gmt subplot set #residual data with starting line
	#	gmt grdimage 500m_contour_finial_grid.grd -Ct.cpt --COLOR_NAN=white --MAP_FRAME_TYPE=plain -BWsNE
	#	gmt plot start_line/LV_edited.txt -W1p,black -l"Starting line"+ggrey
	#	gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -Ct.cpt
	#	gmt subplot set #median trail line
	#	gmt grdimage Median_line_figs/smooth_LV_700_ne.grd -Ct_smooth_LV.cpt --MAP_FRAME_TYPE=plain -BWsnE
	#	gmt plot chain_lines/cross_700_LV.txt -Wfaint,yellow 
	#	gmt plot start_line/LV_edited.txt -W1p,black #-l"Starting line"
	#	gmt plot chain_lines/center_700_LV.txt -W1p,red -i1,2 -l"Medial trail line"+ggrey
	#	gmt colorbar -Bxaf -By+l"m" -DJBC+o-1.8c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -Ct_smooth_LV.cpt -F+gwhite+p1p
	#	gmt subplot set #weighted trail line
	#	gmt grdimage Median_line_figs/smooth_LV_700_ne.grd -Ct_smooth_LV.cpt --MAP_FRAME_TYPE=plain -BWSnE
	#	#gmt plot chain_lines/cross_700_LV.txt -Wfaint,yellow 
	#	gmt plot start_line/LV_edited.txt -W1p,black #-l"Starting line"
	#	gmt plot chain_lines/center_700_LV.txt -W1p,red -i1,2
	#	gmt plot final_smooth_weighted_line/weighted_line_filtered_LV_700.txt -W1p,white -l"Weighted line"+ggrey
	#gmt subplot end
#gmt end show

#plot showing chain wodth uncertainty
gmt begin
	# get width in 95 confidence
	#gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_HI_M300_g300.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_std/weighted_width_R.txt
	#gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_HI_M300_g300.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_std/weighted_width_L.txt
	#plot
	#gmt figure meetings/SE_HI_width png
	#gmt grdimage 500m_contour_finial_grid.grd -R169/208/17/34 -JM12c -B --MAP_FRAME_TYPE=plain
	#gmt plot final_line_width_age_tables/HI_line_width_age.txt -W1p,red -l"Inferred hotspot trail"+ggrey
	#gmt plot chain_std/weighted_width_R.txt -W1p,white -l"95% confidence"
	#gmt plot chain_std/weighted_width_L.txt -W1p,white
gmt end show

#plot of extrapolated ages onto the hawaii hotspot trail
#HI:162/206/18/55
#LV 184/225/-52/-25
#RU 170/210/-25/10
#SO 205/215/-20/-15
gmt begin thesis_figs/HI_ages png
	gmt grdimage Pacific_topo_1m.grd -R162/206/18/55 -JM4i -Cgray -t30  -I+d #-B+t"Age Samples for Hawaiian-Emperor"
	gmt basemap -R162/206/18/55 -JM4i -B --MAP_FRAME_TYPE=plain
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_HI_700.txt -W1p,red -l"Inferred hotspot trail"
	gmt plot chain_ages/HI_info.txt -Sc0.2 -Gwhite -W0.5 -l"Age sample locations"
	gmt makecpt -T0/100 -Cturbo -I
	gmt plot chain_ages/HI_info.txt -i5,6,2 -Sc0.2 -W0.5 -C
	echo 0 0 | gmt plot -Sc0.2 -W0.5 -Gdarkred -l"Projected sample"
	gmt colorbar -Bxaf -By+l"Myr" -DJBC+o-3c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
gmt end show

# for Lousiville dashed line
gmt begin meetings/LV_ages png
	#gmt grdimage Pacific_topo_1m.grd -R184/225/-52/-25 -JM4i -Cgeo -B --MAP_FRAME_TYPE=plain #-B+t"Age Samples for Hawaiian-Emperor"
	#gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -q0:900 -W1p,red,dashed
	#gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -q901:5898 -W1p,red -l"Inferred hotspot trail"
	#gmt plot chain_ages/LV_info.txt -Sc0.2 -Ggrey -W0.5 -l"Age sample locations"
	#gmt makecpt -T0/100 -Ccyclic
	#gmt plot chain_ages/LV_info.txt -i5,6,2 -Sc0.2 -W0.5 -C
	#gmt colorbar -B+l"Age (Myr)"
gmt end show

#for Rurutu dashed line
gmt begin meetings/RU_ages png
	#gmt grdimage Pacific_topo_1m.grd -R170/210/-25/10 -JM4i -Cgeo -B --MAP_FRAME_TYPE=plain #-B+t"Age Samples for Hawaiian-Emperor"
	#gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_RU_700.txt -q0:1200 -W1p,red -l"Inferred hotspot trail"
	#gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_RU_700.txt -q1201:3300 -W1p,red,dashed 
	#gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_RU_700.txt -q3301:5880 -W1p,red
	#gmt plot chain_ages/RU_info.txt -Sc0.2 -Ggrey -W0.5 -l"Age sample locations"
	#gmt makecpt -T0/100 -Ccyclic
	#gmt plot chain_ages/RU_info.txt -i5,6,2 -Sc0.2 -W0.5 -C
	#gmt colorbar -B+l"Age (Myr)"
gmt end show