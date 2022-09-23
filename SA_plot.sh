#!/bin/bash
# Change this path depending on who you are and where you are...


gmt begin SA_plot2 pdf
	# Select a sphere since everything we do is spherical, not ellipsoidal
	gmt set PROJ_ELLIPSOID Sphere
	# Plot a background centered on the hotspot on an equal-area projection (here 100x100 km)
	gmt coast -R-50/50/-50/50+uk -JA190.615608649/-14.3793841095/10c -Bafg -Glightgray
	# Plot the hotspot localtion as a cross
	head -3 covariance_ellipse_real_data2.txt | gmt plot -Sx0.5c -W1p
	# Scale the v_phi, v_theta by 10 and add to hotspot coordinates, using v_phi/cos(lat) as longitude stretching
	awk '{print 190.615608649+$1*1.032340566, -14.3793841095+$2}' SA_MC2.txt | gmt plot -Sp -Gred
	# Plot data in velo, letting 1 degree/Myr equal 1 spherical degree = 111.195 km
	head -3 covariance_ellipse_real_data2.txt | gmt velo -Se11.1195/0.99 -A7p+e -Gblue -W0.25p
	# Plot a vector with label for scale showing the length of a 0.025 degree/Myr drift
	echo 190.4 -14.4 0 -0.25	0.001	0.0005	0 | gmt velo -Se11.1195/0 -A7p+e -Gblue -W1p -L0.25p
	echo "190.3 -14.38 0.25@./Myr" | gmt text -F+jML+f9p -D5p/0
	# Take the inversion results and scale by 10, etc to compare to point cloud in red
	echo "-0.0523798747841565 0.151742045235409" | awk '{print 190.615608649+$1*1.032340566, -14.3793841095+$2}' | gmt plot -Sp -Gblue
	# Notice that blue vector and blue point coincides exactly: Our formal errors is in excellent agreement with MC
	# Note that the 99.9% ellipse covers most of the 10000 red dots - eyeball agrees that 0.1% = 100 might be outside ellipse
gmt end show