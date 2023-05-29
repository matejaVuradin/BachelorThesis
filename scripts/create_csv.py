import sys
import csv
import math
from os.path import exists

tsvFile = sys.argv[1]
scanNum = int(sys.argv[2]) #neki ispitanici imaju vise scenova
csvFile = sys.argv[3] + "datasetT1_100.csv"

datasetCSV = []
with open(tsvFile) as tFile:
	tsv_file = csv.reader(tFile, delimiter='\t')
x = 1
for line in tsv_file:
	if x == scanNum + 1:
		data = line
	x +=1

subject_id = data[0]
scan_id = data[1]
if scan_id == "1":
	t1 = sys.argv[4]
sub_str = "_ses-"
t1_path = t1[:t1.index(sub_str) + len(sub_str)] + subject_id+"_desc-restore_T1w.nii.gz"
age_at_scan = data[3]
age = math.floor(float(data[3]))
datasetCSV.append([t1_path, subject_id, age_at_scan, age])

if exists(csvFile):	
	with open(csvFile, 'a+', newline='') as cFile:
		csv_file = csv.writer(cFile)
		csv_file.writerows(datasetCSV)
else:
	with open(csvFile, 'w', newline='') as cFile:
		headers = ['t1_path', 'subject_id', 'age_at_scan', 'age'];
		csv_file = csv.writer(cFile)
		csv_file.writerow(headers)
		csv_file.writerows(datasetCSV)