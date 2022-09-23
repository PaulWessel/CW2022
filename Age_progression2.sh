#used -C4000k/2k for HIs
# Assumies you are inside the profiles directory
grep -v '>' age_predict_HI.txt > thepoints.txt
rm -f Filter_circles.txt
while read lon lat dt; do
	fw=`gmt math -Q 200 437 200 SUB 90 DIV $dt MUL ADD =`
	gmt grdcut @earth_relief_10m -S$lon/$lat/5000k+n -Gcircle.grd 
	gmt grdmath circle.grd 0 MUL ${fw} ADD = circle.grd
	gmt grd2xyz circle.grd -s >> Filter_circles.txt
done < thepoints.txt  
# surface on the 30 min blocks, original region, create new grid
gmt begin
	#echo 205.1 19.3 90 | gmt backtracker -Df -EWK08-A_APM.txt -Lb10 > predict_HI.txt
	# blockmean with 
	gmt figure blockmean_circle5000k_HI2 pdf
	gmt blockmean Filter_circles.txt -R130/270/-65/65 -I30m -Gblockmean_HI.grd
	gmt grdimage blockmean_HI.grd -JM6i -B
	gmt colorbar -B
gmt end show