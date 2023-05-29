#!/bin/bash

echo "Enter full path to the dataset: "
read path
#path="*/rel3_dhcp_anat_pipeline"

echo "Enter full path where you want to save csv file: "
read newDirectory
#newDirectory="*/zavrsni/data"

echo "Enter number: "
read n

if [ -d "$newDirectory" ]; then :
else `mkdir $newDirectory`
fi

declare -i count=1
for directory in $path/*; do
	if [ $count -lt n ]; then :
		tsvFile=''
		niiFile=''
		declare -i scanNum=1
		for dir in $directory/*; do
			if [[ "$dir" == *".tsv" ]]; then
				tsvFile=$dir
				for dire in $directory/*; do
					if [[ "$dire" == *".tsv" ]]; then :
					else
						subdir="$dire/anat"
						for file in $subdir/*; do
							if [[ "$file" == *"desc-restore_T1w.nii.gz" ]]; then : 
								nii="${file#*/anat}"
								niiFile="zeljena_putanja$nii"
								python3 create_csv.py $tsvFile $scanNum
								"$newDirectory/" $niiFile
								((count = count +1))		 
							fi
						done
						((scanNum=scanNum+1))	
					fi
				done
			fi
		done
	fi
done