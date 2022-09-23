#!/bin/bash

#make cpt for HI
gmt makecpt -Cturbo -T0/6000 --COLOR_NAN=white > t.cpt
gmt makecpt -Cturbo -T-1/1700 --COLOR_NAN=white > t_smooth.cpt
#make cpt for LV
gmt makecpt -Cturbo -T-1/300 --COLOR_NAN=white > t_smooth_LV.cpt

# plot of extrapolated ages onto the given hotspot trail
#chain=$1
#HI:162/206/18/55 -T0/100
#LV 184/225/-52/-25 -T0/100
#RU 170/210/-25/10 -T0/100
#CB 205/235/45/55 -T0/35
#KO 205/230/50/60  -T0/35
#FD 225/252/-40/-30 -T0/25
#PC 212/235/-28/-18 -T0/15
#SA 178/192/-15/-10 -T0/15
#CR 145/170/0/15 -T0/15
#MQ 217/225/-13/-6 -T0\6
#SO 205/215/-20/-15 -T0/6

gmt begin supplemental/${chain}_ages png
#	gmt grdimage Pacific_topo_1m.grd -R205/215/-20/-15 -JM4i -Cgray -B -t30 --MAP_FRAME_TYPE=plain -I+d -B+t"${chain}"
#	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_${chain}_700.txt -W1p,red #-l"Inferred hotspot trail"
#	gmt plot chain_ages/${chain}_info.txt -Sc0.2 -Gwhite -W0.5 #-l"Age sample locations"
#	gmt makecpt -T0/6 -Cturbo -I
#	gmt plot chain_ages/${chain}_info.txt -i5,6,2 -Sc0.2 -W0.5 -C
#	echo 0 0 | gmt plot -Sc0.2 -W0.5 -Gdarkred #-l"Projected sample"
#	gmt colorbar -Bxaf -By+l"Myr" -DJBC+o-3c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
gmt end show

# for Lousiville dashed line
gmt begin supplemental/LV_ages2 png
#	gmt grdimage Pacific_topo_1m.grd -R184/225/-52/-25 -JM4i -Cgray -B -t30 --MAP_FRAME_TYPE=plain -I+d -B+t"LV"
#	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -q0:900 -W1p,red,dashed
#	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_LV_700.txt -q901:5898 -W1p,red -l"Inferred hotspot trail"
#	gmt plot chain_ages/LV_info.txt -Sc0.2 -Gwhite -W0.5 -l"Age sample locations"
#	gmt makecpt -T0/100 -Cturbo -I
#	gmt plot chain_ages/LV_info.txt -i5,6,2 -Sc0.2 -W0.5 -C
#	echo 0 0 | gmt plot -Sc0.2 -W0.5 -Gdarkred -l"Projected sample"
#	gmt colorbar -Bxaf -By+l"Myr" -DJBC+o-3c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
gmt end show

#for Rurutu dashed line
gmt begin supplemental/RU_ages2 png
	gmt grdimage Pacific_topo_1m.grd -R170/210/-25/10 -JM4i -Cgray -B -t30 --MAP_FRAME_TYPE=plain -I+d -B+t"RU"
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_RU_700.txt -q0:1200 -W1p,red #l"Inferred hotspot trail"
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_RU_700.txt -q1201:3300 -W1p,red,dashed 
	gmt plot final_smooth_weighted_line/weighted_line_filtered_resampled_RU_700.txt -q3301:5880 -W1p,red
	gmt plot chain_ages/RU_info.txt -Sc0.2 -Gwhite -W0.5 #-l"Age sample locations"
	gmt makecpt -T0/100 -Cturbo -I
	gmt plot chain_ages/RU_info.txt -i5,6,2 -Sc0.2 -W0.5 -C
	echo 0 0 | gmt plot -Sc0.2 -W0.5 -Gred #-l"Projected sample"
	gmt colorbar -Bxaf -By+l"Myr" -DJBC+o-3c/-1c+w3c/0.3 --FONT_ANNOT_PRIMARY=6p -F+gwhite+p1p
gmt end show
