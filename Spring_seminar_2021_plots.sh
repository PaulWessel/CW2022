#!/bin/bash

gmt begin ages png
	gmt grdimage Pacific_topo_1m.grd -R162/206/18/55 -JM10i -Cgray -B -t30 --MAP_FRAME_TYPE=plain -I+d #-B+t"Age Samples for Hawaiian-Emperor"
	gmt makecpt -T0/100 -Ccyclic
	gmt plot chain_ages/HI_info.txt -i0,1,2 -Sc0.2 -W0.5 -C
	gmt colorbar -Bxaf -By+l"Age in millions of years" -DJBC+o-3c/-3c+w5c/0.5 --FONT_ANNOT_PRIMARY=10p -F+gwhite+p1p
gmt end show