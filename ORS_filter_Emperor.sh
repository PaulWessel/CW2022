rm -f fw_mh_Emperor.txt
gmt begin
gmt grdcut pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -R162/178/36/52 -GMasked_residual_emperor.grd
gmt math -T200/420/10 -o0 T = fw.txt
while read fw; do
	gmt grdfilter Masked_residual_emperor.grd -Fm${fw} -D2 -I10m -GEmperor_median.grd
	gmt grdfilter Emperor_median.grd -Fg${fw} -D2 -I10m -GEmperor_median_guassian.grd
	gmt grdsample Emperor_median_guassian.grd -I1m -Gtmp.grd
	gmt grdmath -R166/174/39/49 Masked_residual_emperor.grd tmp.grd SUB = Residual_minus_filters_emperor.grd
	stuff=`gmt grdvolume -C100 Residual_minus_filters_emperor.grd`
	echo "$fw ${stuff}" >> fw_mh_Emperor.txt
done < fw.txt
	gmt figure fw_mh_Emperor
	gmt plot fw_mh_Emperor.txt -i0,4 -JX6i -B -BWSne -W1p --MAP_FRAME_TYPE=plain
gmt end show