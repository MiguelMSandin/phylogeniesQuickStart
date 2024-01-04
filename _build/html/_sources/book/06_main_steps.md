## Main steps for phylogenetic reconstruction
[1.](/book/08.1_species_selection.md) Select your *species*.  (<-- the most important step!)  
[2.](/book/08.2_align.md) Align sequences.  
[3.](/book/08.3_trim.md) Remove uninformative positions/columns.  
[4.](/book/08.4_phylogenetic_analyses.md) Run phylogenetic inference.  
[5.](/book/08.5_interpreting_trees.md) Understand your phylogenetic tree.  (<-- the most important step!)  
6. Come back to step 1, if needed.  
  
The most important steps of phylogenetic inference are the ***species* selection** and the **interpretation of your resulting tree**. Yet, to be able to fully understand a phylogenetic tree, you need to understand how to build it. Here we will quickly go through every step. Yet keep in mind that **each tree is a hypothesis** of your given data, and therefore the selection of your *species*, the phylogenetic inference and the interpretation of the tree will highly rely on your **scientific question**.  

## Basic pipeline

> Please, bear in mind that there are many different ways to infer phylogenetic patterns among genes, proteins or even morphological characters (or other traits). Here I will just guide you through a basic step-by-step pipeline that I normally use for quick and exploratory analyses of DNA sequences.

We have already selected our *species* (both ingroup and outgroup or outgroups), let's build now a phylogenetic tree.

First we set the variable name of our input fasta file as follows:
```bash
FASTA="file.fasta"  # The raw fasta file

# And we call the output files as follows:
ALIGNED=${FASTA/.fasta/_align.fasta}  # The aligned fasta file
FILE=${ALIGNED/.fasta/_trimed.fasta}  # The aligned and trimmed fasta file ready for phylogenetic inference
OUTPUT="test1"  # The tree name prefix
```
