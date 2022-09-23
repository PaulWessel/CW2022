#!/bin/bash

chain=$1

gmt sample1d final_line_width_age_tables/${chain}_line_width_age.txt -N11 -T0, -o0,1 > tmp
gmt math tmp -C0 DUP 0 LE 360 MUL ADD = lon_lat
gmt convert lon_lat >> azimuths/hotspot_ALL_lon_lat_copy.txt


rm -f tmp lon_lat