gmt begin
	echo 205.1 19.3 100 | gmt backtracker -Df -EWK08-A_APM.txt -Lb1k > predict_HI.txt
	gmt grdtrack -GAge_curve_1m.grd predict_HI.txt | gmt math -o0,1,3 STDIN -C3 2 COL SUB = | grep -v NaN > age_predict_HI.txt
	gmt grdtrack -GAge_curve_1m.grd predict_HI.txt -C6000k/1k | gmt math -o0,1,3 STDIN -C3 2 COL SUB = age_track_HI.txt
	gmt convert age_track_HI.txt -Dprofiles/age_track_HI_%d.txt
gmt end show

rm -f Filter_track_circles.txt
rm -f Filter_circles.txt
rm -f newprofiles/age_track_HI_*.txt.new
grep -v '>' age_predict_HI.txt > thepoints.txt
let rec=0
while read lon lat dt; do
	fw=`gmt math -Q 420 330 SUB 90 SQRT 48 SQRT SUB DIV $dt SQRT MUL 86 ADD =`
	crosstrack=age_track_HI_${rec}.txt
	gmt math profiles/${crosstrack} -o0,1,3,4 -N5/0 -C3 ${fw} ADD -C4 1000 ADD =>> Filter_track_circles.txt
	let rec=rec+1
done < thepoints.txt

while read lon lat dt; do
	fw=`gmt math -Q 420 330 SUB 90 SQRT 48 SQRT SUB DIV $dt SQRT MUL 86 ADD =`
	gmt grdcut @earth_relief_10m -S$lon/$lat/1500k+n -Gcircle.grd 
	gmt grdmath circle.grd 0 MUL ${fw} ADD = circle.grd
	gmt grd2xyz circle.grd -s >> Filter_circles.txt
done < thepoints.txt
gmt math Filter_circles.txt -N4/0 -o0,1,2,3 -C3 1 ADD =>> Filter_track_circles.txt

gmt begin
	gmt figure blockmean_circle1500k_track6000k_HI2 pdf
	gmt blockmean Filter_track_circles.txt -R130/270/-65/65 -I1 -fg -W -Gblockmean_HI.grd
	gmt grdimage blockmean_HI.grd -JM6i -B
	gmt colorbar -B
gmt end show

