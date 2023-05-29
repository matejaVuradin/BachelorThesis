#!/bin/sh

echo "Enter full path to the dataset: "
read path
#path="/*/rel3_dhcp_anat_pipeline"

echo "Enter full path where you want to save generated data: "
read newDirectory
#newDirectory="/*/images,

echo "Enter number of images: "
read n

if [ -d "$newDirectory" ]; then :
else `mkdir $newDirectory`
fi

declare -i count=1
for dir in $path/*; do
	if [ $count -lt n]; then :
		for subdir in $dir/*; do
			for ssubdir in $subdir/*; do
				for file in $ssubdir/*; do
					if [[ "$file" == *"desc-restore_T1w.nii.gz" ]];then
						cp "$file" "$newDirectory"
						((count = count +1))
					fi
				done
			done
		done
	fi
done