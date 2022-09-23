#!/bin/bash

gmt begin defense_figs/paleopole_map pdf
	gmt coast -Glightgrey -Bg -Rg -JG200/70/6i -Glightgrey
	#Plot chains
	gmt makecpt -T0/100 -Cturbo -I 
	gmt plot final_line_width_age_tables/HI_line_width_age.txt -i0,1,11 -Sc0.2 -C 
	gmt plot final_line_width_age_tables/CB_line_width_age.txt -i0,1,11 -Sc0.2 -C 
	#color bar
	gmt colorbar -Bxaf -By+l"Myr" -F+gwhite+p1p -DJMR+o-2c/0+w5c --FONT_ANNOT_PRIMARY=6p
	#Plot paleo-poles
	gmt plot APM/data/Pacific_Paleomagpoles.txt -i0,1,2,3,4+s111,5+s100 -SE -C -W1p,red

	#Paleomag poles GS
	#32
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T32, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -W0.5p -Gred -l"Magnetic anomaly skewness"
	gmt convert APM/data/Pacific_Paleomagpoles.txt -i0,1 -q0  >> tmp
	gmt plot tmp -W0.5p,red
	#44
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T44, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -W0.5p -Gred
	gmt convert APM/data/Pacific_Paleomagpoles.txt -i0,1 -q1  >> tmp
	gmt plot tmp -W0.5p.red
	#57
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T57, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -W0.5p -Gred
	gmt convert APM/data/Pacific_Paleomagpoles.txt -i0,1 -q2  >> tmp
	gmt plot tmp -W0.5p,red
	#65
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T65, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -W0.5p -Gred
	gmt convert APM/data/Pacific_Paleomagpoles.txt -i0,1 -q3  >> tmp
	gmt plot tmp -W0.5p,red
	#73
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T73, -N11 -o0,1 > tmp
	gmt plot tmp -Sc0.2 -W0.5p -Gred
	gmt convert APM/data/Pacific_Paleomagpoles.txt -i0,1 -q4  >> tmp
	gmt plot tmp -W0.5p,red

	#plot paleo-spin-axes
	gmt plot APM/data/Pacific_PaleoSpinAxes.txt -i0,1,2,3,4+s111,5+s100 -SE -C -W1p
	#plot point on chain and GS distance from pole HI
	
	#paleo-spin-axis GS
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T12, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow -l"Equatorial sediment"
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q0  >> tmp
	gmt plot tmp -W0.5p
	#16
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T16, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q1  >> tmp
	gmt plot tmp -W0.5p
	#20
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T20, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q2  >> tmp
	gmt plot tmp -W0.5p
	#24
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T24, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q3  >> tmp
	gmt plot tmp -W0.5p
	#28
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T28, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q4  >> tmp
	gmt plot tmp -W0.5p
	#32
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T32, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q5  >> tmp
	gmt plot tmp -W0.5p
	#37
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T37, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q6  >> tmp
	gmt plot tmp -W0.5p
	#43
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T43, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q7  >> tmp
	gmt plot tmp -W0.5p
	#48
	gmt sample1d final_line_width_age_tables/HI_line_width_age.txt -T48, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q8  >> tmp
	gmt plot tmp -W0.5p
	#plot point on chain and GS distance from pole CB
	gmt sample1d final_line_width_age_tables/CB_line_width_age.txt -T12, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q0  >> tmp
	gmt plot tmp -W0.5p
	#16
	gmt sample1d final_line_width_age_tables/CB_line_width_age.txt -T16, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q1  >> tmp
	gmt plot tmp -W0.5p
	#20
	gmt sample1d final_line_width_age_tables/CB_line_width_age.txt -T20, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q2  >> tmp
	gmt plot tmp -W0.5p
	#24
	gmt sample1d final_line_width_age_tables/CB_line_width_age.txt -T24, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q3  >> tmp
	gmt plot tmp -W0.5p
	#28
	gmt sample1d final_line_width_age_tables/CB_line_width_age.txt -T28, -N11 -o0,1 > tmp
	gmt plot tmp -St0.22 -Wfaint -Gyellow
	gmt convert APM/data/Pacific_PaleoSpinAxes.txt -i0,1 -q4  >> tmp
	gmt plot tmp -W0.5p
	# HI paleolats
	gmt plot P_lat/HI_Paleolats.txt -i5,6 -Sx0.3 -W1p -l"Magnetization"
	#Add chain labels
	gmt text -F+a+f8p+jCM -W0.25p -Gwhite <<- EOF
	235 47 0 Cobb
	217 19 0 Hawaiian-Emperor
	EOF
gmt end show

rm -f tmp