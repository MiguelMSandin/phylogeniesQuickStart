# A brief hands-on introduction on molecular phylogenetic studies  
Here you will find a brief introduction on how to get started with phylogenetic analyses. All examples are given for nucleotide sequences, yet once you have gone through every step, you will feel more confortable to try different models and datasets.  
  
Bear in mind that this is a quick practical guide for phylogenetic inferenceo of nucleotide sequences. I tried to explain only important or crucial concepts for a non-expert audience, so these lines are far from exhaustive and very simplified.  
  
For a rendered version of this readme, have a look at the book at: [https://MiguelMSandin.github.io/phylogeniesQuickStart/](https://MiguelMSandin.github.io/phylogeniesQuickStart/)  
  
## Dependencies and softwares used for:  
- **Sequence visualization**: [AliView](https://ormbunkar.se/aliview/) or a much simpler and faster option [SeaView](http://doua.prabi.fr/software/seaview)  
- **Sequence alignments**: [MAFFT](https://mafft.cbrc.jp/alignment/software/)  
- **Trimming alignment**: [trimAl](http://trimal.cgenomics.org/downloads)  
- **Phylogenetic reconstruction**:[rapidNJ](https://birc.au.dk/software/rapidnj/), [RAxML](https://github.com/stamatak/standard-RAxML), [RAxML-ng](https://github.com/amkozlov/raxml-ng), [IQ-TREE](http://www.iqtree.org/), [MrBayes](https://nbisweden.github.io/MrBayes/)  
- **Tree visualization**: [figTree](http://tree.bio.ed.ac.uk/software/figtree/)  
  
## Before starting, why phylogenetic inference?  
(If you are only interested on the 'how', you can directly go to the [summary](https://github.com/MiguelMSandin/phylogeniesQuickStart#summary) section).  
  
Phylogenetic inference allows the exploration of **evolutionary relationships** among taxa beyond a pure pair-wise comparison of their differences.  
Evolutionary relationships are normally inferred from observed intrinsic properties of a group of organisms such as DNA sequences, protein sequences or morphological traits.  
The first molecular phylogenetic analysis was performed by Carl Woese and George Fox ([Woese and Fox, 1977](https://www.pnas.org/doi/full/10.1073/pnas.74.11.5088)). They defined the primary domains of life through 16S rRNA characterization. They provided a simple matrix of pairwise comparisons among DNA sequences, yet opened the doors for a much complex field of molecular evolution.  
Now a days, when reconstructing evolutionary patterns, we assume common ancestry and a dichotomic diversification of the studied organisms. And the best (or most accepted) way to represent such patterns is the so called **phylogenetic tree**.  
  
## What is a phylogenetic tree?  
The simplest answer is **a hypothesis** on the evolutionary relationships among the studied set of taxa or *phylogenetic species*, understanding such *species* as genes, proteins or specific morphological traits.  
  
A phylogenetic tree represents a comparative analysis that meassures the **accumulated change** between pairs of *species*, normally meassured in rate of nucleotide substitution and interpreted as evolutionary change. In this sense, the **phylogenetic distance** between two given species is the accumulated horizontal length betweem them, independently of their vertical position in the tree.  
  
Briefly, the structure of a tree is rather simple. A phylogenetic tree assumes a **bifurcating diversification** in which a given **branch** splits into two branches in one given **node**. Each node and all its descendent taxa correspond to a (monophyletic) **clade**. A node with no further descendents is a terminal node and is frequently called **tip or leaf** of the tree, representing the *phylogenetic species*.  
  
The node gathering all *species* is called the **root** of the tree, and is normally used to give a biological and evolutionary interpretation of the tree beyond a pure relative comparison among the *species*. This node, when present, corresponds to the last common ancestor of all *species* considered in the tree.  
  
![Tree structure](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure1_tree_structure.png)  
  
In terms of formating, the simplest tree format is called [newick](https://en.wikipedia.org/wiki/Newick_format), and it is simply a nested grouping of trees, where tips are separated by commas, and nodes are grouped by parentheses. The example above would look like as follows:  
((a,b),((c,d),(e,f)));  
Note the semicolon (";") terminating the tree.  
Branch lengths (or the accumulated change) are provided after the given tip or node separated by a colon (":"), as follows:  
((a:1,b:1),((c:1,d:1),(e:1,f:1)));  
And finally, it is possible to add names to the nodes by simply including such names after the given node, as follows:
((a:1,b:1),((c:1,d:1),(e:1,f:1)sub-clade)clade);  
  
---
  
## Main steps for phylogenetic reconstruction
[1.](https://github.com/MiguelMSandin/phylogeniesQuickStart#species-selection-step-1) Select your *species*.  (<-- the most important step!)  
[2.](https://github.com/MiguelMSandin/phylogeniesQuickStart#align-step-2) Align sequences.  
[3.](https://github.com/MiguelMSandin/phylogeniesQuickStart#trim-alignment-of-redundant-or-low-informative-positionscolumns-step-3) Remove uninformative positions/columns.  
[4.](https://github.com/MiguelMSandin/phylogeniesQuickStart#phylogenetic-analyses-step-4) Run phylogenetic inference.  
[5.](https://github.com/MiguelMSandin/phylogeniesQuickStart#interpreting-the-tree-step-6) Understand your phylogenetic tree.  (<-- the most important step!)  
6. Come back to step 1, if needed.  
  
The most important steps of phylogenetic inference are the ***species* selection** and the **interpretation of your resulting tree**. Yet, to be able to fully understand a phylogenetic tree, you need to understand how to build it. Here we will quickly go through every step. Yet keep in mind that **each tree is a hypothesis** of your given data, and therefore the selection of your *species*, the phylogenetic inference and the interpretation of the tree will highly rely on your **scientific question**.  
  
---
  
## *Species* selection (step 1)
  
As for any other project or analysis, the most important aspect is your **scientific question**. Why do you want to infer a phylogeny? What is the importance of the phylogeny for your study? How other studies will benefit from your phylogeny?  
  
If you have recently sequenced some organisms and you simply want to have a rough idea of what taxonomic identity these sequences belong to, maybe a [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome) or a pair-wise comparison to reference databases (such as [PR2](https://pr2-database.org/) or [SILVA](https://www.arb-silva.de/)) is more suited to your question.  
  
Anyways, **retrieving closely related sequences or proteins** from public databases might be the first step towards the selection of the *species* that will be included in the phylogenetic tree. Here you are interested in integrating your group of interest in a broader evolutionary context, either within other groups or to explore the relationships within your group of interest. And to do so, you need a good representation of all known diversity.  
  
Unfortunately, accessing all known diversity is not a straight forward task. **Artefacts**, such as [chimeric sequences](https://en.wikipedia.org/wiki/Chimera_(molecular_biology)) produced during amplification or errors during amplification or sequencing, might affect the quality and reliability of the molecular diversity. Therefore, and once again, depending on your scientific question you might tackle this step differently.  

Let's suppose that you have sequenced one organism that have never been sequenced and you want to know its phylogenetic patterns. A quick BLAST will let you know what broad group you are dealing with. Now comes the **literature research**: check previous phylogenetic analysis of the group of interest and try to retrieve similar sequences that have been previoulsy used in other studies and complement with newly available sequences.  
I normally prefer to start from few and well established sequences of my group of interest and then remove and add more sequences in consecutive phylogenetic runs, depending on the given results and my question.  
  
Closely related sequences will allow you accessing the phylogenetic relationships of your group of interest. Yet, to infer an evolutionary history and get a broader context of your group of interest it is needed to "order" the tree in an evolutionary sense: we need to **root the tree**.  
  
### What is the root of the tree?  
  
The root of the tree represents the **last common ancestor** of all *species* in the tree. It tells you what are the earliest diverging nodes and therefore the "direction" of the evolution.  
  
In the example below, you have the exact same tree rooted (right) and unrooted (left). In this example the root is splitting the first diverging clade (gathering "a" and "b") and the rest of the taxa.  
  
 ![Unrooted and rooted tree](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure2_tree_root.png)   
  
When it comes to real data, you might be interested in the closest relatives of your group of interest (or **outgroup**) that are not your group of interest (or **ingroup**). For example if your group of interest are birds, then you might want to choose an outgroup within reptiles.  
  
And if you are unsure of the quality or nature of your sequences, chosing more than one outgroup is very important to quickly spot artefacts or alignment problems.  
  
Chosing a correct outgroup(s) is as important as chosing the correct *species* for your ingroup. However, many times it is simply not possible to choose, because of (for example) lack of ressolved phylogenetic patterns, so you will have to take a decission among different options.  
  
---
  
## Basic pipeline  
  
> Please, bear in mind that there are many different ways to infer phylogenetic patterns among genes, proteins or even morphological characters (or other traits). Here I will just guide you through a basic step-by-step pipeline that I normally use for quick and exploratory analyses of DNA sequences.  
  
We have already selected our *species* (both ingroup and outgroup or outgroups), let's build now a phylogenetic tree.  
  
First we set the variable name of our input fasta file as follows:  
```FASTA="file.fasta"```  # The raw fasta file  
And we call the output files as follows:  
```ALIGNED=${INPUT/.fasta/_align.fasta}```  # The aligned fasta file  
```FILE=${ALIGNED/.fasta/_trimed.fasta}```  # The aligned and trimmed fasta file ready for phylogenetic inference  
```OUTPUT="test1"```  # The basic tree name  
  
---
  
## Align (step 2)  
  
Different genes evolve at different rates, and so does different regions of the gene. Therefore, we have to make the sequences comparable to one another so we can actually estimate divergence from different regions of different sequences that share a functional or structural role. And to do so, we have to **align** the sequences.  
  
![Step2 align sequences](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure3_step2_align.png)  
  
For example using **MAFFT**, for large dataset I normally use the default options:  
```mafft $FASTA > $ALIGNED```  
For a small dataset (<200 sequences) of different groups, I normally use:  
```mafft --maxiterate 1000 --localpair $FASTA > $ALIGNED```  
And for a small dataset (<200 sequences of similarish length) of closely related group, I normally use:  
```mafft --maxiterate 1000 --globalpair $FASTA > $ALIGNED```  
  
Depending on the sequences you are aligning you may want to play with the different options that MAFFT offer. I recommend playing with them and with different datasets (highly similar and highly divergent sequences) to fully understand them.  
  
It is important to manually check the alignment in AliView (or SeaView) if you are working with recently sequenced sequences or of doubted origin. There might be some misalignment or weird stuff easy to spot due to bad quality or errors sequencing.  
  
Other softwares offer other possibilities, for example [muscle](http://www.drive5.com/muscle/) (very useful for proteins) stores ambiguities or alignment errors for downstream analysis, and [clustal](http://www.clustal.org/omega/) uses a [HMM profile](https://www.ebi.ac.uk/training/online/courses/pfam-creating-protein-families/what-are-profile-hidden-markov-models-hmms) to generate the alignment. Further posibilities can be found at the [EMBL-EBI](https://www.ebi.ac.uk/Tools/msa/).  
  
It is also possible (yet requires experience) to align the sequences based on complementary regions of the hypothetical 2D structure of the given coding gene or rDNA (if known).  
  
---
  
## Trim alignment of redundant or low informative positions/columns (step 3)  
  
In this step we want to remove position that might be irrelevant, add noise, with very little information or even uninformative.  
  
![Step3 trim alignment](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure4_step3_trim.png)  
  
We can automatically do that with **trimAl** as follows:  
  
```trimal -in $ALIGNED -out $FILE -gt X```  
  
Being X the coverage threshold at a given position. I normally use 30% for a quick analysis and 5% for a more resolutive analysis. Again, depending on your scope you will have to play with different options. Other useful options are "```-st```" (removing positions above certain dissimilarity threshold), "```-nogaps```" (removing all positions with gaps) and "```-noallgaps```" (removing only positions composed only by gaps).  
  
Other sofwares highly used are [Gblocks](http://molevol.cmima.csic.es/castresana/Gblocks.html), [ClipKIT](https://github.com/JLSteenwyk/ClipKIT) (which also estimates and keeps parsimonious sites), [Noisy](http://www.bioinf.uni-leipzig.de/Software/noisy/) (able to predict and remove homoplastic sites) or [BMGE](http://gensoft.pasteur.fr/docs/BMGE/1.12/BMGE_doc.pdf) (removing sites that are highly variable/entropic).  
  
---
  
## Phylogenetic analyses (step 4)  
  
The alignment provides now a basis to meassure differences/similarities among sequences. A pairwise comparison between group of *species* gives a first quick look of the alignment and the *species* themselves.  
Yet, the phylogenetic relatedness is not directly link to the similarity or dissimilarity of the *species*, since not every difference of nucleotide has the same evolutionary consequence. Besides, some columns of the alignment will be prone to be more conservative and others to be more variable. Therefore the same nucleotide change may imply different weight depending on their position in the alignment. Different [**models of evolution**](https://en.wikipedia.org/wiki/Models_of_DNA_evolution) assume different parameters resulting in different rates of evolution among the same sequences, and allows comparing not only *species* but also different columns of the alignment.  
  
The simplest tree is a **Neighbor Joining** tree, where *species* are grouped together based on similarity, until there is no more *species* left. And the simplest model of evolution is the so-called **Jukes-Cantor** model ([Jukes and Cantor, 1969](https://doi.org/10.1016/B978-1-4832-3211-9.50009-7)) assuming equal base frequencies and equal mutation rates. In a slightly more complex model, **Motoo Kimura** included two more parmeters for the different implications of [transitions](https://en.wikipedia.org/wiki/Transition_(genetics)) and [transverions](https://en.wikipedia.org/wiki/Transversion) in the evolutionary rate ([Kimura, 1980](https://link.springer.com/article/10.1007/BF01731581)).  
   
```rapidnj $FILE > ${OUTPUT}_NJ.tre```  
  
![Step4.1](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure5_step4.1_model_of_evolution.png)  
  
More complex models of evolution rely on many assumptions and parameters that need to be estimated, adjusted and improved in order to better fit the given dataset. Such fit is normally measssured by the **likelihood** (or more precissely the logarithmic of the likelihood) and in essence it tells you the probability to observe your data given the model. In the case of phylogenetic inference, we can translate this definition as how well your tree (or model and its parameters) explains your sequence alignment (or data). And to find the highest possible likelihood, several approaches have been proposed:  
  
### Using a Maximum Likelihood (ML) approach  
  
Maximum Likelihood ([Felsenstein, 1981](https://link.springer.com/article/10.1007/BF01734359)) maximizes model parameters (treated as constants) accross different [bootstraps](https://en.wikipedia.org/wiki/Bootstrapping_(statistics)) (or "replicates") to find a higher likelihood.  
  
At the end, all the different replicates can be summarized into a **consensus** tree **or** simply take the **best likelihood scoring** tree. Either way, nodes can be annotated on the basis of how many times this given node have appeared accross the different bootstraps, which is refer to as the **bootstrap support** (from 1 to 100).  
  
![Step4.2](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure6_step4.2_ML.png)  
  
We need now new variables:  
  
```THREADS=2``` # Normally 1 thread for every 500-1000bp alignment positions works fine.  
```BS=100```  # The number of Bootstraps  
  
Here you have different softwares:  
  
The first example with **RAxML**:  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRgamma -s $FILE -m GTRGAMMA -p $RANDOM -x $(date +%s) -f a -N $BS -T $THREADS```  
  
or faster model and most of the times very similar output:  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRcat -s $FILE -m GTRCAT -c 25 -p $RANDOM -x $(date +%s) -f a -N $BS -T $THREADS```  
  
With **RAxML-ng** you could use the Graphical User Interface option throught their server: [RAxML-NG](https://raxml-ng.vital-it.ch/#/), or have a look at [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.2_RAxML-ng.sh) for further details through the comand line.  
  
With **IQ-TREE** you can run **modelTest**, which is used to select the best substitution model fitting your data:  
  
```MEM=2GB```  
```iqtree -s $FILE -st "DNA" -pre ${OUTPUT}_IQtree -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl```  
  
And if you know the model of evolution to be used you can add it to the command. Most of the times, the best model is the Generalised Time Reversible model (Tabaré, 1986; *Lectures Math. Life Sci* 17:2,57-86) with a Gamma distribution and proportion of Invariant sites for rate hetereogenity (GTR+G+I, but it also is the most complex model): ```-m GTR+I+G```  
  
ModelTest can also be run in [**R**](https://www.r-project.org/), with the packages [*ape*](https://cran.r-project.org/web/packages/ape/index.html) and [*phangorn*](https://cran.r-project.org/web/packages/phangorn/index.html) (see [this script](https://github.com/MiguelMSandin/phylogeniesKickStart/blob/main/scripts/3.5_PhyML_in_R.R) for further details).  
  
Once again, different options will address better different questions...  
  
It is important to check the **log** file reporting the different analytical steps. Here you check the likelihood of the tree over the different bootstraps, the model parameters optimization or the proportion of invariant sites in the alignment. Basically, you check that there is indeed an improvement and that the alignment is actually informative.  
  
### Using a Bayesian Inference (BI) approach  
  
Bayesian Inference ([Rannala and Yang, 1996](https://link.springer.com/article/10.1007/BF02338839); [Yang and Rannala, 1997](https://academic.oup.com/mbe/article/14/7/717/1119795)) randomly estimates the model parameters accross a statistical distribution resulting in different trees. The likelihood of the trees are computed *a posteriori* (actually they are approximated by [Markov Chain Monte Carlo](https://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo) -MCMC- methods) resulting in **posterior probabilities**, which can be understood as the probability of a tree being right given the randomly selected model parameters.  
  
[Bayesian Inference](https://en.wikipedia.org/wiki/Bayesian_inference) collectes information along the way to update and improve the model parameters. A single inference will most likely yield a rather poor tree, since the search for model parameters is predefined or random (to an extent). Yet in the following **cycles** (sometimes also called iterations, generations or even chains) model parameters are going to be adjusted based on previously collected information resulting in trees with higher and higher likelihood. In this sense, the number of generations will affect the random sampling, and therefore your results.  
It is recommended to monitor the likelihood per cycle to be sure that your model optimization is arriving to a **convergence**. Normally, a safe option is to opt for a very long chain, but an excessively long chain might result in a waste of computational resources. If you are interested in a trade-off between ensuring convergence and not spending several days, weeks or months in a redundant analysis you can explore the [Effective Sample Size](https://beast.community/ess_tutorial) of the MCMC run in the software [Tracer](https://beast.community/tracer).  
Because of the long sampling, when you choose a Bayesian approach it is very important to check the likelihood over the different cycles and remove the "learning slope", normally referred to as **burn-in**.  
  
![Step4.3](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure7_step4.3_BI.png)  
  
Bayesian approaches are available inmany different softwares. Such as [MrBayes](https://nbisweden.github.io/MrBayes/), [BEAST](https://beast.community/), [BEAST2](https://www.beast2.org/) or [PhyloBayes](http://www.atgc-montpellier.fr/phylobayes/). Yet, they need most of the times to be run in different blocks, where different parameters need to be set that will influence your analysis. Instead of running them from a single command, as we did for ML approaches, here we save all our options in a simple text (or xml) file and we run the file within the BI software.  
  
Here you have an example of a script to be run using **MrBayes**, let's save it as "**phylo_mrBayes.sh**":  
```set autoclose=yes nowarnings=yes```  
```execute FILE.nexus```  
```lset nst=6 rates=gamma```  
```mcmc ngen=10000000 Nruns=3 savebrlens=yes file=OUTPUT_mrBayesgamma```  
```sump```  
```sumt```  
```quit```  
>#The mcmc command assumes a burnin of 25%: ```relburnin=yes``` and ```burninfrac=0.25```  
  
That can be run as follows:  
```mb < phylo_mrBayes.sh > ${OUTPUT}_mrBayesgamma.log &```  
  
> Something to bear in mind is that MrBayes uses "nexus" format and not "fasta". This can be easily exported/transformed in AliView.  
  
Alternatively, you can type each one of the lines from the script that we called *phylo_mrBayes.sh* directly in the MrBayes prompt (except for the first line, which sets the autoclosing).  
  
And in this script ([phylo_BEAST.xml](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/scripts/3.4.3_phylo_BEAST.xml)) you can find an example of a **BEAST** xml file in its most simple format (don't panic! such xml file can be created through the graphical user interface package [BEAUti](https://beast.community/beauti)), that can be run as follows:  
  
```beast -seed $RANDOM -beagle_SSE phylo_BEAST.xml```  
And now we have to summarise the chain with [treeannotator](https://beast.community/treeannotator):  
```treeannotator -burnin 1000000 -heights median OUTPUT.trees OUTPUT_mcmc.tre```   
  
The main problem (or advantage, depends on your question) is that BEAST assumes a clock model. But the [molecular clock](https://en.wikipedia.org/wiki/Molecular_clock) concept is getting out of scope. If you are very interested, please have a look at this excellent practical guide to molecular dating published by [Hervé Sauquet (2013)](https://www.sciencedirect.com/science/article/pii/S1631068313001097), and if you already have a solid tree, you can have a look at [MCMCTree](http://abacus.gene.ucl.ac.uk/software/MCMCtree.Tutorials.pdf) from the [PAML](http://abacus.gene.ucl.ac.uk/software/paml.html) package.  
  
### Using a parsimony approach
  
The parsimony approach assumes that the minimum number of changes best explains phylogenetic relatedness. Due to the big simplification of the incredibly complex process that is evolution, this approach has been heavily critized and almost abandon. However I believe it is still very usefull to understand and know it exists since parsimony yields very good results when used as starting tree for both ML and BI approaches. Indeed, raxml-ng implements in its pipeline the use of parsimony to estimate the initial tree.  
We can quickly have a look at a parsimonious tree as follows with **RAxML**:  
  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-parsimony-GTRgamma -s $FILE -y -m GTRGAMMA -p```    
  
Besides, as you might have figured out by now, your scientific question is the most important part when it comes to take decission on the methdological approach. In this context, ML and BI yields very good results for complex DNA or protein sequences. But when it comes to **ancestral state reconstruction** of non-neutral traits, such as habitat or specific morphological traits, the simplification of parsimonious approaches seems to result in more plausible hypothesis ([Holland et al. 2020](https://www.nature.com/articles/s41598-020-64647-4)). It is important to understand that most of the times such analyses are performed over an already inferred phylogenetic tree, and therefore the analyses is no longer about phylogenetic inferring (but about ancestral state reconstruction). In this context, other softwares (such as [Mesquite](https://www.mesquiteproject.org/) or [TNT](http://gensoft.pasteur.fr/docs/TNT/1.5/)) and approches (such as [Maximum Parsimony](https://en.wikipedia.org/wiki/Maximum_parsimony_(phylogenetics))) have been developed. My experience in this area is very limited and I do not feel confortable explaining them. Besides, as pointed out by [Holland et al. (2020)](https://www.nature.com/articles/s41598-020-64647-4), ancestral state reconstruction analyses should be considered and evaluated carefully.  

My take-home message of parsimony approaches is simply that you are aware they exist and that you might be interested in exploring them further according to your question.  
  
### Combining different approaches. 
  
When the phylogenetic inference is the core of your study, it is highly recommended to **replicate the phylogenetic tree with different approaches**. This is most commonly achieved by combining the support from different trees obtained by independent runs of maximum likelihood **and** bayesian approaches.  
Although not always it is possible to apply different approaches to the same dataset, for example for very large datasets a bayesian inference might fail to converge; or when estimating molecular ages a bayesian approach is much better suited since allows uncertainty in the priors.  
Other options could be to: (i) use different softwares (RAxML-ng vs. IQ-TREE), (ii) apply different models of evolution (GTR vs. CAT), (iii) or even to replicate the alignment with different softwares, options or reversing the sequences before aligning.  
  
---
  
## Interpreting the tree (step 5)  
  
This might be the most complicated step, and it is only getting easier with experience and after failing many times. We have to remember that the phylogentic tree that we have just inferred in the previous step is **a hypothesis** of the data (and model) we used, and we should always be critical to our initial hypothesis and our methods.  
  
Briefly, you are inferring a phylogenetic tree because it is **a mean to answer your scientific question**. In this sense, you have several interconnected layers to pay attention to. Firstly you want to check if you have correctly built the tree in a pure methodological point of view. Then you want to understand how the tree explains your data within your study, or in other words the results of the tree. And lastly you are interested in discussing the tree in a broader evolutionary context.  
  
### Interpreting the tree from a methodological point of view
  
At this stage you are looking for artefacts, sequences badly aligned (or even in the reverse order), an appropriate trimming threshold that fits to your sequences, enough number of bootstraps/generations, ... Briefly, your tree should have:  
- highly supported nodes,  
- no polytomies or no near-0 internal branch lengths,  
- no *very long* branches and  
- the ingroup different from your outgroup(s), but not *too* different.  
Understanding that each concept is relative and may vary among different trees.  
  
Simplifying long explanations:
- Low support in the nodes or near-0 branch lengths (or even **polytomies**) could be because the *species* are too similar to each other and the model fails to converge. It could also be that such similarity might have been created because of too strict trimming thresholds of the alignment. (**Example 1**)  
- Very **long branches** could reflect the opposite problem, in which we have simply selected very distinct *species*, the quality of the *species* is bad (with many errors or insertions), the alignment failed or even that the trimming was too gentle. (**Example 2**)  
- If the outgroup and the ingroup appear very distant from one another you might have selected the wrong outgroup. Check the literature again and try to select a more related group as an outgroup or try [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome) to retrieve closely related sequences (if aplicable). (**Example 3**)  
- It could also happen that the different outgroups appear not according to the literature and some clades of the ingroup within or between the different outgroups. Then, most likely **[chimeric sequences](https://en.wikipedia.org/wiki/Chimera_(molecular_biology))** might be present. Chimeric sequences also tend to appear alone at early diverging positions and sometimes at relatively long branches. (**Example 4**)  

![examples_1-4](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure8_examples_1-4.png)  
  
Long branches deserve a special mention when (for example) you have several clades present in independent long branches and are *a priori* phylogenetically related (sister groups). This effect could be due to the so called **Long Branch Attraction** artefact, and the tree shows two groups closely related but simply because they are very different from all the rest and not necessarily because they are similar (or related) to one another.  
  
When chimeric sequences come from very different parent sequences, it might be easy to spot, since all the topology of the tree might be affected. Specially when using several outgroups. But when the chimera is form from closely related groups might be problematic to identify. Most of the softwares that perform chimeric detection (such as [mothur](https://mothur.org/) or [vsearch](https://github.com/torognes/vsearch)) rely on the reference database of choice, so you have to be cautious when providing the reference database.  
    
The different topological possibilities of a tree are very big, and therefore any list of possible methodological problems will be far from complete. I hope with the few examples I am providing, you get the rational to identify methodological issues.  
  
### Interpreting the tree from a biological point of view
  
A pure methodological examination of a tree is very important to help you identify problematic steps on the pipeline. However a biological interpretation of your tree goes tightly connected. Understanding the tree from a biological point of view helps to resolve or neglect potential issues identified from a pure methodological point of view and eventually, it will contribute to decide on whether keeping or removing certain *species*.  
For example:  
- As we have seen in the methodological check, near-0 internal branchelengths or poorly supported nodes might be a problem. But if you find highly supported clades and only few unressolved internal nodes with very short branches, the problem might be intrinsic to the *species* and simply phylogenetic patterns can't be ressolved with the given data. We normally interpret such events in terms of evolution as that "the diversification happened very fast". (**Example 5**).  
- Similarly, long branches can have a biological meaning despite a correct methodological approach. The **rate of evolution** among eukaryotes varies widely from clade to clade. In this sense one specific clade with a very diverging trait can appear in a long branch, highly supported within it, but very poorly resolved regarding its position in the tree. In this case, resolving it's phylogenetic relationship among other groups is not possible with the given data. The best option would be to choose a different trait (if possible) and discuss the different approaches. (**Example 6**).  
- A very common source of conflict is the presence of contaminations or mislabeled sequences. The true information for phylogenetic analysis is the actual gene or protein sequence. Yet the name of such sequence (either taxonomical, environmental or other associated metadata) is an identifier for human readability. Therefore the identifier should we treated with coution and interpreted according to your scope and methodological analyses regardless of its origin. (**Example 7**).  
- When combining different genes or proteins (aslo called as concatenation) it might happen that they show different phylogenetic patterns. In this case it is important to understand the nature of those genes or proteins and discuss the results accordingly. They might have different evolutionary rates, different selection pressure, different phylogenetic information or even different lengths regarding the rest of the sequences in the alignment or being badly annotated. (**Example 8**).  
- ...   
  
![examples_5-8](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure9_examples_5-8.png)  
  
#### What is a "well-supported" clade?  
  
Identifying well defined clades is a difficult task and there are no universal thresholds to define such a thing.  
For example: when using only one or two genes, if a clade has >90% bootstrap or >0.9 posterior probabilities you can be very confident of the support of that clade. On the contrary, if a clade has <60% BS or <0.6%, that specific clade might be close to random selection. When using multiple concatenation of genes, these threshold could increase considerably, and not relying on a clade that has 85% BS or 0.85 PP.  
Besides, the tree topology might influence on the decision of calling a clade "well-supported". Therefore and once again, this might depend on the scope of your analysis and the data used.  
  
#### Identifying equivalent lineages  
  
Similarly to the previous subsection, identifying equivalent lineages will depend on the data used, the tree topology and the support of the clades. However, if two independent clades have similar branch lengths and their distance to the root is somehow similar, we cn argue that their hierarchical classification might be similar (i.e.; class, order, family).  
  
### Integrating the tree in a broader evolutionary context
  
We have performed a technical check of the tree, and seems OK with the exceptions of few minor technical discrepancies. We have interpreted those discrepancies from a biological point of view, and they are easily explained with the given dataset.  
Now we can pay attention to the identifiers from the tree tips and build an evolutionary hypothesis for our tree. It is time to integrate the previous interpretations with the rest of the information we had before inferring the phylogenetic tree.  
If your scope was ecological, do you find any ecological pattern? If you performed a morphological and molecular characterization, do you find any morphological pattern? How is it comparing with your initial hypothesis? Your work now will be to find those patterns, they might or they might not agree with the previous knowledge.  
  
![Integrating knowledge](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure10_examples_9.png)   
  
Lastly, it is important to integrate the meaning of your tree in the current state of the art. What is your tree bringing to the current state of the art of your field? How is it comparing to the previous existing knowledge?  
  
---  
  
## Conclusion
  
Phylogenetic trees are hypotheses of the given data, dependent from a specific methodological approach. Therefore it is of paramount importance to adjust as far as possible your dataset and your methods to the scope of your scientific question. Even the same question, if tackled from different methods and datasets, might result in different or even contradicting hypotheses. And yet, such both hypotheses might be correct, they will just represent **different pictures of the same reality**.  
Let's imagine going somewhere beyond the tropics and take the a picture in the exact same location through the different season. Or going within the tropics but changing the zoom throughout different pictures. In the first example we only changed the time, whereas in the second the method.  
  
Evolution and diversification are complex processes that we tend to simplify with trees, networks or even more elaborated stories. Yet such representations only tell one part of the story, since it is basically impossible to cover all different aspects of evolution.  
Selection occurs at many different levels from genes to ecosystems, going through traits, organisms, holobionts, populations and communities. Such diversity levels also interact within and between them creating a reticulate system where a linear story simply represents one hypothesis from a given point of view.  
  
Phylogenetic patterns are constantly changing with new tools being developed that allow accessing nw aspects of the biological diversity, its exploration and analysis. In this sense, our job as scientists is to integrate all the different knowledge into a comprehensive story coming from many different angles, being critical about the data we are using and aware of the limitations of the methods we are applying.  
  
![Different pictures of the same reality](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/resources/Figure11_different_pictures_of_the_same_reality.png)    
  
---
  
## Summary
  
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
with **RAxML**:  
```raxmlHPC-PTHREADS-SSE3 -n ${OUTPUT}_raxml-GTRgamma -s $FILE -m GTRGAMMA -p $RANDOM -x $(date +%s) -f a -N $BS -T 2```  
and/or **RAxML-ng**:  
```raxml-ng --all --msa $FILE --model GTR+G --tree pars{10} --prefix ${OUTPUT}_raxml-ng-GTRgamma --seed $RANDOM --threads $THREADS --bs-trees $BS```  
and/or **IQ-TREE**:  
```iqtree -s $FILE -st "DNA" -pre ${OUTPUT}_IQtree-mt -b $BS -seed $(date +%s) -mem $MEM -nt $THREADS -wbtl```  
and/or using a **Bayesian Inference** approach with **MrBayes** (you can find an example script here: [phylo_mrBayes.sh](https://github.com/MiguelMSandin/phylogeniesQuickStart/blob/main/scripts/3.4.1_MrBayes_set.sh)):  
```mb < phylo_mrBayes.sh > ${OUTPUT]_mrBayesgamma.log```  
  
**Step 5**. **Interpret your phylogenetic tree**.  
First from a **methodological point of view**: Are all nodes highly supported? Are there no polytomic nodes? Are there no long branches?  
Then we add the **biological thinking**: Are the outgroups clearly defined and independent from the ingroup? Are the patterns among clades as previously reported/suggested/expected? Can you explain the tree topology according to the *species* you used (e.g.; rRNA genes, plastids, proteins)?  
Lastly we add a **broader context**: can you explain the tree in a biological integrative context? For example if using genes/proteins, can you explain it from a morphological or ecological point of view? What is contributing to the state of the art of your research?  
If not, then you should come back to **Step 1**, think again on the chosen *species*, try different alignment options and/or try to use different trimming options more suited to your scientific question.   
  
---
  
## Further reading  
  
**Phylogenetic tree thinking**: Interpreting phylogenetic trees seems *a priori* a simple task, since it is indeed a simple representation of a dichotomic diversification. Yet as we have seen throughout this crash course, a phylogenetic tree might lead to misinterpretation when not interpreted from an integrative methodological and biological perspective ([Meisel 2010](https://evolution-outreach.biomedcentral.com/articles/10.1007/s12052-010-0254-9)). In this context, a single tree provides one version of a very complex process that requires a criticial thinking and interpretion from many different points of view ([Doolitle and Bapteste, 2007](https://www.pnas.org/doi/full/10.1073/pnas.0610699104)).  
  
Regarding the methodological aspect of phylogenetic reconstruction, models and parameters you can directly check in the (most of the times) very well documented hands-on tutorials of the open source softwares I introduced here. Besides, I highly encourage you to extend your possiblities and go fancy in phylogenetic inference by looking and epxloring different options through the help command (i.e.; ```iqtree -h```, ```raxml-ng -h```), or through their online manuals and hands-on tutorials:
- RAxML (not maintained any more): https://github.com/stamatak/standard-RAxML/blob/master/manual/NewManual.pdf  
- RAxML-NG: https://github.com/amkozlov/raxml-ng/wiki/Tutorial  
- IQtree: http://www.iqtree.org/doc/Quickstart  
- MrBayes: https://github.com/NBISweden/MrBayes/blob/develop/doc/manual/Manual_MrBayes_v3.2.pdf  
- R: ape and phangorn: https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.html  
- BEAST: https://beast.community/first_tutorial. 
- BEAST2: https://www.beast2.org/tutorials/  
  
