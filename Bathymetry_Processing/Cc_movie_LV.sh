gmt begin
    #gmt grdmask APM/data/Envelopes/LV_envelope.txt -GLV_envelope.grd -Rpacific_topo_1m_raw_subfloorHW_subsed.grd -NNaN/1/1
    #gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed.grd LV_envelope.grd MUL = pacific_topo_LV_envelope.grd
    #gmt grdtrack -Gpacific_topo_1m_raw_subfloorHW_subsed.grd -Gpacific_topo_LV_envelope.grd -GMedian_LV.grd -GMedian_guassian_LV.grd -Gpacific_topo_median_gaussian_420_5m_to1m.grd -E-137/-53/-168/-39,-168/-39/-175/-25 -C1000/1/2 > LV_track.txt
gmt end show
cat << END > main.sh
gmt begin
    gmt convert LV_track.txt -Q\$MOVIE_FRAME > track.txt
    gmt plot track.txt -JX8.5i/4.5i -R-500/500/-1000/8000 -B -BWSen -W1p,green -i2,4 -X0.7i -Y0.3i -l"Unfiltered Data"
    gmt plot track.txt -W1p,red -i2,5 -l"Envelope"
    gmt plot track.txt -W0.25p -i2,6 -l"Median Filter"
    gmt plot track.txt -W0.25p,blue -i2,7 -l"Median and Gaussian Filter"
    gmt plot track.txt -W0.25p,red -i2,8 -l"420 Filter"
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
gmt movie main.sh -NLV_crosscut_4k -T2258 -Fmp4 -C4k -M250,pdf -Lf -Vl -W/tmp/work -Z
rm -f main.sh