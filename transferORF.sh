#!/bin/bash

# recursively transfer raw files from source to target dir
# assumes srcDir has directories Lights/ Darks/ Flats/ DarkFlats/ Bias/

srcDir=$1
tgtRoot=$2

subd=(Lights Darks Light Dark Flats Bias DarkFlats Flat DarkFlat)

baseDir=$(basename $srcDir)
dtDir=$(basename $(dirname $srcDir))
tgtDir=${tgtRoot}/${baseDir}_${dtDir}
echo $tgtDir
mkdir -p $tgtDir

for d in ${subd[@]}; do
	echo $d
	curd=${srcDir}/${d}
	
	if [ -d $curd ]; then
		echo -e "\t Files exist"
		mkdir ${tgtDir}/${d}
		numsrc=$(ls ${curd}/*ORF | wc -l)
		echo -e "\t$numsrc files found! Transferring ..."

		cp ${curd}/*ORF ${tgtDir}/${d}/.
		
		numtgt=$(ls ${tgtDir}/${d}/*ORF | wc -l)
		echo -e "\t$numtgt files transferred"
	else 
		echo -e "\t Not found.";
	fi
done


