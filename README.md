# A brief hands-on introduction about Phylogenetic Inference  
Here you will find a brief introduction on how to get started with phylogenetic analyses. All examples are given for nucleotide sequences, yet once you have gone through every step, you will feel more confortable to try different models and datasets.  
  
## Dependencies and softwares used for:  
- **Sequence visualization**: [AliView](https://ormbunkar.se/aliview/) or a much simpler and faster option [SeaView](http://doua.prabi.fr/software/seaview)  
- **Sequence alignments**: [MAFFT](https://mafft.cbrc.jp/alignment/software/)  
- **Trimming alignment**: [trimAl](http://trimal.cgenomics.org/downloads)  
- **Phylogenetic reconstruction**:[rapidNJ](https://birc.au.dk/software/rapidnj/), [RAxML](https://github.com/stamatak/standard-RAxML), [RAxML-ng](https://github.com/amkozlov/raxml-ng), [IQtree](http://www.iqtree.org/), [MrBayes](https://nbisweden.github.io/MrBayes/)  
- **Tree visualization**: [figTree](http://tree.bio.ed.ac.uk/software/figtree/)  
  
## Before starting, why phylogenetic inference?  
(If you are only interested on the 'how', you can directly go to the [summary](https://github.com/MiguelMSandin/phylogeniesQuickStart#summary) section).  
  
Phylogenetic inference allows the exploration of **evolutionary relationships** among taxa beyond a pure pair-wise comparison. Evolutionary relationships are normally inferred from observed intrinsic properties of a group of organisms such as DNA sequences, protein sequences or morphological traits. When reconstructing evolutionary patterns, we assume common ancestry and a bifurcating history in the diversification of the studied organisms. And the best (or most accepted) way to represent such patterns is the so called **phylogenetic tree**.  
  
## What is a phylogenetic tree?  
The simplest answer is **a hypothesis** on the evolutionary relationships among the studied set of taxa or *phylogenetic species*, understanding *species* as genes, proteins or sepcific morphological traits.  
A phylogenetic tree is a comparative analysis that meassures the **accumulated change** between pairs of *species*, normally meassured in rate of nucleotide substitution and interpreted as evolutionary change. In this sense, the **phylogenetic distance** between two given species is the accumulated horizontal length betweem them, independently of their vertical position in the tree.  
Briefly, the structure of a tree is rather simple. A phylogenetic tree assumes a **bifurcating evolution** in which a given **branch** splits into two branches in one given **node**. Each node and all its descendent taxa correspond to a (monophyletic) **clade**. A node with no further descendents is a terminal node and is frequently called **tip or leave** of the tree, representing the *phylogenetic species*.  
The node gathering all *species* is called the **root** of the tree, and is normally used to give a biological and evolutionary interpretation of the tree beyond a pure relative comparison among the *species*. This node, when present, normally separates the outgroup (or outgroups) and the ingroup (please, see [Step 1](https://github.com/MiguelMSandin/phylogeniesQuickStart#species-selection-step-1) for further details on the root and the outgroups and ingroup).  
  
![Tree structure](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step0_tree_structure.png)  
  
In terms of writing and formating, the simplest tree format is called [newick](https://en.wikipedia.org/wiki/Newick_format), and it is simply a nested grouping of trees, where tips are separated by commas, and groups are grouped by parentheses. The example above would look like as follows (without branch lengths, which are given after the given tip or node separated by a semicolon ":"):  
((a,b),((c,d),(e,f)));
  
## Main steps for phylogenetic reconstruction
[1.](https://github.com/MiguelMSandin/phylogeniesQuickStart#species-selection-step-1) Select your *species*.  (<-- the most important step!)  
[2.](https://github.com/MiguelMSandin/phylogeniesQuickStart#align-step-2) Align sequences.  
[3.](https://github.com/MiguelMSandin/phylogeniesQuickStart#trim-alignment-of-redundant-or-low-informative-positionscolumns-step-3) Remove uninformative positions/columns.  
[4.](https://github.com/MiguelMSandin/phylogeniesQuickStart#phylogenetic-analyses-step-4) Run phylogenetic inference.  
[5.](https://github.com/MiguelMSandin/phylogeniesQuickStart#interpreting-the-tree-step-6) Understand your phylogenetic tree.  (<-- the most important step!)  
6. Come back to step 1, if needed.  
  
The most important steps of phylogenetic inference are the ***species* selection** and the **interpretation of your resulting tree**. Yet, to be able to fully understand a phylogenetic tree, you need to understand how to build it. Here we will quickly go through every step. Yet keep in mind that **each tree is a hypothesis** of your given data, and therefore the selection of your *species*, the phylogenetic inference and the interpretation of the tree will highly rely on your **scientific question**.  
  
## *Species* selection (step 1)
  
As for any other project or analysis, the most important aspect is your **scientific question**. Why do you want to infer a phylogeny? What is the importance of the phylogeny for your study? How other studies will benefit from your phylogeny?  
  
If you have recently sequenced some organisms and you simply want to have a rough idea of what taxonomic identity these sequences have, maybe a [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome) or a pair-wise comparison to reference databases (such as [PR2](https://pr2-database.org/) or [SILVA](https://www.arb-silva.de/)) is more suited to your question.  
  
Anyways, **retrieving closely related sequences or proteins** from public databases might be the first step towards the selection of the *species* to build a phylogenetic tree. Here you are interested in integrating your group of interest in a broader evolutioanry context, either within other biological entities or to explore the relationships within your group of interest. And to do so, you need a good representation of all known diversity.  
Unfortunately, accessing all known diversity is not a straight forward task. **Artifacts**, such as [chimeric](https://en.wikipedia.org/wiki/Chimera_(molecular_biology)) sequences produced during amplification or errors during sequencing, might affect the quality and reliability of the molecular diversity. Therefore, and once again, depending on your scientific question you might tackle this step differently.  

Let's supposed that you have sequenced one organism that have never been sequenced and you want to know its phylogenetic patterns. A quick BLAST will let you know what broad group you are dealing with. Now comes the **literature research**: check previous phylogenetic analysis of the group of interest and try to retrieve similar sequences that have been previoulsy used in other studies. I normally prefer to start from well established sequences and then remove and add more sequences step by step, depending on the given results and my question.  
  
Closely related sequences will allow you accessing the phylogenetic relationships of your group of interest. However, most of the times you will be interested in the broader context of your group of interest and how it relates to other closely related groups. In this sense we need to "order" the tree in an evolutionary sense: we need to **root the tree**.  
  
### What is the Root of the tree?  
  
.  
  
## Basic pipeline  
  
Please, bear in mind that there are many different ways to infer phylogenetic patterns among genes, proteins or even morphological characters (or other traits). So here I will just guide you through a basic step-by-step pipeline that I normally use for quick and exploratory analyses.  
  
Let's name our input and output files as follows:  
```FASTA="file.fasta"```  # The raw fasta file  
```ALIGNED=${INPUT/.fasta/_align.fasta}```  # The aligned fasta file  
```FILE=${ALIGNED/.fasta/_trimed.fasta}```  # The aligned and trimmed fasta file ready for phylogenetic inference  
```OUTPUT="test1"```  
  
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
  
The alignment provides now a basis to meassure differences/similarities among sequences. Although not every difference of nucleotide has the same evolutionary consequence.  
  
The simplest tree is a Neighbor Joining tree, representing the direct distance between the *species*. In this approach, *species* are grouped together based on similarity, until there is no more *species* left.  
   
```rapidnj $FILE > ${OUTPUT}_NJ.tre```  
  
![Step4.1](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step4.1_model_of_evolution.png)  
  
A pairwise comparison between group of *species* gives a first quick look of the alignment and the *species* themselves. However the phylogenetic relatedness is not directly link to the similarity or dissimilarity of the *species*, since not every region of the sequence evolve at the same rate. 
  
In this sense, some columns of the alignment will be prone to be more conservative and others to be more variable. Therefore the same nucleotide change may imply different weight depending on their position in the alignment. Different **models of evolution** assume different parameters resulting in different rates of evolution among the same sequences, and allows comparing not only *species* but also different columns of the alignment.  
  
Despite models of evolution allow the reconstruction of phylogenetic relatedness between *species* beyond a pure similarity comparison, they rely on many assumptions and parameters. Such parameters need to be estimated, adjusted and improved in order to better fit the given dataset. And to do so, several approaches have been proposed:  
  
### Using a Maximum Likelihood approach  
  
Maximum Likelihood (LM) maximizes model parameters accross different replicates (bootstraps) to find a higher likelihood  
  
![Step4.2](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step4.2_ML.png)  
  
We need now new variables:  
  
```THREADS=2``` # Normally 1 thread for every 500-1000bp alignment positions works fine.  
```BS=100```  # The number of Bootstrap  
  
Here you have different softwares. The first example with **RAxML**:  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRgamma -s $FILE -m GTRGAMMA -p $RANDOM -x $(date +%s) -f a -N $BS -T $THREADS```  
  
or faster and very similar output:  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRcat -s $FILE -m GTRCAT -c 25 -p $RANDOM -x $(date +%s) -f a -N $BS -T $THREADS```  
  
With **RAxML-ng** you could use the Graphical User Interface option throught their server: [RAxML-NG](https://raxml-ng.vital-it.ch/#/), or have a look at [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.2_RAxML-ng.sh) for further details through the comand line.  
  
With **IQtree** you can run **modelTest** (you can also do it in [**R**](https://www.r-project.org/), with the packages [*ape*](https://cran.r-project.org/web/packages/ape/index.html) and [*phangorn*](https://cran.r-project.org/web/packages/phangorn/index.html), see [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.5_PhyML_in_R.R) for further details), which is used to select the best model fitting your data:  
  
```MEM=2GB```  
```iqtree -s $FILE -st "DNA" -pre ${OUTPUT}_IQtree -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl```  
  
And if you know the model of evolution to be used you can add it to the command for example with GTR+G+I (which is normally the best choice): ```-m GTR+I+G```  
But again, different options will address better different questions...  
  
### Using a Bayesian approach  
  
Model parameters are randomly estimated accross a statistical distribution resulting in different trees with different likelihood  
  
Posterior Probabilities  
  
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
```mb < phylo_mrBayes.sh > ${OUTPUT}_mrBayesgamma.log &```  
Something to bear in mind is that MrBayes uses "nexus" format and not "fasta". This can be easily exported/transformed in AliView.  
Alternatively, you can type each one of the lines from the script that we called *phylo_mrBayes.sh* directly in the MrBayes prompt (except for the first line, which sets the autoclosing).  
  
### Using a parsimony approach
  
The parsimony approach assumes that two sequences are related to one another if .  
  
## Interpreting the tree (step 6)  
  
This might be the most complicated step, and it is only getting easier with experience and after failing many times. Briefly, from a methodological point of view, you want a tree:  
(1) highly supported,  
(2) with no polytomies or near-0 internal bracnh lengths,  
(3) with no *very long* branches and  
(4) different from your outgroup(s) but not *too* different.  
Understanding that each concept is relative and may vary among different trees.  
  
![Tree structure unresolved](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/step0_tree_structure_unresolved.png)  
  
![Different pictures of the same reality](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/different_pictures_of_the_same_reality.png)  
  
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
and/or using a **Bayesian Inference** approach with MrBayes (you can find an example script here: [phylo_mrBayes.sh](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/scripts/3.4.1_MrBayes_set.sh)):  
```mb < phylo_mrBayes.sh > ${OUTPUT]_mrBayesgamma.log```  
  
**Step 5**. **Interpret your phylogenetic tree**.  
First from a methodological point of view: Are all nodes highly supported? Are there no polytomic nodes? Are there no long branches?  
Then we add the biological thinking: Are the outgroups clearly defined and independent from the ingroup? Are the patterns among clades as previously reported/suggested/expected? Can you explain the tree topology according to the *species* you used (e.g.; rRNA genes, plastids, proteins)? Can you explain the tree in a biological integrative context? For example if using genes/proteins, can you explain it from a morphological or ecological point of view?  
If not, then you should come back to **Step 1**, and think again on the chosen *species* and/or try to use different trimming options according to your scientific question.   
  
## Further reading  
  
The first phylogenetic analysis performed by Carl Woese and George Fox defined the primary domains of life through 16S rRNA characterization ([Woese and Fox, 1977](https://www.pnas.org/doi/full/10.1073/pnas.74.11.5088)). And ever since, **phylogenetic thinking** continued developing. The number of references about phylogenetic analysis and understanding is overwhelming, and therefore providing an exhaustive list is imposible. As a brief example, you can simply check one of the latest and the references therein ([Evans et al., 2021](https://royalsocietypublishing.org/doi/10.1098/rstb.2020.0056)).  
  
Regarding the methodological aspect of phylogenetic reconstruction, you will also find many different options. Yet again, I refer to one of the latest I am aware of and point to the references therein ([Irisarri 2021](https://onlinelibrary.wiley.com/doi/abs/10.1002/9780470015902.a0029211)). Most of the times, open source softwares are very well documented. I highly encourage you to extend your possiblities and go fancy in phylogenetic inference by looking and epxloring different options through the help command (i.e.; ```iqtree -h```, ```raxml-ng -h```), or through their online manuals and hands-on tutorials:
- RAxML (not maintained any more): https://github.com/stamatak/standard-RAxML/blob/master/manual/NewManual.pdf  
- RAxML-NG: https://github.com/amkozlov/raxml-ng/wiki/Tutorial  
- IQtree: http://www.iqtree.org/doc/Quickstart  
- MrBayes: https://github.com/NBISweden/MrBayes/blob/develop/doc/manual/Manual_MrBayes_v3.2.pdf  
- R: ape and phangorn: https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.html  
  
