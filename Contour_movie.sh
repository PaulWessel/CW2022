#!/bin/bash
chain=$1
cat << END > main.sh
gmt begin
	gmt grdcut Contour_map_Varying.grd -R-179/-135/-55/-24 -G${chain}_cut.grd
	gmt grdmask APM/data/Envelopes/${chain}_envelope.txt -R${chain}_cut.grd -G${chain}_cut_mask.grd -NNaN/1/1
	gmt grdmath ${chain}_cut.grd ${chain}_cut_mask.grd MUL DUP \$MOVIE_COL0 SUB 0 LT 1 NAN ADD = ${chain}_contour_movie.grd
	gmt grdimage ${chain}_contour_movie.grd -JM4.5i -B -BWSne -X2.5i -Y1i -C${chain}.cpt --MAP_FRAME_TYPE=plain --MAP_ANNOT_OBLIQUE=32
	gmt plot APM/data/Envelopes/${chain}_envelope.txt -W0.25p,red
	gmt colorbar -B -C${chain}.cpt
gmt end show
END
gmt math -T0/1000/5 -o0 T = contours.txt
gmt makecpt -Cjet -T0/8000 > ${chain}.cpt
gmt movie main.sh -N${chain}_Varying_movie -Tcontours.txt -Fmp4 -C4k -Lc0 -Vl -M100,pdf -W/tmp/work -Z
rm -f main.sh

#HI: -JM7i -X1.5i -Y1i -R145/225/17/55
#LV: -JM4.5i -X2.5i -Y1i -R-179/-135/-55/-24