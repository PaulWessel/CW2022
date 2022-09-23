#!/bin/sh
# Turn all txt envelope files into kml files
chain=$1
ls APM/data/Envelopes/${chain}_envelope.txt | awk '{print substr($1,1,2)}' > /tmp/t.lis
while read tag; do
	gmt2kml -Fl -W1p,red APM/data/Envelopes/${chain}_envelope.txt > APM/data/Envelopes/${chain}_envelope.kml
done < /tmp/t.lis
