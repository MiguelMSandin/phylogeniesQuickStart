## Summary
  
**Step 1**. **Select your *species* carefully**, both the ingroup and the outgroup, depending on your **scientific question**.
  
Set the variables:  
```bash  
FASTA="file.fasta"  
ALIGNED=${FASTA/.fasta/_align.fasta}  
FILE=${ALIGNED/.fasta/_trimed.fasta}  
OUTPUT="test1"  
THREADS=2  
BS=100  
MEM="2GB"  
```

**Step 2**. Align the sequences:  
```bash  
mafft $FASTA > $ALIGNED
```  
  
**Step 3**. Manual check of the alignment if unsure of the quality of the sequences before trimming:  
```bash  
trimal -in $ALIGNED -out $FILE -gt 05
```  
  
**Step 4**. Run a phylogeny using a **Maximum Likelihood** approach:  
with **RAxML**:  
```bash  
raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRgamma -s $FILE -m GTRGAMMA -p $RANDOM -x $(date +%s) -f a -N $BS -T 2
```  
and/or **RAxML-ng**:  
```bash  
raxml-ng --all --msa $FILE --model GTR+G --tree pars{10} --prefix ${OUTPUT}_raxml-ng-GTRgamma --seed $RANDOM --threads $THREADS --bs-trees $BS
```  
and/or **IQ-TREE**:  
```bash  
iqtree -s $FILE -st "DNA" -pre ${OUTPUT}_IQtree-mt -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl
```  
and/or using a **Bayesian Inference** approach with **MrBayes** (you can find an example script here: [phylo_mrBayes.sh](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/scripts/3.4.1_MrBayes_set.nexus)):  
```bash  
mb < phylo_mrBayes.sh > ${OUTPUT}_mrBayesgamma.log
```  
  
**Step 5**. **Interpret your phylogenetic tree**.  
First from a **methodological point of view**: Are all nodes highly supported? Are there no polytomic nodes? Are there no long branches?  
Then we add the **biological thinking**: Are the outgroups clearly defined and independent from the ingroup? Are the patterns among clades as previously reported/suggested/expected? Can you explain the tree topology according to the *species* you used (e.g.; rRNA genes, plastids, proteins)?  
Lastly we add a **broader context**: can you explain the tree in a biological integrative context? For example if using genes/proteins, can you explain it from a morphological or ecological point of view? What is contributing to the state of the art of your research?  
If not, then you should come back to **Step 1**, think again on the chosen *species*, try different alignment options and/or try to use different trimming options more suited to your scientific question.   
  
