chain=$1
# for varying filter width 
gmt begin
	# resize the varying fw grid
	#gmt grdcut blockmean_guassian2000m_${chain}.grd -R130/260/-65/65 -Gfw.grd
	# make envelope
	#gmt grdmask APM/data/Envelopes/${chain}_envelope.txt -G${chain}_mask.grd -Rpacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -N1/NaN/NaN
	# multiply mask with residual grid to mask the chains
	#gmt grdmath ${chain}_mask.grd pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd MUL = pacific_topo_1m_raw_subfloorHW_subsed_with_${chain}masks.grd
	# runs the median filter with varying fw
	#gmt grdfilter pacific_topo_1m_raw_subfloorHW_subsed_with_${chain}masks.grd -Fmfw.grd -D2 -I10m -GMedian_${chain}.grd
	# runs the guassian filter over the median filter with same varying fw
	#gmt grdfilter Median_${chain}.grd -Fgfw.grd -D2 -I10m -GMedian_guassian_${chain}.grd
	# resamples the data from 10m to 1m
	#gmt grdsample Median_guassian_${chain}.grd -I1m -GMedian_guassian_${chain}.grd
	# subtact filter from residuals 
	#gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd Median_guassian_${chain}.grd SUB = Filter_grids/Varying_filter_${chain}.grd
	# create a plot of the results
	#gmt figure Filter_grids/Varying_filter_${chain} jpg
	#gmt grdimage Filter_grids/Varying_filter_${chain}.grd -JM6i -B
	#gmt plot APM/data/Envelopes/${chain}_envelope.txt -W0.25p,red
	#gmt colorbar -B 
gmt end show

# for 420 fw and no mask over seamounts
gmt begin
	# resample fw grid to 1m to fit residual grid
	#gmt grdsample fw.grd -I1m -Gfw.grd 
	# This will create a grid that only shows topo where varying fw is and makes NaNs everywhere else
	#gmt grdmath pacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd fw.grd OR = Residual.grd
	# runs 420 median filter
	#gmt grdfilter Residual.grd -Fm420 -D2 -I10m -GMedian_420_${chain}.grd
	# runs 420 guassian filter over median filter
	#gmt grdfilter Median_420_${chain}.grd -Fg420 -D2 -I10m -GMedian_guassian_420_${chain}.grd
	# resamples data from 10m to 1m
	#gmt grdsample Median_guassian_420_${chain}.grd -I1m -GMedian_guassian_420_${chain}.grd
	# subtract filter from residuals
	#gmt grdmath Residual.grd Median_guassian_420_${chain}.grd SUB = Filter_grids/420_filter_${chain}.grd
	# create plots of the results
	#gmt figure Filter_grids/420_filter_${chain}
	#gmt grdimage Filter_grids/420_filter_${chain}.grd -JM6i -B 
	#gmt colorbar -B 
gmt end show

# Adding the Envelopes
gmt begin
	gmt grdmask APM/data/Envelopes/${chain}_envelope.txt -G${chain}_mask.grd -Rpacific_topo_1m_raw_subfloorHW_subsed_with_masks.grd -NNaN/1/1
	# multiply mask with final topo grids to isolate chains
	gmt grdmath Filter_grids/Varying_filter_${chain}.grd ${chain}_mask.grd MUL = Filter_grids/Varying_filter_envelope_${chain}.grd
	#gmt grdmath Filter_grids/420_filter_${chain}.grd ${chain}_mask.grd MUL = Filter_grids/420_filter_envelope_${chain}.grd
	# for single chain
	gmt grdmath Filter_grids/Varying_filter_envelope_${chain}.grd DUP 500 SUB 0 LT 1 NAN ADD = Filter_grids/500m_contour_finial_grid_${chain}.grd
	#gmt grdmath Filter_grids/420_filter_envelope_${chain}.grd DUP 500 SUB 0 LT 1 NAN ADD = Filter_grids/500m_contour_finial_grid_${chain}.grd
	# make plots
	gmt figure Filter_grids/Varying_filter_envelope_${chain}
	gmt grdimage Filter_grids/500m_contour_finial_grid_${chain}.grd -JM6i -B
	gmt plot APM/data/Envelopes/${chain}_envelope.txt -W0.25p,red
	gmt colorbar -B 
	#gmt figure Filter_grids/420_filter_envelope_${chain}
	#gmt grdimage Filter_grids/420_filter_envelope_${chain}.grd -JM6i -B 
	#gmt colorbar -B 
gmt end show



