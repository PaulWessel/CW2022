#!/bin/bash

gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure HS_drifts/vec_ellipse_excl_LV_RU_CR png
	gmt subplot begin 4x2 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -AHI
		# Select a sphere since everything we do is spherical, not ellipsoidal
			# Plot a background centered on the hotspot on an equal-area projection (here 100x100 km)
			gmt coast -JA204.29155223/19.9378335628/? -Glightgray
			head -1 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			# Plot the hotspot localtion as a cross
			head -1 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			# Plot a vector with label for scale showing the length of a 0.025 degree/Myr drift
			echo 204 20 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "204 19.875 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -ACB
			gmt coast -JA229.855265181/45.8996134904/? -Glightgray
			head -2 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -2 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 229.5 46 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "229.5 45.8 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 2 -AKO
			gmt coast -JA225.351323815/52.9994233827/? -Glightgray
			head -3 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -3 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 225 53 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "225 52.875 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0	
		gmt subplot set 3 -AFD
			gmt coast -JA249.329564399/-38.0573420754/? -Glightgray
			head -4 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -4 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 249 -38 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "249 -38.125 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 4 -APC
			gmt coast -JA230.444080675/-25.2801653485/? -Glightgray
			head -5 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -5 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 230 -25.25 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "230 -25.375 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 5 -ASA
			gmt coast -JA190.615608649/-14.3793841095/? -Glightgray
			head -6 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -6 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 190.25 -14.25 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "190.25 -14.37 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 6 -AMQ
			gmt coast -JA222.2382673/-10.8576146847/? -Glightgray
			head -7 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -7 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 222 -11 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "222 -11.125 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 7 -ASO
			gmt coast -JA211.588538184/-18.0821740556/? -Glightgray
			head -8 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p -Ered
			head -8 HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_MQ_SO.txt | gmt plot -Sx0.2c -W1p
			echo 211.25 -18.25 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
			echo "211.25 -18.375 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
	gmt subplot end
gmt end show