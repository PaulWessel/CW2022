#!/bin/bash
# used to find the correct cuts to different chains for filtering
chain=$1
gmt begin
	gmt figure Filter_grid_per_chain_figs/500m_contour_finial_grid_${chain} pdf,jpg
	gmt grdcut Filter_grids/500m_contour_finial_grid_${chain}.grd -R200/220/-25/-10 -Gchain_grid_cuts/cut_${chain}.grd
	gmt grdimage chain_grid_cuts/cut_${chain}.grd -JM6i -B
	gmt colorbar -B+l"Elevation (m)"
gmt end show
#HI -160/210/10/60
#LV -180/230/-60/-20
#CR -140/170/0/15
#CB -200/240/40/60
#FD -220/260/-45/-25
#KO -200/240/40/65
#MQ -210/230/-15/-3
#PC -210/240/-30/-15
#RU -160/220/-30/20
#SA -175/195/-20/-5

# cut out overlaping segment of rurutu and samoa 
gmt begin
	#gmt figure SA_RU_cut_new pdf,jpg
	#gmt grdimage 500m_contour_finial_grid.grd -R160/220/-30/20 -JM6i -B 
	#gmt plot APM/data/Envelopes/RU_envelope.txt -W0.25p,red -l"Rurutu"
	#gmt plot APM/data/Envelopes/SA_envelope.txt -W0.25p,green -l"Samoa"
	#gmt makecpt -T0/100 -Ccyclic
	#gmt plot samoa_ages.txt -i0,1,2 -Sc0.05c -W0.25 -C
	#gmt plot rurutu_ages.txt -i0,1,2 -Sc0.05c -W0.25,white -C
	#gmt colorbar -B+l"Age (Ma)"
gmt end show
