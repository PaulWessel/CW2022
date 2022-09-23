#!/bin/sh
# Turn all kml envelope files into txt files
chain=$1
ls APM/data/Envelopes/${chain}_envelope.kml | awk '{print substr($1,1,2)}' > /tmp/t.lis
while read tag; do
	kml2gmt APM/data/Envelopes/${chain}_envelope.kml > APM/data/Envelopes/${chain}_envelope.txt
done < /tmp/t.lis