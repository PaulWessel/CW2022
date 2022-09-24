#!/bin/bash
#
# Makes the (dist,age,d-age) file for one hotspot trail
#
#   We determine closest point on medial line for each seamount, and assign distance to
#   these projected points.  Two files are produced:
#   XX_info.txt ; Has the age data set locations, projected locations, offsets, etc, [for information]
#   XX_age_dist.txt: Has distance, age, delta-age for the projected points, suitable for regression.
#
# Paul Wessel, March 25, 2020.
if [ ! -d data ]; then
	echo "make_dist_age_data.sh: must be run from the top APM directory" >&2
	exit -1
fi
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
	cat << EOF >&2

usage: make_dist_age_data.sh HS

	HS is the hotspot tag (e.g., HI).
	Assumes median line file is called data/HS_medianline.txt
EOF
	exit
fi

# Some key data files.  These can change depending on plate and model/data updates:
#--------------------------------
SPOTS=data/WK08-A_spots.txt
APM=data/WK08-A_APM.txt
AGES=data/Pacific_Ages.txt
HTABLE=data/Pacific_Hotspots.txt
NAMES=data/Pacific_Names.txt
#--------------------------------
#
# 1. Get HS tag and start procession

gmt set FORMAT_GEO_OUT +D
HS=$1
Name=`grep $HS $NAMES | awk '{print $NF}'`
Age=`grep $HS $HTABLE | awk '{print $10}'`
# 2a. Extract ${HS} ages from the database
grep $Name $AGES | grep -v '^#' | grep -v NaN > /tmp/chain_agedata.txt

# 2b. We assume the raw median curve is called ${HS}_medianline.txt
# It was then converted and resampled every 1 km to yield the following path:
gmt sample1d data/${HS}_medianline.txt -i0,1 -I1k | gmt mapproject -G+uk | grep -v '^>' > /tmp/chain_dist_lonlat_1km.txt

# 3. Determine nearest distance along this curve for each dated sample. This means we find the perpendicular
#    shortest distance from a sample to the trail curve and note the distance at that point.
gmt mapproject /tmp/chain_agedata.txt -L/tmp/chain_dist_lonlat_1km.txt+uk > /tmp/chain_info.txt

# 4. Find the nearest distance along the path to the point we just found - this is a cheap way
#    to get the cumulative distance at that normal point to the nearest ~500 meters
# Note: In GMT 6, all trailing text is at the end, so the read order has changed
echo "# Along median line distances and ages with uncertainties" > ${HS}_age_dist.txt
echo "# dist(km)	age	delta_age 	type	name" >> ${HS}_age_dist.txt
while read lon lat age dt dist dlon dlat ty ref name tag chain; do
	pdist=`gmt mapproject /tmp/chain_dist_lonlat_1km.txt -G${dlon}/${dlat}+uk -o2,3 --FORMAT_FLOAT_OUT=%.1f | grep -v '^>' | sort -g -k 2 | head -1 | cut -f1`
	echo "$pdist	$age	$dt 	$ty 	$name" >> ${HS}_age_dist.txt
done < /tmp/chain_info.txt

# 5. Finalize the info.txt file
echo "# Projected ages onto median line" > ${HS}_info.txt
echo "# (slon,slat) is original seamount location, (plon,plat) is nearest point on median line, off is across-distance in km" >> ${HS}_info.txt
echo "# slon	slat	age	delta_age	name	off	name	plon	plat type	ref		name	tag	chain" >> ${HS}_info.txt
cat /tmp/chain_info.txt >> ${HS}_info.txt

# 6. Clean up
rm -f /tmp/chain_*.txt
