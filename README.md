# A brief hands-on introduction about Phylogenetic Inference  
Here you will find a brief introduction on how to get started with phylogenetic analyses.
  
## Dependencies and softwares used for:  
- **Sequence visualization**: [AliView](https://ormbunkar.se/aliview/) or a much simpler and faster option [SeaView](http://doua.prabi.fr/software/seaview)  
- **Sequence alignments**: [MAFFT](https://mafft.cbrc.jp/alignment/software/)  
- **Trimming alignment**: [trimAl](http://trimal.cgenomics.org/downloads)  
- **Phylogenetic reconstruction**: [RAxML](https://github.com/stamatak/standard-RAxML), [RAxML-ng](https://github.com/amkozlov/raxml-ng), [IQtree](http://www.iqtree.org/), [MrBayes](https://nbisweden.github.io/MrBayes/)  
- **Tree visualization**: [figTree](http://tree.bio.ed.ac.uk/software/figtree/)  
  
## Before starting, why phylogenetic inference?  
(If you are only interested on the 'how', you can directly go to the [summary](https://github.com/MiguelMSandin/phylogeniesQuickStart#summary) section).  
  
Phylogenetic inference .  
  
## What is a phylogenetic tree?  
The simplest answer is **an hypothesis** on the evolutionary relationships among the studied set of *species*, understanding *species* as genes, proteins or traits.  
  
![Tree structure](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step0_tree_structure.png)  
  
## Main steps 
1. Select your *species*.
2. Align sequences.  
3. Remove uninformative positions/columns.  
4. Run phylogenetic inference.  
5. Understand your phylogenetic tree.
6. Come back to step 1.  
  
The most important steps of phylogenetic inference are the ***species* selection** and the **interpretation of your resulting tree**. Yet, to be able to fully understand a phylogenetic tree, you need to understand and know how to build it. Here we will quickly go through every step. Yet keep in mind that **each tree is an hypothesis** of your given data, and therefore the selection of your *species* and the interpretation of the tree will highly rely on your **scientific question**.  
  
## *Species* selection (step 1)
  
On the Root of the tree.  
  
## Basic pipeline  
  
Please, bear in mind that there are many different ways to infer phylogenetic patterns among genes, proteins or even morphological characters (or other traits). So here I will just guide you through a basic step-by-step pipeline that I normally use for quick and exploratory analyses.  
  
Let's name our input and output files as follows:  
```FASTA="file.fasta"```  # The raw fasta file  
```ALIGNED=${INPUT/.fasta/_align.fasta}```  # The aligned fasta file  
```FILE=${ALIGNED/.fasta/_trimed.fasta}```  # The aligned and trimmed fasta file ready for phylogenetic inference  
  
## Align (step 2)  
  
![Step2 align sequences](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step2_align.png)  
  
Depending on the sequences you are aligning you may want to play with the different options that MAFFT offer. I recommend playing with them and with different datasets (highly similar and highly divergent sequences) to fully understand them.  
  
For large dataset I normally use the default options:  
```mafft $FASTA > $ALIGNED```  
For a small dataset (<200 sequences of similarish length ~2000bp) of specific groups, I normally use  
```mafft --maxiterate 1000 --localpair $FASTA > $ALIGNED```  
  
It is important to manually check the alignment in AliView (or SeaView) if you are working with recently sequenced sequences. There might be some misalignment or weird stuff easy to spot due to bad quality or errors sequencing.  
  
## Trim alignment of redundant or low informative positions/columns (step 3)  
  
![Step3 trim alignment](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step3_trim.png)  
  
We can automatically do that with trimal as follows:  
  
```trimal -in $FASTA -out $FILE -gt X```  
  
Being X the coverage threshold at a given position. I normally use 30% for a quick analysis and 5% for a more resolutive analysis. Again, depending on your scope you will have to play with different options. Other useful options are "```-st```", "```-nogaps```" and "```-noallgaps```".  
Besides, you can also trim the alignment based on the entropy of the columns, based on expected errors, etc.  
  
## Phylogenetic analyses (step 4)  
  
The alignment provides now a basis to meassure differences/similarities among sequences. Although not every difference of nucleotide has the same evolutionary consequence. In this sense, different models of evolution assume different parameters resulting in different rates of evolution among the same sequences.  
![Step4.1](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step4.1_model_of_evolution.png)  
  
### Using a Maximum Likelihood approach  
  
Maximizes model parameters accross different replicates (bootstraps) to find a higher likelihood  
  
![Step4.2](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step4.2_ML.png)  
  
We need now new variables:  
  
```THREADS=2``` # Normally 1 thread for every 500-1000bp alignment positions works fine.  
```BS=100```  # The number of Bootstrap  
  
Here you have different softwares. The first example with **RAxML**:  
```OUTPUT="test1_raxml-GTRgamma"```    
```raxmlHPC-PTHREADS-SSE3 -n $OUTPUT -s $FILE -m GTRGAMMA -p $RANDOM -x $(date +%s) -f a -N $BS -T $THREADS```  
  
or faster and very similar output:  
```OUTPUT="test1_raxml-GTRcat"```    
```raxmlHPC-PTHREADS-SSE3 -n $OUTPUT -s $FILE -m GTRCAT -c 25 -p $RANDOM -x $(date +%s) -f a -N $BS -T $THREADS```  
  
With **RAxML-ng** you could use the Graphical User Interface option throught their server: [RAxML-NG](https://raxml-ng.vital-it.ch/#/), or have a look at [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.2_RAxML-ng.sh) for further details through the comand line.  
  
With **IQtree** you can run **modelTest** (you can also do it in [**R**](https://www.r-project.org/), with the packages [*ape*](https://cran.r-project.org/web/packages/ape/index.html) and [*phangorn*](https://cran.r-project.org/web/packages/phangorn/index.html), see [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.5_PhyML_in_R.R) for further details), which is used to select the best model fitting your data:  
  
```OUTPUT="test1-iqtree"```  
```MEM=2GB```  
```iqtree -s $FILE -st "DNA" -pre $OUTPUT -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl```  
  
And if you know the model of evolution to be used you can add it to the command for example with GTR+G+I (which is normally the best choice): ```-m GTR+I+G```  
But again, different options will address better different questions...  
  
### Using a Bayesian approach  
  
Model parameters are randomly estimated accross a statistical distribution resulting in different trees with different likelihood  
![Step4.3](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step4.3_BI.png)  
  
Bayesian analysis are a bit special, since they need most of the time to be run in different blocks, and therefore needing many different parameters to be set that will influence your analysis. Here you have an example of a script, let's save it as "**phylo_mrBayes.sh**":  
```set autoclose=yes nowarnings=yes```  
```execute FILE.nexus```  
```lset nst=6 rates=gamma```  
```mcmc ngen=10000000 Nruns=3 savebrlens=yes file=OUTPUT_mrBayesgamma```  
```sump```  
```sumt```  
```quit```  
That can be run as follows (considering the previous script is called "phylo_mrBayes.sh"):  
```mb < phylo_mrBayes.sh > OUTPUT_mrBayesgamma.log &```  
Something to bear in mind is that MrBayes uses "nexus" format and not "fasta". This can be easily exported/transformed in AliView.  
Alternatively, you can type each one of the lines from the script that we called *phylo_mrBayes.sh* directly in the MrBayes prompt (except for the first line, which sets the autoclosing).  
  
## Interpreting the tree (step 6)  
  
This might be the most complicated step, and only getting easier with experience and failing. Briefly, you want a tree:  
(1) highly supported,  
(2) with no polytomies or near-0 internal bracnh lengths,  
(3) with no *very long* branches and  
(4) different from your outgroup(s) or root but not *too* different.  
Understanding that each concept is relative and may vary among different trees.  
  
![Tree structure unresolved](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step0_tree_structure_unresolved.png)  
  
## Summary
Something like this will give you a solid phylogeny to start exploring patterns:  
  
**Step 1**. **Select your *species* carefully**, both the ingroup and the outgroup, depending on your **scientifc question**.
  
Set the variables:  
```FASTA="file.fasta"```  
```ALIGNED=${INPUT/.fasta/_align.fasta}```  
```FILE=${ALIGNED/.fasta/_trimed.fasta}```  
```OUTPUT="test1"```  
```THREADS=2```  
```BS=100```  
```MEM="2GB"```  

**Step 2**. Align the sequences:  
```mafft $FASTA > $ALIGNED```  
  
**Step 3**. Manual check of the alignment if unsure of the quality of the sequences before trimming:  
```trimal -in $ALIGNED -out $FILE -gt 05```  
  
**Step 4**. Run a phylogeny using a **Maximum Likelihood** approach:
with RAxML:  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRgamma -s $FILE -m GTRGAMMA -p $RANDOM -x $(date +%s) -f a -N $BS -T 2```  
and/or RAxML-ng:  
```raxml-ng --all --msa $FILE --model GTR+G --tree pars{10} --prefix ${OUTPUT}_raxml-ng-GTRgamma --seed $RANDOM --threads $THREADS --bs-trees $BS```  
and/or IQtree:  
```iqtree -s $FILE -st "DNA" -pre ${OUTPUT}_IQtree-mt -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl```  
and/or using a **Bayesian Inference** appraoch with MrBayes (you can find an example script here: [phylo_mrBayes.sh](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/scripts/3.4.1_MrBayes_set.sh)):  
```mb < phylo_mrBayes.sh > ${OUTPUT]_mrBayesgamma.log```  
  
**Step 5**. **Interpret your phylogenetic tree**.  
First from a methodological point of view: Are all nodes highly supported? Are there no nodes polytomies? Are there no long branches?  
Then we add the biological thinking: Are the outgroups clearly defined and independent from the ingroup? Are the patterns among clades as previously reported/suggested/expected? Can you explain the tree topology according to the *species* you used (e.g.; rRNA genes, plastids, proteins)? Can you explain the tree in a biological integrative context? For example if using genes/proteins, can you explain it from a morphological or ecological point of view?  
If not, then you should come back to **Step 1**, and think again on the chosen *species* and/or try to use different trimming options according to your scientific question.   
  
## Further reading  
  
The first phylogenetic analysis performed by Carl Woese and George Fox defined the primary domains of life through 16S rRNA characterization ((Woese and Fox, 1977)[https://www.pnas.org/doi/full/10.1073/pnas.74.11.5088]). And ever since, **phylogenetic thinking** continued developing. The number of references about phylogenetic analysis and understanding is overwhelming, and therefore providing an exhaustive list is imposible. As a brief example, you can simply check one of the latest and the references therein ((Evans et al., 2021)[https://royalsocietypublishing.org/doi/10.1098/rstb.2020.0056]).  
  
Regarding the methodological aspect of phylogenetic reconstruction, you will also find many different options. Yet again, I refer to one of the latest I am aware of and point to the references therein ((Irisarri 2021)[https://onlinelibrary.wiley.com/doi/abs/10.1002/9780470015902.a0029211]). Most of the times, open source softwares are very well documented. I highly encourage you to extend your possiblities and go fancy in phylogenetic inference by looking and epxloring different options through the help command (i.e.; ```iqtree -h```, ```raxml-ng -h```), or through their online manuals and hands-on tutorials:
- RAxML (not maintained any more): https://github.com/stamatak/standard-RAxML/blob/master/manual/NewManual.pdf  
- RAxML-NG: https://github.com/amkozlov/raxml-ng/wiki/Tutorial  
- IQtree: http://www.iqtree.org/doc/Quickstart  
- MrBayes: https://github.com/NBISweden/MrBayes/blob/develop/doc/manual/Manual_MrBayes_v3.2.pdf  
- R: ape and phangorn: https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.html  
  
