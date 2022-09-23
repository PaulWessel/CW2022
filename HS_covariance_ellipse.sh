#!/bin/bash

gmt begin
	gmt velo covariance_ellipse_real_data.txt -Se111/0.95 -JM10c -Ered -W1p -Gblue -B -R150/260/-60/60
gmt end show

#HI: -R204.27/204.32/19.89/19.95
#SA: -R190.52/190.64/-14.38/-14.22