#!/bin/bash

gmt begin thesis_proposal_figs/Plat_earth2 jpg
	gmt coast -Rg -JG235/20/6i -Glightgrey -Bg
	# Plot hotspot trails
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_HI_700.txt -W3p,lightblue
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -W3p,lightblue
	#plot Hawaii and LV hotspots
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_HI_700.txt -qi1 -Sc0.2 -Wfaint -Gred
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -qi1 -Sc0.2 -Wfaint -Gred
	# Plot magnetic anaomaly skewness and paleopole
	echo 4.8 78.2 93 725 465| gmt plot -SE -Gpink -Wfaint
	echo 4.8 78.2 5| gmt plot -SE50 -Gblack
	# plot HI seatmout age 57  and great circle to paleopole
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T57, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -Wfaint -Gblue
	echo 4.8 78.2 >> tmp
	gmt plot tmp -W1p,--
	# now same for LV
	gmt sample1d final_line_width_age_tables/LV_line_width_age.txt -T57, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -Wfaint -Gblue
	echo 4.8 78.2 >> tmp
	gmt plot tmp -W1p,--
	# plot labels
	gmt text -F+a+f12p+jCM <<- EOF
	205 -35 -17 Chain 1
	180 23 -40 Chain 2
	330 78 0 57 Myr
	300	76 0 skewness pole
	EOF
	gmt text -F+a+f12p,Times-Italic+jLM -Dj0.2c <<- EOF
	205 19 0 @%7%h@%%@-2@-(0)
	225 -50.6 0 @%7%h@%%@-1@-(0)
	170 40 0 @%7%s@%%@-2@-(57)
	190 -30 0 @%7%s@%%@-1@-(57)
	EOF
gmt end show