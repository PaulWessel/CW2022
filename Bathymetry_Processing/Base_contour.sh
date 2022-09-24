chain=$1
# creating the contour text files
gmt begin
	#gmt grdvolume Filter_grids/Varying_filter_envelope_${chain}.grd -C0/1000/5 > Contours/{chain}_varying_filter_contour.txt
	#gmt grdvolume Filter_grids/420_filter_envelope_${chain}.grd -C0/1000/5 > Contours/{chain}_420_filter_contour.txt
	#gmt grdvolume Contour_map_varying.grd -C0/1000/5 > Contours/ALLchains_varying_filter_contour.txt
gmt end

# plotting mean hight
# HI -R0/1000/1580/1720 
# LV -R0/1000/780/1200
# CR -R0/1000/1060/1420
# MQ -R0/1000/900/1250
# SA -R0/1000/1100/1700
# KO -R0/1000/400/950
# FD default 
# CB -R0/1000/300/700
# RU default
gmt begin
	gmt figure Contours/mean_hight_contour_${chain} jpg
	#gmt plot Contours/{chain}_varying_filter_contour.txt -R0/1000/300/700 -JX6i -B -BWSne -i0,3 -W1p,blue -l"Varying Filter" --MAP_FRAME_TYPE=plain
	#gmt plot Contours/{chain}_420_filter_contour.txt -JX6i -B -BWSne -i0,3 -W1p,red -l"420km Filter" --MAP_FRAME_TYPE=plain
	gmt plot Contours/ALLchains_varying_filter_contour.txt -JX6i -B -BWSne -i0,3 -W1p,blue --MAP_FRAME_TYPE=plain
gmt end show

#plotting area
gmt begin
	gmt figure Contours/area_contour_${chain} jpg
	#gmt plot Contours/{chain}_varying_filter_contour.txt -JX6i -B -BWSne -i0,1 -W1p,blue -l"Varying Filter" --MAP_FRAME_TYPE=plain
	#gmt plot Contours/{chain}_420_filter_contour.txt -JX6i -B -BWSne -i0,1 -W1p,red -l"420km Filter" --MAP_FRAME_TYPE=plain
	#gmt plot Contours/ALLchains_varying_filter_contour.txt -JX6i -B -BWSne -i0,1 -W1p,blue --MAP_FRAME_TYPE=plain
gmt end show