#!/bin/bash
# Cross-section movie to look at mean chain width per chain
fw=$1
chain=$2
# create masks for chain widths
rm -f chain_width_movie/width_boundaries_${chain}_${fw}.txt
rm -f chain_width_movie/weighted_width_boundaries_${chain}_${fw}.txt
rm -f chain_width_movie/max_width_boundaries_${chain}_${fw}.txt
gmt begin
    # for the unweighted width
        # get left and right sides for boundaries into one data column
    gmt convert mean_chain_width/width_${fw}_${chain}.txt -s5,6 -o5,6 > chain_width_movie/width_boundaries_${chain}_${fw}.txt
    gmt convert mean_chain_width/width_${fw}_${chain}.txt -I -s8,9 -o8,9 >> chain_width_movie/width_boundaries_${chain}_${fw}.txt
        # create the mask
    gmt grdmask chain_width_movie/width_boundaries_${chain}_${fw}.txt -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -NNAN/NAN/1 -Gchain_width_movie/width_mask_${chain}_${fw}.grd
    gmt grdmath chain_width_movie/width_mask_${chain}_${fw}.grd Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd MUL = chain_width_movie/width_mask_${chain}_${fw}_raw.grd
    gmt grdsample Median_line_figs/smooth_${chain}_${fw}_ne.grd -I1m -Gsample.grd
    gmt grdmath chain_width_movie/width_mask_${chain}_${fw}.grd sample.grd MUL = chain_width_movie/width_mask_${chain}_${fw}_smooth.grd
    # for the weighted widths
    gmt convert mean_chain_width/weighted_width_${fw}_${chain}_R.txt -o0,1 > chain_width_movie/weighted_width_boundaries_${chain}_${fw}.txt
    gmt convert mean_chain_width/weighted_width_${fw}_${chain}_L.txt -I -o0,1 >> chain_width_movie/weighted_width_boundaries_${chain}_${fw}.txt
    gmt grdmask chain_width_movie/weighted_width_boundaries_${chain}_${fw}.txt -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -NNAN/NAN/1 -Gchain_width_movie/weighted_width_mask_${chain}_${fw}.grd
    gmt grdmath chain_width_movie/weighted_width_mask_${chain}_${fw}.grd Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd MUL = chain_width_movie/weighted_width_mask_${chain}_${fw}_raw.grd
    gmt grdsample Median_line_figs/smooth_${chain}_${fw}_ne.grd -I1m -Gsample.grd
    gmt grdmath chain_width_movie/weighted_width_mask_${chain}_${fw}.grd sample.grd MUL = chain_width_movie/weighted_width_mask_${chain}_${fw}_smooth.grd
    # for the max widths
    gmt convert mean_chain_width/max_width_line_${fw}_${chain}_R.txt > chain_width_movie/max_width_boundaries_${chain}_${fw}.txt
    gmt convert mean_chain_width/max_width_line_${fw}_${chain}_L.txt -I >> chain_width_movie/max_width_boundaries_${chain}_${fw}.txt
    gmt grdmask chain_width_movie/max_width_boundaries_${chain}_${fw}.txt -RFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -NNAN/NAN/1 -Gchain_width_movie/max_width_mask_${chain}_${fw}.grd
    gmt grdmath chain_width_movie/max_width_mask_${chain}_${fw}.grd Filter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd MUL = chain_width_movie/max_width_mask_${chain}_${fw}_raw.grd
    gmt grdsample Median_line_figs/smooth_${chain}_${fw}_ne.grd -I1m -Gsample.grd
    gmt grdmath chain_width_movie/max_width_mask_${chain}_${fw}.grd sample.grd MUL = chain_width_movie/max_width_mask_${chain}_${fw}_smooth.grd
gmt end show
rm -f sample.grd

#HI -R160/207/17/53 2i/1.85i 3042 frames
#LV -R-179/-135/-55/-24 -DjTL+w2i/1.8i+o0.2i -M0.4i/0/0.3i/0 -F+p1p 2249 frames

# create cross profiles
gmt begin
	gmt grdtrack chain_lines/weighted_line_${fw}_${chain}.txt -C800k/2/2 -GFilter_grid_cuts/500m_contour_finial_grid_${chain}_cut.grd -GMedian_line_figs/smooth_${chain}_${fw}_ne.grd -Gchain_width_movie/max_width_mask_${chain}_${fw}_raw.grd -Gchain_width_movie/max_width_mask_${chain}_${fw}_smooth.grd -Gchain_width_movie/weighted_width_mask_${chain}_${fw}_raw.grd -Gchain_width_movie/weighted_width_mask_${chain}_${fw}_smooth.grd -Gchain_width_movie/width_mask_${chain}_${fw}_raw.grd -Gchain_width_movie/width_mask_${chain}_${fw}_smooth.grd > chain_width_movie/${chain}_${fw}_width_track.txt
gmt end show

cat << END > main.sh
gmt begin
	gmt convert chain_width_movie/${chain}_${fw}_width_track.txt -Q\$MOVIE_FRAME > track.txt
	gmt plot track.txt -JX8.5i/4.5i -R-500/500/-1000/8000 -B -BWSen -Bg -W1p,black -i2,4 -X0.7i -Y0.3i
    gmt plot track.txt -W1p,grey -i2,5
    gmt plot track.txt -W1p,blue -i2,6 -l"Maximum width"
    gmt plot track.txt -W1p,blue -i2,7
    gmt plot track.txt -W1p,green -i2,8 -l"Weighted width"
    gmt plot track.txt -W1p,green -i2,9
    gmt plot track.txt -W1p,red -i2,10 -l"Width"
    gmt plot track.txt -W1p,red -i2,11
    gmt inset begin -DjTL+w2i/1.8i+o0.2i -M0.4i/0/0.3i/0 -F+p1p
        gmt grdimage Pacific_topo_1m.grd -R-179/-135/-55/-24 -JM? -B -BWSne --MAP_FRAME_TYPE=plain --FONT_ANNOT_PRIMARY=9p --MAP_ANNOT_OBLIQUE=32
        gmt plot track.txt -W0.25p,white
        gmt plot chain_lines/weighted_line_${fw}_${chain}.txt -W0.25p,red
    gmt inset end
gmt end show
END
gmt movie main.sh -Nwidth_movie_${chain}_${fw} -T2249 -Fmp4 -Chd -Lf -Vl -W/tmp/work -Z -M500,pdf
rm -f main.sh

# plot test
gmt begin
    #gmt grdimage chain_width_movie/width_mask_${chain}_${fw}_smooth.grd -JM6i -B
gmt end show