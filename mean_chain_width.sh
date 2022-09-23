#!/bin/bash
# Used to find a chain width per chain using smoothed seamounts and max height to find the boundaries
fw=$1
chain=$2
MATLAB=/Applications/MATLAB_R2019a.app
gmt begin 
	# set all zeros to NANs
	gmt grdmath Median_line_figs/smooth_${chain}_${fw}_ne.grd 0 NAN = mean_height_grid.grd
	# find mean height and define it as mh
	mh=$(gmt grdvolume mean_height_grid.grd -o3)
	# for plotting cross profiles and storing data for resampled weighted line
	gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd chain_lines/weighted_line_${fw}_${chain}.txt -C800k/2/20 -fg -Ar -Dchain_lines/weighted_line_resampled_${chain}_${fw}.txt > mean_chain_width/cross.txt
	# Find boundary points based on mean height value
	gmt grdtrack -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd chain_lines/weighted_line_${fw}_${chain}.txt -C800k/2/20 -fg -Ar -F+z${mh}  > mean_chain_width/width.txt
	# find the maximum width value
	gmt math mean_chain_width/width.txt -o1,2,4,12 -C12 100 PQUANT 2 DIV = mean_chain_width/max_width_R.txt
	gmt math mean_chain_width/max_width_R.txt -C3 180 ADD = mean_chain_width/max_width_L.txt
	# Draw points along cross profiles with those widths
	gmt vector mean_chain_width/max_width_R.txt -i1,2 -fg -Ttk > mean_chain_width/max_width_line_${fw}_${chain}_R.txt
	gmt vector mean_chain_width/max_width_L.txt -i1,2 -fg -Ttk > mean_chain_width/max_width_line_${fw}_${chain}_L.txt
	# matlab script to make weighted widths
	$MATLAB/bin/matlab -nodisplay -nojvm -batch "Chain_width_weight" > status.log
	# divide width of weighted line by two and make left azumith +180
	gmt math mean_chain_width/weighted_width.txt -C4 2 DIV = mean_chain_width/weighted_width_R.txt
	gmt math mean_chain_width/weighted_width_R.txt -C3 180 ADD = mean_chain_width/weighted_width_L.txt
	# convert to lon lat values for plotting
	gmt vector mean_chain_width/weighted_width_R.txt -i1,2 -fg -Ttk > mean_chain_width/weighted_width_${fw}_${chain}_R.txt
	gmt vector mean_chain_width/weighted_width_L.txt -i1,2 -fg -Ttk > mean_chain_width/weighted_width_${fw}_${chain}_L.txt
	# saves the data unique to fw and chain
	gmt convert mean_chain_width/cross.txt > mean_chain_width/cross_${fw}_${chain}.txt
	gmt convert mean_chain_width/width.txt > mean_chain_width/width_${fw}_${chain}.txt
	gmt convert mean_chain_width/weighted_width.txt > mean_chain_width/weighted_width_${fw}_${chain}.txt
	# plotting the results
	gmt figure mean_chain_width_figs/mean_width_${chain}_${fw} pdf,jpg
	gmt grdimage Median_line_figs/smooth_${chain}_${fw}_ne.grd -RMedian_line_figs/smooth_${chain}_${fw}_ne.grd -JM6i -B -B+t"${fw} km Gaussian Filter"
	# plot the cross profiles
	gmt plot mean_chain_width/cross.txt -Wfaint,yellow
	# plot the line
	gmt plot chain_lines/weighted_line_${fw}_${chain}.txt -W0.5,red #-l"Weighted line"
	# Plot the left rise point
	gmt plot mean_chain_width/width.txt -Sc1p -Glightred -i6,7 -l"Chain width"
	# Plot the right rise point
	gmt plot mean_chain_width/width.txt -Sc1p -Glightred -i9,10
	# plot max width
	gmt plot mean_chain_width/max_width_line_${fw}_${chain}_R.txt -i1,2 -Sc1p -Gpurple -l"Maximium width"
	gmt plot mean_chain_width/max_width_line_${fw}_${chain}_L.txt -i1,2 -Sc1p -Gpurple
	# plot weighted width
	gmt plot mean_chain_width/weighted_width_${fw}_${chain}_R.txt -i1,2 -Sc1p -Glightgreen -l"Weighted chain width"
	gmt plot mean_chain_width/weighted_width_${fw}_${chain}_L.txt -i1,2 -Sc1p -Glightgreen
	# colorbar
	gmt colorbar -B+l"Elevation (m)"
gmt end show
rm -f mean_height_grid.grd
rm -f mean_chain_width/cross.txt
rm -f mean_chain_width/width.txt
rm -f mean_chain_width/max_width_R.txt
rm -f mean_chain_width/max_width_L.txt
rm -f mean_chain_width/max_width_line_R.txt
rm -f mean_chain_width/max_width_line_L.txt
rm -f mean_chain_width/weighted_width_R.txt
rm -f mean_chain_width/weighted_width_L.txt
