#!/bin/bash

cd "$(dirname "$0")"

fname_list="BB20001 BB20010"  #"BB20001 BB20010 BB20022 BB20033 BB20041"   #"BB12001 BB12013 BB12022 BB12035 BB12044"    #"BB11005 BB11018 BB11020 BB11033"
run_count=3
group_avg=0
dataset_count=0
temp="./temp"
temp_man=$MAFFT_BINARIES
unset MAFFT_BINARIES
for fname in $fname_list
do
    dataset_count=$((dataset_count+1))
    avg_runtime=0		
    for (( i=1; i<=run_count; i++ ))
    do
	inputFile=`find ./bb3_release/ -name $fname.tfa -type f`
	 #output=`echo $inputFile | cut -d "/" -f 3-`
	 #output=./aligned/"$output"_pasta
	 echo "################## $inputFile run: $i ########################"

	 start=$(($(date +%s%N)/1000000))
	 mafft --auto --amino --preservecase --inputorder   "$inputFile" > temp_mafft
	 end=$(($(date +%s%N)/1000000))
	 runtime=$((end-start))
	 echo -n "################## Runtime :"
	 echo $runtime
	 avg_runtime=$((avg_runtime+runtime))
	 rm temp_mafft
	 #break
    done
    avg_runtime=`bc -l <<< $avg_runtime/$run_count`      #$((avg_runtime/run_count))   
    echo $avg_runtime
    group_avg=`bc -l <<< $group_avg+$avg_runtime`
done
group_avg=`bc -l <<< $group_avg/$dataset_count`
echo $fname_list
echo "Groupwise avg: $group_avg"
#MAFFT_BINARIES=$temp_man
