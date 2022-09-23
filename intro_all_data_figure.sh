#!/bin/bash

gmt begin thesis_figs/data_map png
	gmt grdimage @earth_relief_06m -Rg -I+d -JG200/28/6i -Cgray -t40 #Pacific_topo_1m.grd
	gmt coast -Gwhite -Bg
	#plate boundaries 
	gmt plot Pacific_plate.txt -W1p
	# cpt
	gmt makecpt -T0/100 -Cturbo -I
	# age data
	gmt plot APM/data/Pacific_Ages_copy.txt  -Sc0.1 -C -W0
	# paleo-lat
		#HI
	gmt plot P_lat/HI_Paleolats.txt -i5,6,0 -Sx0.4 -C -W1+cl
	gmt plot P_lat/HI_Paleolats.txt -i5,6 -Sx0.4 -W0.25
		#LV
	gmt plot P_lat/LV_Paleolats.txt -i5,6,0 -Sx0.4 -C -W1+cl
	gmt plot P_lat/LV_Paleolats.txt -i5,6 -Sx0.4 -W0.25
	#Plot paleo-poles ans paleo-spin-axes
	gmt plot APM/data/Pacific_Paleomagpoles.txt -i0,1,2,3,4+s111,5+s100 -SE -C -W0.25p,red
	gmt plot APM/data/Pacific_PaleoSpinAxes.txt -i0,1,2,3,4+s111,5+s100 -SE -C -W0.25p
	#add colorbar
	gmt colorbar -Bxaf -By+l"Myr" -F+gwhite+p1p -DJMR+o-2c/0+w5c --FONT_ANNOT_PRIMARY=6p
	#Add chain labels
	gmt text -F+a+f8p+jCM -W0.25p -Gwhite <<- EOF
	227 -52 0 LV
	208 19 0 HI
	213	-24 0 RU
	235 47 0 CB
	230 55	0 KO
	252 -38 0 FD
	235 -26 0 PC
	194 -14 0 SA
	167 6 0 CR
	225 -13 0 MQ
	215 -18 0 SO
	EOF
gmt end show