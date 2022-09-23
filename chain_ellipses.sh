#!/bin/bash
chain=$1

gmt begin track_ellipses/ellipse_${chain}_chron_ages pdf,png
	gmt sample1d final_line_width_age_tables/${chain}_line_width_age.txt -Tchron_ages.txt -N11 > final_line_width_age_tables/chron_ages_${chain}.txt
	gmt grdimage chain_std/500m_contour_finial_grid_${chain}_NAN.grd -Cviridis -JM6i -B #-BWSne+t"Hawaiian-Emperor Chain" #--MAP_FRAME_TYPE=plain
	gmt plot final_smooth_weighted_line/weighted_line_filtered_${chain}_700.txt -W0.5p,red
	gmt math final_line_width_age_tables/chron_ages_${chain}.txt -C6 1.96 MUL 2 MUL = tmp
	gmt math tmp -C14 1.96 MUL 2 MUL = tmp
	gmt makecpt -T0/100 -Ccyclic
	gmt plot tmp -i0,1,11 -Sc0.15 -W0.5 -C
	gmt plot tmp -i0,1,3,14,6 -SE -W0.5p,white
	gmt colorbar -B+l"Age (Myr)"
gmt end show