#!/bin/bash
# SHortcut to my directory with older files
D=/Volumes/MacNutRAID/UH/RESEARCH/CVSPROJECTS/Pacific

gmt begin method pdf
	gmt coast -Rg -JG235/17/7i -Glightgray -Bg
	# Draw the HI trail with a fat lightgreen pen
	gmt sample1d $D/traildata_HI.txt -T57, -N3 -o0,1 > tmp
	# Make and plot a great circle from s(57) to h(57).  SHould be small circle but...
	echo 208 24 >> tmp
	gmt plot $D/traildata_HI.txt -W3p,lightgreen
	gmt plot tmp -W1p+o75k+vb8p+gblack
	# Plot orange lines indicating the rotation start stop
	echo 208 24 > tmp
	echo 292 75 >> tmp
	gmt sample1d $D/traildata_HI.txt -T57, -N3 -o0,1 >> tmp
	gmt plot tmp -W0.25p,orange
	# Plot the HI hotspot at t = 0
	head -2 $D/traildata_HI.txt | gmt plot -SE150 -Gred -Wfaint
	# Plot seamount s(57)
	gmt sample1d $D/traildata_HI.txt -T57, -N3 | gmt plot -SE150 -Ggreen -Wfaint
	# Plot the HI hotspot at t = 57 Ma
	echo 208 24 | gmt plot -SE150 -Glightred -Wfaint
	# Plot hotspot drift for Hawaii since 57 Ma
	gmt plot -W0.5p,- <<- EOF
	208 24
	204.850604755	19.4795609994
	EOF
	# Draw the LV trail with a fat lightblue pen
	gmt sample1d $D/traildata_LV.txt -T57, -N3 -o0,1 > tmp
	# Make and plot a great circle from s(57) to h(57).  SHould be small circle but...
	echo 222 -45 >> tmp
	gmt plot $D/traildata_LV.txt -W3p,lightblue
	gmt plot tmp -W1p+o75k+vb8p+gblack
	# Plot orange lines indicating the rotation start stop
	echo 222 -45 > tmp
	echo 292 75 >> tmp
	gmt sample1d $D/traildata_LV.txt -T57, -N3 -o0,1 >> tmp
	gmt plot tmp -W0.25p,orange
	# Plot the LV hotspot
	head -2 $D/traildata_LV.txt | gmt plot -SE150 -Gred -Wfaint
	# Plot seamount s(57)
	gmt sample1d $D/traildata_LV.txt -T57, -N3 | gmt plot -SE150 -Gblue -Wfaint
	# Plot hotspot drift for Louisville since 57 Ma
	gmt plot -W0.5p,- <<- EOF
	222 -45
	221.594645142	-50.6441446981
	EOF
	# Plot the LV hotspot at t = 57 Ma
	echo 222 -45 | gmt plot -SE150 -Glightblue -Wfaint
	# Plot the interhotspot distance at 57
	gmt sample1d $D/traildata_HI.txt -T57, -N3 -o0,1 > tmp
	gmt sample1d $D/traildata_LV.txt -T57, -N3 -o0,1 >> tmp
	gmt plot tmp -W0.75p,blue
	# Plot a (not accurate) total rotation pole for the Pacific for 57 Ma
	echo 292 75 | gmt plot -SE350 -Glightorange -Wfaint
	# Gordon's 57 Ma paleomag pole
	echo 4.8 78.2 93 725 465| gmt plot -SE -Gpink -Wfaint
	echo 4.8 78.2 5| gmt plot -SE50 -Gblack
	# Draw paleocolatitude curves for the 57 Ma points
	gmt sample1d $D/traildata_HI.txt -T57, -N3 -o0,1 > tmp
	echo 4.8 78.2 >> tmp
	gmt sample1d $D/traildata_LV.txt -T57, -N3 -o0,1 >> tmp
	gmt plot tmp -W0.5p,red
	# Various labels
	gmt text -F+a+f12p+jCM <<- EOF
	205 -57 -17 Chain 1
	185 23 -35 Chain 2
	350 74.5 0 @%7%P@%%
	295 72 0 @%7%R@%%
	EOF
	gmt text -F+a+f9p,Times-Italic+jLM -Dj0.2c <<- EOF
	205 19 0 @%7%h@%%@-2@-(0)
	208 24 0 @%7%h@%%@-2@-(t)
	222 -50.6 0 @%7%h@%%@-1@-(0)
	222 -45 0 @%7%h@%%@-1@-(t)
	188.642028259	-32 0 @%7%s@%%@-1@-(t)
	170.506300271	41.2289830718 0 @%7%s@%%@-2@-(t)
	270 74 0 @~w@~
	EOF
gmt end show
