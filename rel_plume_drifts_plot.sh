#!/bin/bash

gmt begin rel_plume_drifts2 png
	# plot hotspots
	gmt plot -JX6i -R-2/12/-2/12 -Sc0.3 -Gblack <<- EOF
	1 5 
	8 8
	5 4
	7 1
EOF
	# plot inter-hotspot distances
	gmt plot -W0.5p <<- EOF
	1 5
	8 8
	5 4
	1 5
EOF
	gmt plot -W0.5p <<- EOF
	8 8 
	7 1
	5 4
EOF
	gmt plot -W0.5p <<- EOF
	7 1
	1 5 
EOF
	gmt plot -S=16p+e+h0.5 -Ggreen -W2p,green <<- EOF
	1 5
	3 6
EOF
	# plot vectors
	gmt plot -Sv0.15i+ea -Ggreen -W2p,green <<- EOF
	1 5 10 1i
	8 8 130 0.4i
	5 4 20 0.2i
	7 1 30 0.5i
EOF
	# plot red inter-dist change
	gmt plot -Sv0.15i -Gred -W1p,red <<- EOF
	1 5 23 1i
	8 8 203.5 1i
	1 5 -14 0.75i
	5 4 165.5 0.75i
	1 5 -33.5 0.5i
	7 1 146.5 0.5i
	8 8 55 0.1i
	5 4 235 0.1i
	8 8 260 0.15i
	7 1 80 0.15i
	5 4 -56 0.1i
	7 1 124 0.1i
EOF
	# plot text
	gmt text -F+a+j+f9p -DJ12p -N -C+tO -Glightyellow -W0.5p <<- EOF
	1 5 0 RM Hotspot @%6%1@%%
	8 8.3 0 LM Hotspot @%6%2@%%
	5 4.2 0 RT Hotspot @%6%3@%%
	7 0.5 0 CM Hotspot @%6%4@%%
EOF
	gmt text -F+a+j+f14p,Times <<- EOF
	3.5 5.5 0 CM @[\\mathbf{\\vec{r}}_1@[
	7.7 8.8 0 CM @[\\mathbf{\\vec{r}}_2@[
	5.6 4.2 0 CM @[\\mathbf{\\vec{r}}_3@[
	8.2 1.7 0 CM @[\\mathbf{\\vec{r}}_4@[
EOF
	gmt text -F+a+j+f14p,Times-Italic -Dj2p <<- EOF
	2 6 0 CM @[d_{12}@[
	7 8 0 CM @[d_{21}@[
	1.5 4.2 0 CM @[d_{14}@[
	6.4 1 0 CM @[d_{41}@[
EOF
gmt end show