chain=$1
gmt begin
	gmt makecpt -T100/500
	gmt figure blockmean_guassian_circle1500k_track6000k_${chain} pdf
	gmt grdimage blockmean_guassian2000m_${chain}.grd -JM6i -B
	gmt colorbar -B
gmt end show