#!/bin/bash

chain=$1


gmt mapproject Tutley/Tutley_${chain}.txt -Af+v -fg > Tutley/Tutley_vector_${chain}.txt
