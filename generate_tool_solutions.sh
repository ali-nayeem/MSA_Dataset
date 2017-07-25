#!/bin/bash

cd "$(dirname "$0")"

input="input.fasta"
dataset_list="R0 R1 R2 R3"
path="./100S"

script_dir=`pwd`

echo "$dataset_list" >> $path/donelist.txt

for data in $dataset_list
do
 pushd "$path/$data"
 $script_dir/generate_solutions_for_one_data.sh $input
 popd
done