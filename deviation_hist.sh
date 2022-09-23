#!/bin/bash
chain=$1

gmt begin 
	gmt figure chain_ages/deviation_hist_${chain} jpg
	gmt histogram chain_ages/bend_ages_${chain}_sig.txt -i3+s1 -T0.5 -Glightblue -N0+p1p,red -B -BWSne+t"Distribution for ${chain} Age Deviations" -Bx+l"Age deviation from mean (Myr)" -By+l"Frequency"
gmt end show