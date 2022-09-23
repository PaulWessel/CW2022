
gmt begin GE_RU ps
	gmt grdimage Filter_grids/500m_contour_finial_grid_RU.grd -R160/220/-30/20 -Jx0.1
gmt end
gmt psconvert GE_RU.ps -TG -W+k -A