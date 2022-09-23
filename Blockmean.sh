# surface on the 30 min blocks, original region, create new grid
gmt begin
	gmt figure blockmean_circle5000k_track_HI pdf
	gmt blockmean Filter_track_circles.txt -R130/270/-65/65 -I30m -Wi -Gblockmean_HI.grd
	gmt grdimage blockmean_HI.grd -JM6i -B
	gmt colorbar -B
gmt end show