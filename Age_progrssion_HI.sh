chain=$1
gmt begin
	echo 205.1 19.3 100 | gmt backtracker -Df -EWK08-A_APM.txt -Lb1k > predict_${chain}.txt
	gmt grdtrack -GAge_curve_1m.grd predict_${chain}.txt | gmt math -o0,1,3 STDIN -C3 2 COL SUB = | grep -v NaN > age_predict_${chain}.txt
	gmt grdtrack -GAge_curve_1m.grd predict_${chain}.txt -C6000k/1k | gmt math -o0,1,3 STDIN -C3 2 COL SUB = age_track_${chain}.txt
	gmt convert age_track_${chain}.txt -Dprofiles/age_track_${chain}_%d.txt
gmt end show

rm -f Filter_track_circles.txt
rm -f Filter_circles.txt
grep -v '>' age_predict_${chain}.txt > thepoints.txt
let rec=0
while read lon lat dt; do
	fw=`gmt math -Q 420 330 SUB 90 SQRT 48 SQRT SUB DIV T SQRT MUL 86 ADD DUP 230 GT MUL DUP 0 EQ 230 MUL ADD =`
	crosstrack=age_track_${chain}_${rec}.txt
	gmt math profiles/${crosstrack} -o0,1,3,4 -N5/0 -C3 ${fw} ADD -C4 1000 ADD =>> Filter_track_circles.txt
	let rec=rec+1
done < thepoints.txt

while read lon lat dt; do
	fw=`gmt math -Q 420 330 SUB 90 SQRT 48 SQRT SUB DIV T SQRT MUL 86 ADD DUP 230 GT MUL DUP 0 EQ 230 MUL ADD =`
	gmt grdcut @earth_relief_10m -S$lon/$lat/1500k+n -Gcircle.grd 
	gmt grdmath circle.grd 0 MUL ${fw} ADD = circle.grd
	gmt grd2xyz circle.grd -s >> Filter_circles.txt
done < thepoints.txt
gmt math Filter_circles.txt -N4/0 -o0,1,2,3 -C3 1 ADD =>> Filter_track_circles.txt

gmt begin
	gmt blockmean Filter_track_circles.txt -R130/270/-65/65 -I1 -fg -W -Gblockmean_${chain}.grd
	gmt grdfilter blockmean_${chain}.grd -Fg2000 -D2 -I10m -Gblockmean_guassian2000m_${chain}.grd
	gmt figure blockmean_guassian_circle1500k_track6000k_${chain}_230 pdf
	gmt makecpt -T100/500
	gmt grdimage blockmean_guassian2000m_${chain}.grd -JM6i -B
	gmt plot -W1p <<- EOF
	206 19
	185 27
	172 32.5
	168 52
EOF
	gmt colorbar -B
gmt end show
