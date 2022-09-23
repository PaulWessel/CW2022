gmt begin
    #gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed.grd SA_mask.grd MUL = SA_residual_envelope.grd
    #gmt grdtrack -Gpacific_topo_1m_raw_subfloorHW_subsed.grd -Gpacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -GSA_residual_envelope.grd -GMedian_SA.grd -GMedian_guassian_SA.grd -GMedian_guassian_420_SA.grd -E193/-15/179/-10.5 -C1000/1/2 > SA_track.txt
gmt end show
cat << END > main.sh
gmt begin
    gmt convert SA_track.txt -Q\$MOVIE_FRAME > track.txt
    gmt plot track.txt -JX8.5i/4.5i -R-500/500/-1000/8000 -B -BWSen -W1p,grey -i2,4 -X0.7i -Y0.3i -l"Maksed Data"
    gmt plot track.txt -W1p,green -i2,5 -l"Unfiltered Data"
    gmt plot track.txt -W1p,red -i2,6 -l"Envelope"
    gmt plot track.txt -W0.25p -i2,7 -l"Median Filter"
    gmt plot track.txt -W0.25p,blue -i2,8 -l"Median and Gaussian Filter"
    gmt plot track.txt -W0.25p,red -i2,9 -l"420 Filter"
    gmt inset begin -DjTL+w2i/1.8i+o0.2i -M0.4i/0/0.3i/0 -F+p1p
        gmt grdimage Pacific_topo_1m.grd -R175/195/-20/-5 -JM? -B -BWSne --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32
        gmt plot track.txt -W0.25p,white
        gmt plot -W0.25p,red <<- EOF
        193 -15
        179 -10.5
EOF
    gmt inset end
gmt end show
END
gmt movie main.sh -NSA_crosscut_4k -T800 -Fmp4 -C4k -M100,pdf -Lf -Vl -W/tmp/work -Z
rm -f main.sh