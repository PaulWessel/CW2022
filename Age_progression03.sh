gmt begin
	#echo 205.1 19.3 100 | gmt backtracker -Df -EWK08-A_APM.txt -Lb1k > predict_HI.txt
	#gmt grdtrack -GAge_curve_1m.grd predict_HI.txt | gmt math -o0,1,3 STDIN -C3 2 COL SUB = | grep -v NaN > age_predict_HI.txt
	#gmt grdtrack -GAge_curve_1m.grd predict_HI.txt -C6000k/1k | gmt math -o0,1,3 STDIN -C3 2 COL SUB = age_track_HI.txt
	#gmt figure age_track_HI_10k pdf
	#gmt grdimage pacific_topo_1m.grd -R140/225/0/55 -JM6i -B 
	#gmt plot age_track_HI.txt -Sc0.01c -Gred -i0,1
	#gmt convert age_track_HI.txt -Dprofiles/age_track_HI_%d.txt
	# guassian filter
	#gmt grdfilter blockmean_HI.grd -Fg2000 -D2 -I10m -Gblockmean_guassian2000m_HI.grd
	# plot track line over grdimage and compare to distance vs. fw plot
	#gmt makecpt -CgrayC -T200/437
	gmt figure blockmean_guassian2000m_HI pdf
	gmt grdimage blockmean_guassian2000m_HI.grd -JM6i -B
	gmt plot -W1p << EOF
	206 19
	185 27
	172 32
	168 52
	164 55
EOF
	gmt colorbar -B
gmt end show

#used -C4000k/2k for HIs
# Assumies you are inside the profiles directory
#grep -v '>' age_predict_HI.txt > thepoints.txt
#let rec=0
#while read lon lat dt; do
	#fw=`gmt math -Q 200 437 200 SUB 90 DIV $dt MUL ADD =`
	#crosstrack=age_track_HI_${rec}.txt
	#gmt math profiles/${crosstrack} -N4/0 -C3 ${fw} ADD = newprofiles/${crosstrack}.new
	#let rec=rec+1
#done < thepoints.txt
#cat newprofiles/age_track_HI_*.txt.new > age_track_HI_with_fw.txt
# surface on the 30 min blocks, original region, create new grid

# making plot of distance vs fw
gmt begin
	gmt grdtrack -Gblockmean_guassian2000m_HI.grd -E206/19/185/27,185/27/172/32.5,172/32.5/168/52,168/52/164/55+d+c --FORMAT_GEO_OUT=+D > fw_distance.txt
    gmt figure fw_distance_plot
    gmt plot fw_distance.txt -i2,3 -JX6i -R0/7000/250/450 -B -BWSne -W1p --MAP_FRAME_TYPE=plain
gmt end show
#while read lon lat dt; do
	#fw=`gmt math -Q 200 437 200 SUB 90 DIV $dt MUL ADD =`
	#gmt math -N4/0 -C3 
