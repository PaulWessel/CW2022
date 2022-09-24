gmt begin
	#HI -R160/207/17/53 2i/1.85i 2957 frames
    gmt grdmask HI_line.txt -GHI_envelope.grd -Rpacific_topo_1m_raw_subfloorHW_subsed.grd -NNaN/1/1
    gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed.grd HI_envelope.grd MUL = pacific_topo_HI_envelope.grd
	gmt grdtrack -Gpacific_topo_1m_raw_subfloorHW_subsed.grd -Gpacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -GMedian_HI.grd -GMedian_guassian_HI.grd -Gpacific_topo_HI_envelope.grd -Gpacific_topo_median_gaussian_420_5m_to1m.grd -E206/19/185/27,185/27/172/32.5,172/32.5/168/52 -C1000/1/2 > HI_track.txt
	#gmt grdtrack -Gpacific_topo_1m_raw_subfloorHW_subsed.grd -Gpacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -GMedian_LV.grd -GMedian_guassian_LV.grd -Gpacific_topo_Louisville_envelope.grd -E-137/-53/-168/-39,-168/-39/-175/-25 -C1000/1/2 > LV_track.txt
gmt end show

cat << END > main.sh
gmt begin
	gmt convert HI_track.txt -Q\$MOVIE_FRAME > track.txt
	gmt plot track.txt -JX8.5i/4.5i -R-500/500/-1000/8000 -B -BWSen -W1p,grey -i2,4 -X0.7i -Y0.3i -l"Masked Data"
    gmt plot track.txt -W1p,green -i2,5 -l"Unfiltered Data"
    gmt plot track.txt -W1p,red -i2,8 -l"Envelope"
    gmt plot track.txt -W0.25p, -i2,6 -l"Median Filter"
    gmt plot track.txt -W0.25p,blue -i2,7 -l"Median and Gaussian Filter"
    gmt plot track.txt -W0.25p,red -i2,9 -l"420km Filter"
    gmt inset begin -DjTL+w2i/1.85i+o0.2i -M0.4i/0/0.3i/0 -F+p1p
        gmt grdimage Pacific_topo_1m.grd -R160/207/17/53 -JM? -B -BWSne --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32
        gmt plot track.txt -W0.25p,white
        gmt plot -W0.25p,red <<- EOF
        206 19
        185 27
        172 32.5
        168 52
EOF
    gmt inset end
gmt end show
END
gmt movie main.sh -NHI_crosscut_4k -T2957 -Fmp4 -C4k -Lf -Vl -W/tmp/work -Z -M2000,pdf
rm -f main.sh