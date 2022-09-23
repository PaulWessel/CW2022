gmt begin
	gmt figure Seafloor_ages_distance_plot jpg,ps
	gmt plot HI_age_track_fixed.txt -JX6i -R0/6000/0/150 -B -BWSne -W0.5p -i3,4 --MAP_FRAME_TYPE=plain -l"Hawaiian-Emperor"
	gmt plot LV_age_track_fixed.txt -W0.5p,red -i3,4 -l"Louisville"
	gmt plot FD_age_track.txt -W0.5,green -i2,3 -l"Foundation"
	gmt plot CB_age_track.txt -W0.5,blue -i2,3 -l"Cobb"
	gmt plot PC_age_track.txt -W0.5,magenta -i2,3 -l"Pitcairn"
gmt end show