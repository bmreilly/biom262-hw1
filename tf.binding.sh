#!/bin/bash

#PBS -q hotel

#PBS -N 160112.biom262.hw1

#PBS -l nodes=1:ppn=1

#PBS -l walltime=01:00:00

#PBS -o tf.binding.sh.o

#PBS -e tf.binding.sh.e

#PBS -V 

#PBS -M bmreilly@ucsd.edu

#PBS -m abe

#PBS -A bejar-group

# add line to go to stdout
echo "Hello I am a message in standard out (stdout)"

# add line to go to error output
echo "Hello I am a message in standard error (stderr) >&2"

# load programs we need 
module load biotools

# change to directory where we have our data files + we want our output files
cd ~/biom262/biom262_hw/biom262-hw1

# Exerise 1 Answer 
awk -F "\t" '{ if ($4 == "NFKB") {print;}}' tf.bed > tf.nfkb.bed

# Exercise 2 Answer
awk -F "\t" '{ if ($3 =="transcript") {print;}}' gencode.v19.annotation.chr22.gtf >  gencode.v19.annotation.chr22.transcript.gtf

# exercise 3
bedtools flank -g hg19.genome -l 2000 -r 0 -s -i gencode.v19.annotation.chr22.transcript.gtf > gencode.v19.annotation.chr22.transcript.promoter.gtf


# exercise 4
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed > \
  gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf

# exercise 5
bedtools getfasta -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf \
  -s -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta


