#!/bin/bash
gmt begin
	#gmt math -T0/6/1 -o1 0 60 RAND 30 SUB = x
	#sleep 1
	#gmt math -T0/6/1 -o1 0 60 RAND 30 SUB = y
	#paste x y > spots.txt
	gmt figure defense_figs/no-net-translation pdf
	gmt basemap -B+glightblue -Rg -JG-10/25/15c -Bafg
	echo "-6	6" | gmt plot -SE8000- -W1p -Glightgrey
	echo "-90	70	-1.82374666487	6.58511657987" | gmt plot -Sv0.1+s -W2p,-
	echo "-1.82374666487	6.58511657987	80	4000" | gmt plot -S=30p+e+jc+p2p -W4p -Gyellow
	gmt plot spots.txt -SE300- -Gred -W0.5p
	echo "-1.82374666487	6.58511657987" | gmt plot -SE400- -Gblack
	echo "-90	70" | gmt plot -SE600- -Gyellow -Wthin
	echo "-90	70" | gmt plot -SE300- -Gblack
	gmt figure defense_figs/no-net-rotation pdf
	gmt basemap -B+glightblue -Rg -JG-10/25/15c -Bafg
	echo "-6	6" | gmt plot -SE8000- -W1p -Glightgrey
	echo "-1.82374666487	6.58511657987 1.5 180 290" | gmt plot -Sm30p+e+p2p -W4p -Gyellow
	gmt plot spots.txt -SE300- -Gred -W0.5p
	echo "-1.82374666487	6.58511657987" | gmt plot -SE600- -Gyellow -Wthin
	echo "-1.82374666487	6.58511657987" | gmt plot -SE300- -Gblack
gmt end show
