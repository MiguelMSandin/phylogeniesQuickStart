#!/bin/bash

FILE=""
THREADS=""

# Using the auto algorithm
mafft --thread $THREADS $FILE > ${FILE/.fasta/_align-auto.fasta}

# Using the FFT-NS-i algorithm
# Iterative refinement method
mafft --thread $THREADS  --retree 2 --maxiterate 1000 $FILE > ${FILE/.fasta/_align-fftnsi.fasta}

# Using the L-INS-i algorithm
# Probably most accurate; recommended for <200 sequences; iterative refinement method incorporating local pairwise alignment information
mafft --thread $THREADS --localpair --maxiterate 1000 $FILE > ${FILE/.fasta/_align-linsi.fasta}

# Using the G-INS-i algorithm
# Suitable for sequences of similar lengths; recommended for <200 sequences; iterative refinement method incorporating global pairwise alignment information
mafft --thread $THREADS --globalpair --maxiterate 1000 $FILE > ${FILE/.fasta/_align-ginsi.fasta}

# Using the E-INS-i algorithm:
# Suitable for sequences containing large unalignable regions; recommended for <200 sequences
mafft --thread $THREADS --ep 0 --genafpair --maxiterate 1000 $FILE > ${FILE/.fasta/_align-einsi.fasta}
