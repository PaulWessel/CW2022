plot_end_circles() { # The function takes one argument: The 2-char code of chain (e.g., HI)
	# To run, call it like this:  plot_end_circle HI before each gmt clip call
	# YOUNG END:
	# Get the projected coordinates of the two end points for L and R lines:
	L=($(gmt convert -Ef chain_widths_95/weighted_width_${1}_L.txt | gmt mapproject))
	R=($(gmt convert -Ef chain_widths_95/weighted_width_${1}_R.txt | gmt mapproject))
	# Compute the mid point (x,y)
	x=$(gmt math -Q ${L[0]} ${R[0]} ADD 2 DIV =)
	y=$(gmt math -Q ${L[1]} ${R[1]} ADD 2 DIV =)
	# Compute the mid point (lon,lat)
	M=$(echo $x $y | gmt mapproject -I)
	# Find symbol size as distance between L and R projected points
	s=$(gmt math -Q ${L[0]} ${R[0]} SUB ${L[1]} ${R[1]} SUB HYPOT =)
	# Get age at start of chain
	a=$(gmt convert -Ef final_line_width_age_tables/${1}_line_width_age.txt -i11)
	# Plot the red circle
	echo $M $a | gmt plot -Gred -Sc${s} -C
	# OLD END:
	# Get the projected coordinates of the two end points for L and R lines:
	L=($(gmt convert -El chain_widths_95/weighted_width_${1}_L.txt | gmt mapproject))
	R=($(gmt convert -El chain_widths_95/weighted_width_${1}_R.txt | gmt mapproject))
	# Compute the mid point (x,y)
	x=$(gmt math -Q ${L[0]} ${R[0]} ADD 2 DIV =)
	y=$(gmt math -Q ${L[1]} ${R[1]} ADD 2 DIV =)
	# Compute the mid point (lon,lat)
	M=$(echo $x $y | gmt mapproject -I)
	# Find symbol size as distance between L and R projected points
	s=$(gmt math -Q ${L[0]} ${R[0]} SUB ${L[1]} ${R[1]} SUB HYPOT =)
	# Get age at start of chain
	a=$(gmt convert -El final_line_width_age_tables/${1}_line_width_age.txt -i11)
	# Plot the red circle
	echo $M $a | gmt plot -Gred -Sc${s} -C
}
