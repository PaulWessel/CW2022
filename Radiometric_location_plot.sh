gmt begin
	gmt figure radiometric_locations jpg
	gmt grdimage 500m_contour_finial_grid.grd -R145/260/-55/60 -JM6i -B
	gmt makecpt -T0/100 -Ccyclic
	gmt plot APM/data/Pacific_Ages_copy.txt -i0,1,2 -Sc0.1c -W0.5 -C
	gmt plot APM/data/Pacific_Paleolats.txt -i5,6 -Sa0.2c -Gyellow -W0.5
	gmt colorbar -B+l"Age (Ma)"
gmt end show