#!/bin/bash

cd "$(dirname "$0")"

input="input.fasta"
dataset_list="R16 R17 R18 R19"
path="./100S"

script_dir=`pwd`

echo "$dataset_list" >> $path/donelist.txt

for data in $dataset_list
do
 pushd "$path/$data"
 $script_dir/generate_solutions_for_one_data.sh $input
 popd
done
