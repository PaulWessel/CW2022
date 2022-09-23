#!/bin/bash


#gmt histogram width.txt -i12+s0.5 -T1 -B -Gred -N1+p2p  -pdf map histogram [INFORMATION]: Locations: L2, L1, LMS; Scales: L2, L1, LMS	13.0047559689	12.5090735142	11.5103509166	6.71260177948	5.93498076064	5.19726297273
#gmt math -Sf width.txt -i12+s0.5 MEDIAN =
#gmt math -Sf width.txt -i12+s0.5 MAD =
#gmt math -Q 0.99 ZCRIT =

gmt begin
	#gmt math 1sigma/width_1sigma_vs_dist_${chain}.txt -Sf -i12 DUP LMSSCL 0.99 ZCRIT MUL EXCH MODE ADD = 1sigma/99_right_${chain}.txt
	gmt math chain_ages/age_deviations.txt -Sf DUP LMSSCL 0.95 ZCRIT MUL EXCH MODE ADD = chain_ages/95_right_zcrit.txt
	gmt math chain_ages/age_deviations.txt -Sf STD = chain_ages/1_std_all_chains.txt
gmt end

gmt begin 
	gmt figure chain_ages/histogram_age_deviations jpg
	gmt histogram chain_ages/age_deviations.txt -T0.25 -Glightblue -N0+p1p,red -N1+p1p,green -N2+p1p,blue -B -BWSne+t"Distribution of Age Deviations" -Bx+l"Sigma (Myr)" -By+l"Frequency" -V
	gmt plot -W0.5,red,- <<- EOF
    1.5 0
    1.5 100
EOF
	gmt plot -W0.5,black,- <<- EOF
    1.7 0
    1.7 100
EOF
gmt end show
