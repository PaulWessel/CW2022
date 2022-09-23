#!/bin/bash
#
#
# Data: data/HI_age_curve_comparison/*.txt for comparision of two regressions, projected_ages/HI_info.txt, binned_ages/HI_binned_ages.txt
# Purpose: Compare age progression curves when chain ages are updated
#--------------------------------------------------------------------------------

chain=$1

gmt begin age_curve_comparison/${chain} pdf
	# Plot regression confidence band
	gmt plot final_line_width_age_tables/${chain}_line_width_age.txt -i2,11,12,13 -JX-9i/6i -W0.5p -L+b -Glightblue@50
	# Plot spline model confidence band
	gmt plot final_line_width_age_tables_old_02-16-2022/${chain}_line_width_age.txt -i2,11,12,13 -W0.5p,6_2:0p -L+b -Glightgreen@50
	# Redo just the lines due to transparency
	gmt plot final_line_width_age_tables_old_02-16-2022/${chain}_line_width_age.txt -i2,11 -W0.5p,white
	gmt plot final_line_width_age_tables_old_02-16-2022/${chain}_line_width_age.txt -i2,11 -W0.5p,6_2:0p
	gmt plot final_line_width_age_tables/${chain}_line_width_age.txt -i2,11 -W0.5p
	# Overlay projected individual samples
	awk '{if ($4 == "O") print $1, $2}' chain_ages/${chain}_age_dist.txt | gmt plot -Sa10p -Gred -W0.25p
	awk '{if ($4 == "A") print $1, $2}' chain_ages/${chain}_age_dist.txt | gmt plot -St10p -Ggreen3 -W0.25p
	gmt plot chain_ages/${chain}_K_ages_removed.txt -Si15p -Gred
	awk '{if ($4 == "K") print $1, $2}' chain_ages/${chain}_age_dist.txt | gmt plot -Si10p -Gorange -W0.25p
	# Plot the binned ages
	gmt plot chain_ages/${chain}_age_dist_copy_final_50km.txt -Sc4p -Gblack -Ey+p0.5p+w0p
	gmt plot chain_ages/${chain}_age_dist_copy_final_50km_old.txt -Sc3p -Ggray -Ey+p0.5p+w0p
	# add axes labels and zero age distance lines
	gmt plot -W0.5p <<- EOF
	-1 0
	6000 0
	EOF
	gmt plot -W0.5p <<- EOF
	0 -1
	0 90
	EOF
	gmt basemap -Bxafg2000+u" km" -Byafg100+u" Ma"
	# Add main plot legend
	gmt legend -DjTR+o6p -F+p1p+gwhite+s <<-EOF
	H 14p,Times-Roman Symbol Legend
	D 5p 1p
	S 10p c 5p black - 24p New Binned Age (50 km bins)
	S 10p c 5p gray - 24p Old Binned Age (50 km bins)
	S 10p y 10p - 0.5p 24p Binned Age 95% Confidence
	D 0 1p
	H 14p,Times-Roman Model Legend
	D 5p 1p
	S 10p - 14p -      2p   24p New Regression Model
	S 10p r 10p lightblue@50      -   24p 95% Confidence
	S 10p - 14p -      1p,6_2:0p  24p Old Regression Model
	S 10p r 10p lightgreen@50      -   24p 95% Confidence
	EOF
gmt end show