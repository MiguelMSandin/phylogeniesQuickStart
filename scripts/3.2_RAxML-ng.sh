#!/bin/bash

FILE=""
PREFIX=""

raxml-ng --parse --msa $FILE --model GTR+G --prefix $PREFIX.parser

BS=""
THREADS=""
START_TREES="10"

raxml-ng --all --msa $PREFIX.parser.raxml.rba --model GTR+G --tree pars{$START_TREES} --prefix $PREFIX --seed $RANDOM --threads $THREADS --bs-trees $BS
