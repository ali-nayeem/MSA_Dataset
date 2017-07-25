#!/bin/bash

cd "$(dirname "$0")"

input="input.fasta"
dataset_list="R6 R7 R8 R9 R10"
path="./100S"

script_dir=`pwd`

echo "$dataset_list" >> $path/donelist.txt

for data in $dataset_list
do
 pushd "$path/$data"
 $script_dir/generate_solutions_for_one_data.sh $input
 popd
done
