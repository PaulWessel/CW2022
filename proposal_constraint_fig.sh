#!/bin/bash

gmt begin thesis_proposal_figs/const_earth jpg
	gmt coast -Rg -JG200/10/6i -Glightgrey -Bg 
	gmt makecpt -T0/100 -Ccyclic
	# plot HS trails
	gmt plot final_line_width_age_tables/HI_line_width_age.txt -i0,1,11 -Sc0.2 -C 
	gmt plot final_line_width_age_tables/LV_line_width_age.txt -i0,1,11 -Sc0.2 -C 
	#gmt colorbar -B+l"Age (Myr)"
	# plot Hawaii and LV hotspots
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_HI_700.txt -qi1 -Sc0.2 -W1p -Gred
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -qi1 -Sc0.2 -W1p -Gred
	# plot HI seatmout age 57  and great circle to paleopole
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T57, -N11 -o0,1 > tmp1
	gmt plot tmp1 -Sc0.2 -W1p -Gdarkgrey
	# plot LV seatmout age 57  and great circle to paleopole
	gmt sample1d final_line_width_age_tables/LV_line_width_age.txt -T57, -N11 -o0,1 > tmp2
	gmt math tmp2 -C0 360 ADD = tmp2
	gmt plot tmp2 -Sc0.2 -W1p -Gdarkgrey
	# plot GD distance between HI and LV
	gmt plot -W1p <<- EOF 
	170.561317836 39.6033202747
	188.560713238 -33.3393855409
	EOF
	# plot paleolats
	gmt plot -W1p,-- -A <<- EOF
	180 28
	230 28
	EOF
	gmt plot -W1p,-- -A <<- EOF
	195 -45
	250 -45
	EOF
	#plot HS at time t
	echo 210 28.7 | gmt plot -Sc0.2 -W1p -Glightred
	echo 220 -43.8 | gmt plot -Sc0.2 -W1p -Glightred
		# plot labels
	gmt text -F+a+f12p+jCM <<- EOF
	205 -52 -17 Chain 1
	190 22 -20 Chain 2
	EOF
	gmt text -F+a+f12p,Times-Italic+jLM -Dj0.2c <<- EOF
	205 19 0 @%7%h@%%@-2@-(0)
	225 -50.6 0 @%7%h@%%@-1@-(0)
	207.5 32.5 0 @%7%h@%%@-2@-(t)?
	214 -38 0 @%7%h@%%@-1@-(t)?
	170 40 0 @%7%s@%%@-2@-(t)
	190 -30 0 @%7%s@%%@-1@-(t)
	180 5 0 @%7%d@%%@-1,2@-(t)
	EOF
gmt end show

rm -f tmp1
rm -f tmp2