# A brief hands-on introduction about Phylogenetic Inference  
Here you will find a brief introduction on how to get started with phylogenetic analyses.
  
## Dependencies and softwares used for:  
- **Sequence visualization**: [AliView](https://ormbunkar.se/aliview/) or a much simpler and faster option [SeaView](http://doua.prabi.fr/software/seaview)  
- **Sequence alignments**: [MAFFT](https://mafft.cbrc.jp/alignment/software/)  
- **Trimming alignment**: [trimAl](http://trimal.cgenomics.org/downloads)  
- **Phylogenetic reconstruction**: [RAxML](https://github.com/stamatak/standard-RAxML), [RAxML-ng](https://github.com/amkozlov/raxml-ng), [IQtree](http://www.iqtree.org/), [MrBayes](https://nbisweden.github.io/MrBayes/)  
- **Tree visualization**: [figTree](http://tree.bio.ed.ac.uk/software/figtree/)  
  
## Before starting, why phylogenetic inference?  
(If you are only interested on the 'how', you can directly go to the [Basic pipeline](https://github.com/MiguelMSandin/phylogeniesQuickStart#basic-command-line-pipeline) section).  
  
## What is a phylogenetic tree?  
  
## Basic command line pipeline  
  
Please, bear in mind that there are many different ways to infer phylogenetic patterns among genes, proteins or even morphological characters. So here I will just guide you through a basic step-by-step pipeline that I normally use for quick and exploratory analyses.  
  
### Align  
Depending on the sequences you are aligning you may want to play with the options. I recommend playing with them and with different datasets (highly similar or highly divergent sequences) to fully understand them.
For large dataset I normally use the default options:  
```mafft FILE.fasta > FILE_align.fasta```  
For a small dataset (<200 sequences of similarish length ~2000bp) of specific groups, I normally use  
```mafft --maxiterate 1000 --localpair FILE.fasta > FILE_align.fasta```  
  
It is important to manually check the alignment in AliView (or SeaView) if you are working with recently sequenced sequences. There might be some misalignment or weird stuff easy to spot due to bad quality or errors sequencing.  
  
### Trim alignment of redundant or low informative positions (columns)  
```trimal -in FILE_align.fasta -out FILE_align_trimX.fasta -gt X```  
Being X the coverage threshold at given position. I normally use 30% for a quick analysis and 5% for a more resolutive analysis. Again, depending on your scope you will have to play with different options. Other useful options are "```-st```", "```-nogaps```" and "```-noallgaps```".  
  
### Phylogenetic analyses with Maximum Likelihood  
Here you have different softwares. The first example with **RAxML**:  
```THREADS=X # Being X the preferred number of threads. Normally 1 thread for every 500-1000bp alignment positions works fine.  ```
```BS=100```  
```raxmlHPC-PTHREADS-SSE3 -T $THREADS -m GTRGAMMA -p $RANDOM -x $(date +%s) -d -f a -N $BS -n FILE_align_trimX.fasta -s FILE_align_trim_GTRgamma_100BS.fasta```  
or faster and very similar output:  
```raxmlHPC-PTHREADS-SSE3 -T $THREADS -m GTRCAT -c 25 -p $RANDOM -x $(date +%s) -d -f a -N $BS -n FILE_align_trimX.fasta -s FILE_align_trim_CAT_100BS.fasta```  
  
With **RAxML-ng** you could use the Graphical User Interface option throught their server: [RAxML-NG](https://raxml-ng.vital-it.ch/#/), or have a look at [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.2_RAxML-ng.sh) for further details through the comand line.  
  
With **IQtree** you can run **modelTest** (you can also do it in [**R**](https://www.r-project.org/), with the packages [*ape*](https://cran.r-project.org/web/packages/ape/index.html) and [*phangorn*](https://cran.r-project.org/web/packages/phangorn/index.html), see [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.5_PhyML_in_R.R) for further details), which is used to select the best model fitting your data:  
```THREADS=2```  
```BS=100```  
```MEM=2GB```  
```iqtree -s FILE_align_trimX.fasta -st "DNA" -pre FILE_align_trim_IQtree_mt -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl```  
And if you know the model of evolution to be used you can add it to the command for example with GTR+G+I (which is normally the best choice): ```-m GTR+I+G```  
But again, different options will address better different questions...  
  
### Phylogenetic analyses with Bayesian inference  
Bayesian analysis are a bit special, since they need most of the time to be run in different blocks, and therefore needing many different parameters to be set that will influence your analysis. Here you have an example of a script, let's save it as "**phylo_mrBayes.sh**":  
```set autoclose=yes nowarnings=yes```  
```execute FILE_align_trimX.nexus```  
```lset nst=6 rates=gamma```  
```mcmc ngen=10000000 Nruns=3 savebrlens=yes file=FILE_align_trimX_mrBayesgamma```  
```sump```  
```sumt```  
```quit```  
That can be run as follows (considering the previous script is called "phylo_mrBayes.sh"):  
```mb < phylo_mrBayes.sh > FILE_align_trimX_mrBayesgamma.log &```  
Something to bear in mind is that MrBayes uses "nexus" format and not "fasta". This can be easily exported/transformed in AliView.  
Alternatively, you can type each one of the lines from the script that we called *phylo_mrBayes.sh* directly in the MrBayes prompt (except for the first line, which sets the autoclosing).  
  
## Summary
Something like this will give you a solid phylogeny to start exploring patterns:  
```mafft FILE > FILE_align.fasta```  
```# Manual check of the alignment if unsure of the quality of the sequences```  
```trimal -in FILE_align.fasta -out FILE_align_trim05.fasta -gt 05```  
```raxmlHPC-PTHREADS-SSE3 -T 2 -m GTRGAMMA -p $RANDOM -x $(date +%s) -d -f a -N 100 -n FILE_align_trim05.fasta -s FILE_align_trim_GTRgamma_100BS.fasta```  
and/or  
```raxml-ng --all --msa FILE_align_trim05.fasta --model GTR+G --tree pars{10} --prefix FILE_align_trim05_raxml-ng --seed $RANDOM --threads 2 --bs-trees 100```  
and/or  
```iqtree -s FILE_align_trim05.fasta -st "DNA" -pre FILE_align_trim05_IQtree_mt -b 100 -seed $(date +%s) -mem 2GB -nt 4 -wbtl```  
and/or  
```mb < phylo_mrBayes.sh > FILE_align_trimX_mrBayesgamma.log```  
  
## Further reading  
Most of the times, open source softwares are very well documented. I highly encourage you to extend your possiblities and go fancy in phylogenetic inference by looking and epxloring different options through the help command (i.e.; ```iqtree -h```, ```raxml-ng -h```), or through their online manuals and hands-on tutorials:
- RAxML (not maintained any more): https://github.com/stamatak/standard-RAxML/blob/master/manual/NewManual.pdf  
- RAxML-NG: https://github.com/amkozlov/raxml-ng/wiki/Tutorial  
- IQtree: http://www.iqtree.org/doc/Quickstart  
- MrBayes: https://github.com/NBISweden/MrBayes/blob/develop/doc/manual/Manual_MrBayes_v3.2.pdf  
- R: ape and phangorn: https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.html  
  
