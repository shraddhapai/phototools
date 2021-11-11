#!/bin/bash

inDir=$1

dirset=(Lights Darks Light Dark Flats Bias DarkFlats Flat DarkFlat)

for subd in ${dirset[@]}; do
    if [ -d ${inDir}/${subd} ]; then
        echo "In ${inDir}/${subd}"
        numtgt=$(ls ${inDir}/${subd}/*JPG | wc -l)
        echo -e "\t $numtgt files found. Deleting ..."
        rm ${inDir}/${subd}/*JPG
        echo -e "\tdeleted"
    fi
done