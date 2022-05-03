#!/bin/bash

# A fasta file (if the extension is different than '.fasta', you'll have to modify the script accordingly...)
FILE=""

# The number of bootstraps
BS=""

# The number of threads
THREADS=""

# Maximal RAM usage for memory saving mode. Very useful for large trees
MEM=2GB

iqtree -s $FILE -st "DNA" -pre ${FILE/.fasta/_IQtree} -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl
