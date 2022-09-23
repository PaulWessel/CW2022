#!/bin/bash

gmt begin HI_plot4 pdf
	# Select a sphere since everything we do is spherical, not ellipsoidal
	gmt set PROJ_ELLIPSOID Sphere
	# Plot a background centered on the hotspot on an equal-area projection (here 100x100 km)
	gmt coast -R-50/50/-50/50+uk -JA204.29155223/19.9378335628/10c -Bafg -Glightgray
	# Plot the hotspot localtion as a cross
	head -1 covariance_ellipse_real_data3.txt | gmt plot -Sx0.5c -W1p
	# Scale the v_phi, v_theta by 10 and add to hotspot coordinates, using v_phi/cos(lat) as longitude stretching
	awk '{print 204.29155223+$1*1.06376, 19.9378335628+$2}' HI_MC3.txt | gmt plot -Sp -Gred
	# Plot data in velo, letting 1 degree/Myr equal 1 spherical degree = 111.195 km
	head -1 covariance_ellipse_real_data3.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p
	# Plot a vector with label for scale showing the length of a 0.025 degree/Myr drift
	echo 204 20 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
	echo "204 19.875 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
	# Take the inversion results and scale by 10, etc to compare to point cloud in red
	echo "0.00352615755177818 -0.0373053215688004" | awk '{print 204.29155223+$1*1.06376, 19.9378335628+$2}' | gmt plot -Sp -Gblue
	# Notice that blue vector and blue point coincides exactly: Our formal errors is in excellent agreement with MC
	# Note that the 99.9% ellipse covers most of the 10000 red dots - eyeball agrees that 0.1% = 100 might be outside ellipse
gmt end show
