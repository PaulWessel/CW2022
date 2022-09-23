#!/bin/bash
ellipse=$"wheat"
vec1=$"10p"
vec2=$"18p"
ALL=$"blue"
confidence=$"0.95"
# all 9 solutions
gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure defense_figs/results_all png
	gmt subplot begin 3x3 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -AHawaiian
			gmt coast -JA204.900544518/19.4141732384/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Sx0.2c -W1p
			echo 204.5 19.5 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A10p+e -Gblue -W1p -L1p
			echo "204.5 19.375 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -ACobb
			gmt coast -JA229.855265181/45.8996134904/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q1 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q1 -Sx0.2c -W1p
		gmt subplot set 2 -AKodiak
			gmt coast -JA225.351323815/52.9994233827/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q2 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q2 -Sx0.2c -W1p
		gmt subplot set 3 -ACaroline
			gmt coast -JA163.741761009/4.97826829887/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q6 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q6 -Sx0.2c -W1p
		gmt subplot set 4 -ASamoa
			gmt coast -JA190.615608649/-14.3793841095/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Sx0.2c -W1p
		gmt subplot set 5 -AMarquesas
			gmt coast -JA222.2382673/-10.8576146847/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q7 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q7 -Sx0.2c -W1p
		gmt subplot set 6 -ASociety
			gmt coast -JA211.588538184/-18.0821740556/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q8 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q8 -Sx0.2c -W1p
		gmt subplot set 7 -APitcairn
			gmt coast -JA230.444080675/-25.2801653485/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q4 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q4 -Sx0.2c -W1p
		gmt subplot set 8 -AFoundation
			gmt coast -JA249.329564399/-38.0573420754/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q3 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q3 -Sx0.2c -W1p
	gmt subplot end
gmt end show

# plot consistant results for Doubrovine
gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure defense_figs/results_D1 png
	gmt subplot begin 2x2 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -AHawaiian
			gmt coast -JA204.900544518/19.4141732384/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
			echo 204.5 19.5 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A10p+e -Gblue -W1p -L1p
			echo "204.5 19.375 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -ASamoa
			gmt coast -JA190.615608649/-14.3793841095/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q5 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
		gmt subplot set 2 -AMarquesas
			gmt coast -JA222.2382673/-10.8576146847/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q7 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q7 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q7 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
		gmt subplot set 3 -ASociety
			gmt coast -JA211.588538184/-18.0821740556/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q8 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q8 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q8 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
	gmt subplot end	
gmt end show


# plot inconsistant results for Doubrovine
gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure defense_figs/results_D2 png
	gmt subplot begin 2x2 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -AKodiak
			gmt coast -JA225.351323815/52.9994233827/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q2 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q2 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q2 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
			echo 225 53 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A10p+e -Gblue -W1p -L1p
			echo "225 52.85 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -APitcairn
			gmt coast -JA230.444080675/-25.2801653485/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q4 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q4 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q4 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
		gmt subplot set 2 -ACaroline
			gmt coast -JA163.741761009/4.97826829887/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q6 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q6 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q6 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
	gmt subplot end	
gmt end show


# plot inconsistant results for Tetley

gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure defense_figs/results_T png
	gmt subplot begin 2x2 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -AHawaiian
			gmt coast -JA204.900544518/19.4141732384/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
			gmt velo HS_drifts/Tutley_vector_HI.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
			echo 204.5 19.5 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A10p+e -Gblue -W1p -L1p
			echo "204.5 19.375 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -ASamoa
			gmt coast -JA190.615608649/-14.3793841095/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q5 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
			gmt velo HS_drifts/Tutley_vector_SA.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
		gmt subplot set 2 -ACobb
			gmt coast -JA229.855265181/45.8996134904/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q1 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q1 -Sx0.2c -W1p
			gmt velo HS_drifts/Tutley_vector_CB.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
		gmt subplot set 3 -AFoundation
			gmt coast -JA249.329564399/-38.0573420754/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q3 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q3 -Sx0.2c -W1p
			gmt velo HS_drifts/Tutley_vector_FD.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
	gmt subplot end	
gmt end show

# plot Doubrovine and Tetley

gmt begin
	gmt set PROJ_ELLIPSOID Sphere MAP_ANNOT_OBLIQUE lat_parallel,lon_horizontal
	gmt figure defense_figs/results_T_and_D png
	gmt subplot begin 3x2 -Fs10c -A -Bafg -R-50/50/-50/50+uk
		gmt subplot set 0 -AHawaiian
			gmt coast -JA204.900544518/19.4141732384/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W0.25 -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q0 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
			gmt velo HS_drifts/Tutley_vector_HI.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
			echo 204.5 19.5 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A10p+e -Gblue -W1p -L1p
			echo "204.5 19.375 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
		gmt subplot set 1 -ASamoa
			gmt coast -JA190.615608649/-14.3793841095/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q5 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q5 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
			gmt velo HS_drifts/Tutley_vector_SA.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
		gmt subplot set 2 -ACobb
			gmt coast -JA229.855265181/45.8996134904/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q1 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q1 -Sx0.2c -W1p
			gmt velo HS_drifts/Tutley_vector_CB.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
		gmt subplot set 3 -AFoundation
			gmt coast -JA249.329564399/-38.0573420754/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q3 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q3 -Sx0.2c -W1p
			gmt velo HS_drifts/Tutley_vector_FD.txt -q0 -Se11.1195/0.99 -A${vec2}+e -Gorange -W1p,orange
		gmt subplot set 4 -ASociety
			gmt coast -JA211.588538184/-18.0821740556/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q8 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q8 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q8 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
		gmt subplot set 5 -AMarquesas
			gmt coast -JA222.2382673/-10.8576146847/? -Glightgray
			gmt velo HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q7 -Se11.1195/${confidence} -A${vec2}+e  -G${ALL} -W1p -E${ellipse}
			gmt plot HS_drifts/HS_drifts_HI_CB_KO_FD_PC_SA_CR_MQ_SO.txt -q7 -Sx0.2c -W1p
			gmt velo HS_drifts/Doubrovine.txt -q7 -Se11.1195/0.99 -A${vec2}+e -Gred -W1p,red
	gmt subplot end	
gmt end show