#!/bin/bash

# A fasta file (if the extension is different than '.fasta', you'll have to modify the script accordingly...)
FILE=""
# The output fasta file
OUT=""
# The Gap Threshold; from 0 to 100, although trimal requires from 0 to 1, so we'll deal with that later
GAPTHRESHOLD=""

# a basic trimming
trimal -in $FILE -out ${FILE/.fasta/_trim$GAPTHRESHOLD.fasta} -gt 0.$GAPTHRESHOLD

# now including also a minimum similarity threshold
SIMTHRESHOLD=""
trimal -in $FILE -out ${FILE/.fasta/_trim$GAPTHRESHOLD.fasta} -gt 0.$GAPTHRESHOLD -st $0.SIMTHRESHOLD
