#!/bin/bash

source plot_end_circles.sh 	# Include this function

#make files for polygons
gmt begin
		#HI
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_HI_M300_g300.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_HI_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_HI_M300_g300.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_HI_L.txt
	cp chain_widths_95/weighted_width_HI_R.txt chain_widths_95/polygon_HI.txt
	gmt convert chain_widths_95/weighted_width_HI_L.txt -I >> chain_widths_95/polygon_HI.txt
		#LV
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_LV_M200_g200.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_LV_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_LV_M200_g200.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_LV_L.txt
	cp chain_widths_95/weighted_width_LV_R.txt chain_widths_95/polygon_LV.txt
	gmt convert chain_widths_95/weighted_width_LV_L.txt -I >> chain_widths_95/polygon_LV.txt
		#RU
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_RU_M400_g400.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_RU_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_RU_M400_g400.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_RU_L.txt
	cp chain_widths_95/weighted_width_RU_R.txt chain_widths_95/polygon_RU.txt
	gmt convert chain_widths_95/weighted_width_RU_L.txt -I >> chain_widths_95/polygon_RU.txt
		#CB
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_CB_M200_g200.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_CB_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_CB_M200_g200.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_CB_L.txt
	cp chain_widths_95/weighted_width_CB_R.txt chain_widths_95/polygon_CB.txt
	gmt convert chain_widths_95/weighted_width_CB_L.txt -I >> chain_widths_95/polygon_CB.txt
		#KO
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_KO_M700_g700.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_KO_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_KO_M700_g700.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_KO_L.txt
	cp chain_widths_95/weighted_width_KO_R.txt chain_widths_95/polygon_KO.txt
	gmt convert chain_widths_95/weighted_width_KO_L.txt -I >> chain_widths_95/polygon_KO.txt
		#FD
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_FD_M150_g150.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_FD_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_FD_M150_g150.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_FD_L.txt
	cp chain_widths_95/weighted_width_FD_R.txt chain_widths_95/polygon_FD.txt
	gmt convert chain_widths_95/weighted_width_FD_L.txt -I >> chain_widths_95/polygon_FD.txt
		#PC
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_PC_M200_g200.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_PC_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_PC_M200_g200.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_PC_L.txt
	cp chain_widths_95/weighted_width_PC_R.txt chain_widths_95/polygon_PC.txt
	gmt convert chain_widths_95/weighted_width_PC_L.txt -I >> chain_widths_95/polygon_PC.txt
		#SA
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_SA_M150_g150.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_SA_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_SA_M150_g150.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_SA_L.txt
	cp chain_widths_95/weighted_width_SA_R.txt chain_widths_95/polygon_SA.txt
	gmt convert chain_widths_95/weighted_width_SA_L.txt -I >> chain_widths_95/polygon_SA.txt
		#CR
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_CR_M600_g600.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_CR_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_CR_M600_g600.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_CR_L.txt
	cp chain_widths_95/weighted_width_CR_R.txt chain_widths_95/polygon_CR.txt
	gmt convert chain_widths_95/weighted_width_CR_L.txt -I >> chain_widths_95/polygon_CR.txt
		#MQ
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_MQ_M250_g250.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_MQ_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_MQ_M250_g250.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_MQ_L.txt
	cp chain_widths_95/weighted_width_MQ_R.txt chain_widths_95/polygon_MQ.txt
	gmt convert chain_widths_95/weighted_width_MQ_L.txt -I >> chain_widths_95/polygon_MQ.txt
		#SO
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_SO_M150_g150.txt -i0,1,2+o90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_SO_R.txt
	gmt vector 1sigma/weighted_filtered_width_1sigma_vs_dist_SO_M150_g150.txt -i0,1,2+o-90,4+s1.96 -fg -Ttk > chain_widths_95/weighted_width_SO_L.txt
	cp chain_widths_95/weighted_width_SO_R.txt chain_widths_95/polygon_SO.txt
	gmt convert chain_widths_95/weighted_width_SO_L.txt -I >> chain_widths_95/polygon_SO.txt
gmt end

gmt begin supplemental/all_chains png
	gmt grdimage @earth_relief_06m -Rg -I+d -JG210/10/6i -Cgray -t40 
	gmt coast -Gwhite -Bg 
	#gmt plot @ridge.txt -W1p
	#gmt plot trench.txt -W1p -Sf0.25/3p
	#gmt plot transform.txt
	#gmt plot PB2002_boundaries.gmt -W0.5p -Sf0.25/3p
	gmt plot Pacific_plate.txt -W1p
	gmt makecpt -T0/100 -Ccyclic
	# Plot poles
	#gmt plot APM/data/Pacific_Paleomagpoles.txt -i0,1,2,3,4+s111,5+s100 -SE -C -W0.25p,white
	#gmt plot APM/data/Pacific_PaleoSpinAxes.txt -i0,1,2,3,4+s111,5+s100 -SE -C -W0.25p
	# plot HS trails
	plot_end_circles HI
	gmt clip chain_widths_95/polygon_HI.txt
	gmt plot final_line_width_age_tables/HI_line_width_age.txt -i0,1,11 -Sc0.5 -C 
	gmt clip -C
	gmt clip chain_widths_95/polygon_LV.txt
	gmt plot final_line_width_age_tables/LV_line_width_age.txt -i0,1,11 -Sc0.5 -C 
	gmt clip -C
	gmt clip chain_widths_95/polygon_RU.txt
	gmt plot final_line_width_age_tables/RU_line_width_age.txt -i0,1,11 -Sc0.5 -C 
	gmt clip -C
	gmt clip chain_widths_95/polygon_CB.txt
	gmt plot final_line_width_age_tables/CB_line_width_age.txt -i0,1,11 -Sc0.5 -C 
	gmt clip -C
	gmt clip chain_widths_95/polygon_KO.txt
	gmt plot final_line_width_age_tables/KO_line_width_age.txt -i0,1,11 -Sc0.5 -C 
	gmt clip -C
	gmt clip chain_widths_95/polygon_FD.txt
	gmt plot final_line_width_age_tables/FD_line_width_age.txt -i0,1,11 -Sc0.5 -C
	gmt clip -C
	gmt clip chain_widths_95/polygon_PC.txt
	gmt plot final_line_width_age_tables/PC_line_width_age.txt -i0,1,11 -Sc0.5 -C
	gmt clip -C
	gmt clip chain_widths_95/polygon_SA.txt
	gmt plot final_line_width_age_tables/SA_line_width_age.txt -i0,1,11 -Sc0.5 -C
	gmt clip -C
	gmt clip chain_widths_95/polygon_CR.txt
	gmt plot final_line_width_age_tables/CR_line_width_age.txt -i0,1,11 -Sc0.5 -C
	gmt clip -C
	gmt clip chain_widths_95/polygon_MQ.txt
	gmt plot final_line_width_age_tables/MQ_line_width_age.txt -i0,1,11 -Sc0.5 -C
	gmt clip -C
	gmt clip chain_widths_95/polygon_SO.txt
	gmt plot final_line_width_age_tables/SO_line_width_age.txt -i0,1,11 -Sc0.5 -C
	gmt clip -C
	# paleo-lat
		#HI
	#gmt plot P_lat/HI_dist_age_plat.txt -Sx0.2 -W0.5,red
		#LV
	#gmt plot P_lat/LV_dist_age_plat.txt -Sx0.2 -W0.5,red
	gmt colorbar -Bxaf -By+l"Myr" -F+gwhite+p1p -DJMR+o-2c/0+w5c --FONT_ANNOT_PRIMARY=6p
	# plot labels
	gmt text -F+a+f12p+jCM -Gwhite <<- EOF
	205 -35 -12 Louisville
	190 21 -25 Hawaiian-Emperor
	185	-3 -10 Rurutu
	215 47 -20 Cobb
	225 59	-20 Kodiak
	230 -38 0 Foundation
	223 -17 -10 Pitcairn
	184 -19 -15 Samoa
	155 2 -40 Caroline
	233 -10 0 Marquesas
	210 -11 -20 Society
	EOF
gmt end show
