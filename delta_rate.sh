#!/bin/bash
# Two hotspots i and j with their great circle connector
# Plot the two drift vectors and pretend to project them
# onto the connector and add them up: that is our data.
gmt begin
	gmt set PS_MEDIA 6.9ix5.1i
	cat <<- EOF > hotspots.txt
	0	30	90	2000
	60	60	200	900
	EOF
	cat <<- EOF > unit_vec.txt
	0	30	34.8	900
	60	60	260.8	450
	EOF
	cat <<-EOF > labels1.txt
	0 30.2 0 RT Hotspot @%6%i@%%
	59 60 0 RB Hotspot @%6%j@%%
	EOF
	cat <<-EOF > labels2.txt
	5.5		36.3 0 LT 18p @[\\mathbf{\\hat{n}}_{ij}@[
	53	59.0 0 LT 18p @[\\mathbf{\\hat{n}}_{ji}@[
	EOF
	gmt figure delta_rate_1 png
	gmt plot -R-5/68/25/65 -JM6i -W0.5p -Sqn1:+l"INTERHOTSPOT DISTANCE"+v+f13p hotspots.txt -X2.6c -Y0.35c
	gmt plot -S=18p+e+h0.5 -Gblack -W1p unit_vec.txt
	gmt plot -Sc9p -Gblack hotspots.txt
	gmt text -F+a+j+f20p -DJ24p -N labels1.txt -C+tO -Glightyellow -W1p
	gmt text -F+a+j+f -N labels2.txt

	cat <<-EOF >> labels2.txt
	20.36	28.0 0 LM 28p @[\\mathbf{\\vec{r}}_i@[
	55.7	51.8 0 CT 28p @[\\mathbf{\\vec{r}}_j@[
	EOF
	gmt figure delta_rate_2 png
	gmt plot -R-5/68/25/65 -JM6i -W0.5p -Sqn1:+l"INTERHOTSPOT DISTANCE"+v+f13p hotspots.txt -X2.6c -Y0.35c
	gmt text -F+a+j+f20p -DJ24p -N labels1.txt -C+tO -Glightyellow -W1p
	gmt text -F+a+j+f -N labels2.txt
	gmt plot -S=16p+e+h0.5 -Ggreen -W2p,green hotspots.txt
	gmt plot -S=18p+e+h0.5 -Gblack -W1p unit_vec.txt
	gmt plot -Sc9p -Gblack hotspots.txt

	gmt figure delta_rate_3 png
	cat <<- EOF > labels3.txt
	0	34.1 0 RT @~a@~@-ij@-
	60	61.7 0 RM @~a@~@-ji@-
	0	35.2 0 RB @~b@~@-i@-
	60	63.4 0 RM @~b@~@-j@-
	EOF
	cat <<- EOF > vec_projected.txt
	0	30	34.8	1200
	60	60	260.8	500
	EOF
	cat <<- EOF > dashed.txt
	>
	7.86245464914	38.6316466224
	20.5501283858	28.3961361822
	>
	51.3599037007	58.9916710593
	55.4833280865	52.3021401233
	EOF
	cat <<- EOF > angles.txt
	0	30	0.7c	55	90
	0	30	1.3c	-1.5	90
	60	60	0.7c	-171.2	90
	60	60	1.3c	-110	90
	EOF

	gmt plot -R-5/68/25/65 -JM6i -W0.5p -Sqn1:+l"INTERHOTSPOT DISTANCE"+v+f13p hotspots.txt -X2.6c -Y0.35c
	# Plot the azimuths
	echo 0  30 90 3c | gmt plot -W0.25p,. -Sv10p
	echo 60 60 90 3c | gmt plot -W0.25p,. -Sv10p
	gmt plot -W0.25p,- dashed.txt
	gmt text -F+a+j+f20p -DJ24p -N labels1.txt -C+tO -Glightyellow -W1p
	gmt text -F+a+j+f -N labels2.txt
	gmt text -F+a+j+f18p,Times-Italic -Dj2p -N labels3.txt
	gmt plot -S=16p+e+h0.5 -Ggreen -W2p,green hotspots.txt
	gmt plot -S=16p -W2p,orange vec_projected.txt
	gmt plot -S=18p+e+h0.5 -Gblack -W1p unit_vec.txt
	gmt plot -Sc9p -Gblack hotspots.txt
	# Draw azimuths indicators for connectors and vectors
	gmt plot -W0.5p -Sm4p+b -Gblack angles.txt
	cat <<- EOF > d_ij.txt
	0	30	34.8	1900
	60	60	260.8	1100
	EOF
	cat <<- EOF >> labels3.txt
	9	43 0 CM d@-ij@-
	45	59.5 0 CM d@-ji@-
	EOF
	gmt figure delta_rate_4 png
	gmt plot -R-5/68/25/65 -JM6i -W0.5p -Sqn1:+l"INTERHOTSPOT DISTANCE"+v+f13p hotspots.txt -X2.6c -Y0.35c
	# Plot the azimuths
	echo 0  30 90 3c | gmt plot -W0.25p,. -Sv10p
	echo 60 60 90 3c | gmt plot -W0.25p,. -Sv10p
	gmt plot -W0.25p,- dashed.txt
	gmt plot -S=16p+e+h0.5 -Ggreen -W2p,green hotspots.txt
	gmt plot -S=16p -W2p,red d_ij.txt
	gmt plot -Sc9p -Gblack hotspots.txt
	gmt plot -S=18p+e+h0.5 -Gblack -W1p unit_vec.txt
	# Draw azimuths indicators for connectors and vectors
	gmt plot -W0.5p -Sm4p+b -Gblack angles.txt
	gmt text -F+a+j+f20p -DJ24p -N labels1.txt -C+tO -Glightyellow -W1p
	gmt text -F+a+j+f -N labels2.txt
	gmt text -F+a+j+f18p,Times-Italic -Dj2p -N labels3.txt
gmt end show
