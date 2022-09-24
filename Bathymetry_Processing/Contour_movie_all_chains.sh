cat << END > main.sh
gmt begin
	gmt grdmath Contour_map_420.grd DUP \$MOVIE_COL0 SUB 0 LT 1 NAN ADD = contour_movie.grd
	gmt grdimage contour_movie.grd -R145/260/-60/60 -JM3.2i -Cc.cpt -B -BWSne -X3.5i -Y1i --MAP_FRAME_TYPE=plain --MAP_ANNOT_OBLIQUE=32
	gmt plot APM/data/Envelopes/HI_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/LV_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/CR_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/PC_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/MQ_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/SA_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/KO_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/FD_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/CB1_envelope.txt -W0.25p,red
	gmt plot APM/data/Envelopes/CB2_envelope.txt -W0.25p,red
	gmt colorbar -B -Cc.cpt
gmt end show
END
gmt math -T0/1000/5 -o0 T = contours.txt
gmt makecpt -Cjet -T0/8000 > c.cpt
gmt movie main.sh -NContour_movie_all_chains_420 -Tcontours.txt -Fmp4 -C4k -Lc0 -Vl -M100,pdf -W/tmp/work -Z
rm -f main.sh