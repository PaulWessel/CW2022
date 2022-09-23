#!/bin/bash

gmt begin thesis_proposal_figs/param_earth2 jpg
	gmt coast -Rg -JG230/45/6i -Glightgrey -Bg 
	gmt makecpt -T0/100 -Ccyclic
	#plot lines for HS east-west rotation pole
	gmt plot -W0.5p,orange <<- EOF
	0 90
	205	19.3178853822
	EOF
	gmt plot -W0.5p,orange,-- <<- EOF
	205	19.3178853822
	210 -90
	EOF
	# HS north-south rotation
	gmt plot -W0.5p,orange <<- EOF
	300 0
	205	0
	EOF
	gmt plot -W0.5p,orange,-- <<- EOF
	205 0 
	100 0
	EOF
	# plot HS trails
	gmt plot final_line_width_age_tables/HI_line_width_age.txt -i0,1,11 -Sc0.2 -Glightgreen
	#gmt colorbar -B+l"Age (Myr)"
	# plot Hawaii
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_HI_700.txt -qi1 -Sc0.2 -W1p -Gred
	# plot HI seatmout age 57  and great circle to paleopole
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T57, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -W1p -Gdarkgrey
	#plot rotation pole
	echo 292 75 | gmt plot -Sc0.3 -W1p -Glightblue
	# plot lines to HS
	gmt plot -W1p <<- EOF
	292 75
	210 28
	EOF
	gmt plot -W1p <<- EOF
	292 75
	170.561317836 39.6033202747
	EOF
	# plot GS from HS to S
	echo 210 28 >> tmp
	gmt plot tmp -W1p,--+o75k+vb8p+gblack
	# plot GS from h(0) to h(t)
	gmt plot -W1p,orange,--+o75k+vb8p+gorange <<- EOF
	210 28
	205	19.3178853822
	EOF
	#paleolat line
	gmt plot -W1p,lightred,-- -A <<- EOF
	180 28
	190 28
	200 28
	210 28
	220 28
	230 28
	235	28
	EOF
	#plot HS at time t
	echo 210 28 | gmt plot -Sc0.2 -W1p -Glightred
	#plot HS rotation poles
	echo 0 90 | gmt plot -Sc0.1 -Gblack
	echo 300 0 | gmt plot -Sc0.1 -Gblack
	# plot labels
	gmt text -F+a+f12p,Times-Italic+jLM -Dj0.2c <<- EOF
	205 19 0 @%7%h@%%@-i@-(0)
	211 30 0 @%7%h@%%@-i@-(t)
	157 37 -35 @%7%s@%%@-i@-(t)
	295 75 0 @%7%E@%%
	264 77.5 0 @~w@~
	100	84 0 @%7%X@%%@-i@-(t)
	286	12 0 @%7%Y@%%@-i@-(t)
	235 28 0 @%7%N@%%(t)
	EOF
gmt end show

rm -f tmp
