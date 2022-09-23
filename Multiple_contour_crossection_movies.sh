cat << END > main.sh
gmt begin
	gmt grdmask APM/data/Envelopes/LV_envelope.txt -RLV_cut.grd -GLV_cut_mask.grd -NNaN/1/1
	gmt grdmath LV_cut.grd LV_cut_mask.grd MUL DUP \$MOVIE_COL0 SUB 0 LT 1 NAN ADD = LV_contour_movie.grd
	gmt grdimage LV_contour_movie.grd -JM4.5i -B -BWSne -X2.5i -Y1i -CLV.cpt --MAP_FRAME_TYPE=plain --MAP_ANNOT_OBLIQUE=32
	gmt plot APM/data/Envelopes/LV_envelope.txt -W0.25p,red
	gmt colorbar -B -CLV.cpt
gmt end show
END
gmt math -T0/1000/5 -o0 T = contours.txt
gmt makecpt -Cjet -T0/8000 > LV.cpt
gmt movie main.sh -NLV_contour_movie_4k -Tcontours.txt -Fnone -C4k -Lc0 -Vl -W/tmp/work -Z -M500,pdf
rm -f main.sh

cat << END > main.sh
gmt begin
	gmt grdmask APM/data/Envelopes/HI_envelope.txt -RHI_cut.grd -GHI_cut_mask.grd -NNaN/1/1
	gmt grdmath HI_cut.grd HI_cut_mask.grd MUL DUP \$MOVIE_COL0 SUB 0 LT 1 NAN ADD = HI_contour_movie.grd
	gmt grdimage HI_contour_movie.grd -JM7i -B -BWSne -X1.5i -Y1i -CHI.cpt --MAP_FRAME_TYPE=plain --MAP_ANNOT_OBLIQUE=32
	gmt plot APM/data/Envelopes/HI_envelope.txt -W0.25p,red
	gmt colorbar -B -CHI.cpt
gmt end show
END
gmt math -T0/1000/5 -o0 T = contours.txt
gmt makecpt -Cjet -T0/8000 > HI.cpt
gmt movie main.sh -NHI_contour_movie_4k -Tcontours.txt -Fnone -C4k -Lc0 -Vl -W/tmp/work -Z -M500,pdf
rm -f main.sh

cat << END > main.sh
gmt begin
    gmt convert Louisville_track_1_2.txt -Q\$MOVIE_FRAME > track.txt
    gmt plot track.txt -JX8.5i/4.5i -R-500/500/-1000/8000 -B -BWSen -W1p,green -i2,4 -X0.7i -Y0.3i -l"Unfiltered Data"
    gmt plot track.txt -W1p,red -i2,5 -l"Envelope"
    gmt plot track.txt -W0.25p,blue -i2,6 -l"Median Filter"
    gmt plot track.txt -W0.25p -i2,7 -l"Median and Gaussian Filter"
    gmt inset begin -DjTL+w2i/1.8i+o0.2i -M0.4i/0/0.3i/0 -F+p1p
        gmt grdimage Pacific_topo_1m.grd -R-179/-135/-55/-24 -JM? -B -BWSne --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32
        gmt plot track.txt -W0.25p,white
        gmt plot -W0.25p,red <<- EOF
        -137 -53
        -168 -39
        -175 -25
EOF
    gmt inset end
gmt end show
END
gmt movie main.sh -NLV_crosscut_4k -T2258 -Fmp4 -C4k -Lf -Vl -W/tmp/work -Z -M500,pdf
rm -f main.sh

cat << END > main.sh
gmt begin
	gmt convert Emperor_track_1_2.txt -Q\$MOVIE_FRAME > track.txt
	gmt plot track.txt -JX8.5i/4.5i -R-500/500/-1000/8000 -B -BWSen -W1p,grey -i2,4 -X0.7i -Y0.3i -l"Masked Data"
    gmt plot track.txt -W1p,green -i2,5 -l"Unfiltered Data"
    gmt plot track.txt -W1p,red -i2,8 -l"Envelope"
    gmt plot track.txt -W0.25p,blue -i2,6 -l"Median Filter"
    gmt plot track.txt -W0.25p -i2,7 -l"Median and Gaussian Filter"
    gmt inset begin -DjTL+w2i/2.64i+o0.2i -M0.4i/0/0.3i/0 -F+p1p
        gmt grdimage Pacific_topo_1m.grd -R160/183/28/53 -JM? -B -BWSne --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32
        gmt plot track.txt -W0.25p,white
        gmt plot -W0.25p,red <<- EOF
        173 31
        167 52
EOF
    gmt inset end
gmt end show
END
gmt movie main.sh -NEmperor_crosscut_4k -T1194 -Fmp4 -C4k -Lf -Vl -W/tmp/work -Z -M500,pdf
rm -f main.sh