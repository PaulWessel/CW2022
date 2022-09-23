#!/bin/bash
gmt begin
	#making grd track of seafloor age for different chains
	#gmt grdtrack -GAge_curve_1m.grd -E206/19/185/27,185/27/172/32.5,172/32.5/168/52+d > HI_age_track.txt
	#gmt grdtrack -GAge_curve_1m.grd -E-137/-53/-168/-39,-168/-39/-175/-25+d > LV_age_track.txt
	#gmt grdtrack -GAge_curve_1m.grd -E-110/-37.5/-128/-32+d > FD_age_track.txt
	#gmt grdtrack -GAge_curve_1m.grd -E-130/45.5/-152/54+d > CB_age_track.txt
	#gmt grdtrack -GAge_curve_1m.grd -E-129/-25.5/-145/-19.5+d > PC_age_track.txt
	#Testing line for chain
	gmt grdimage Pacific_topo_1m.grd -R175/195/-20/-5 -JM6i -B --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32
	gmt plot APM/data/Envelopes/SA_envelope.txt -W01p,red
	gmt plot -W1p,red <<- EOF
	193 -15
	179 -10.5
EOF
gmt end show