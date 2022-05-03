#!/bin/bash

# A fasta file (if the extension is different than '.fasta', you'll have to modify the script accordingly...)
FILE=""

# The number of bootstraps
BS=""

# The number of threads
THREADS=""

# Using the GTR+gamma model of evolution
raxmlHPC-PTHREADS-SSE3 -T $THREADS -m GTRGAMMA -p $RANDOM -x $(date +%s) -d -f a -N $BS -n $FILE -s ${FILE/.fasta/_RAxML-GTRgamma.fasta}

# Using the CAT model of evolution
raxmlHPC-PTHREADS-SSE3 -T $THREADS -m GTRCAT -c 25 -p $RANDOM -x $(date +%s) -d -f a -N $BS -n $FILE -s ${FILE/.fasta/_RAxML-CAT.fasta}
