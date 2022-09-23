#!/bin/bash

chain=$1
Q=$2
# making a cross-section
gmt begin Data_figs/cross_section_${chain}_Q${Q}_2 png
	# take cross track profiles
	gmt grdtrack start_line/${chain}_edited.txt -G500m_contour_finial_grid.grd -GMedian_line_figs/smooth_${chain}_700_ne.grd -C400k/2/20 > ${chain}_track.txt
	# pick cross profile number
	gmt convert ${chain}_track.txt -Q${Q} > track.txt
	gmt convert chain_lines/center_700_${chain}.txt -qi${Q} -o3 > mline
	# get distance along cross profile of weighted line
	#gmt convert chain_lines/weighted_line_700_LV.txt -qi125 > tmp1.txt
	#gmt sample1d track.txt -T0, -N2 -o0,1 > tmp2.txt
	#gmt convert tmp1.txt tmp2.txt -A > tmp3.txt
	#gmt mapproject tmp3.txt -G+v+uk -o4 > wline
	# plotting
		# plot residual and smooth grids 
	gmt plot track.txt -JX8.5i/4.5i -R-200/200/0/5000 -B -BWSen -i2,4+o-500 -W2p -Bx+l"Distance (km)" -By+l"Height (m)"
	gmt plot track.txt -i2,5 -W2p,blue
		# plot the center points 
	#gmt plot chain_lines/center_700_LV.txt -i3,5 -qi14 -Sc0.1 -Gblue
	gmt plot -W1p,grey -l"Start line" <<- EOF
	0 0
	0 4500
EOF
	gmt plot -W1p,red -l"Medial line" <<- EOF 
	20 0
	20 4500
EOF
	    gmt inset begin -DjTL+w3i/2.82i+o0.2i -M0.4i/0/0.3i/0 -F+p1p
        gmt grdimage 500m_contour_finial_grid.grd -R168/178/30/38 -JM? -B -BWSne --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32 --COLOR_NAN=white
        gmt plot track.txt -W1p,yellow
        gmt plot start_line/${chain}_edited.txt -W2p,black
        gmt text -F+a+f10p+jCM -Gwhite <<- EOF
		174 36 40 Koko Seamount
		171.5 32.5 -60 HEB
		EOF
    	gmt inset end
gmt end show

rm -f tmp1.txt
rm -f tmp2.txt
rm -f tmp3.txt

#LV: -DjTL+w2i/1.8i+o0.2i -M0.4i/0/0.3i/0 -F+p1p -R-179/-135/-55/-24
#HI: -DjTL+w2i/1.85i+o0.2i -M0.4i/0/0.3i/0 -F+p1p -R160/207/17/53