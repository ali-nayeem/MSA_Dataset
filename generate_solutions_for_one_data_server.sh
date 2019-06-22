#!/bin/bash

input=$1

echo "--------TESTING T_COFFEE-----------------------------------"
#read name
~/biosoft/tcoffee/Version_11.00.8cbe486/bin/t_coffee "$input" -type=dna -outfile="$input"_tcoffee -output=fasta_aln 
echo "--------TESTING MUSCLE------------------------------------------"
#read name
~/biosoft/muscle3.8.31/src/muscle21 -seqtype dna -in "$input" -out "$input"_temp
python ~/biosoft/stable.py "$input" "$input"_temp > "$input"_muscle
rm "$input"_temp
echo "-----------TESTING MAFFT--------------------------------------------"
#read name
temp_man=$MAFFT_BINARIES
unset MAFFT_BINARIES
mafft --auto --nuc --preservecase --inputorder --thread -1  "$input" > "$input"_mafft
MAFFT_BINARIES=$temp_man
echo "-----------TESTING clustalw--------------------------------------------"
#read name
~/biosoft/clustalw-2.1/src/clustalw2 -type=DNA -outorder=INPUT -align -output=fasta -infile="$input" -outfile="$input"_clustalw
echo "-----------TESTING clustalo--------------------------------------------"
#read name
~/biosoft/clustal-omega-1.2.4/src/clustalo --seqtype=DNA --auto  --output-order=input-order --outfmt=fasta  --in="$input" --out="$input"_clustalo --verbose --force
echo "-----------TESTING kalign--------------------------------------------"
#read name
kalign -i "$input" -o "$input"_kalign
echo "-----------TESTING fsa--------------------------------------------"
#read name
fsa --fast "$input" > "$input"_fsa
echo "-----------TESTING prank--------------------------------------------"
#read name
prank -d="$input" -o=prank.out -DNA
python ~/scripts/stable.py "$input" prank.out.best.fas > "$input"_prank
rm prank.out.best.fas
echo "-----------TESTING pasta--------------------------------------------"
#read name
rm -r ./pasta
run_pasta.py --auto -d DNA -i  "$input" -o ./pasta -j msa
cp ./pasta/msa.marker001.*.aln "$input"_temp
python ~/scripts/stable.py "$input" "$input"_temp > "$input"_pasta
rm "$input"_temp
