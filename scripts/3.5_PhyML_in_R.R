
library(ape)
library(phangorn)

setwd("")

file <- ""
bootstraps <- ""

fasta <- read.FASTA(file, type="DNA")
image(fasta, cex=.6)

# Build distance matrix for the concatenated data & Neighbour Joining
fasta_dist <- dist.dna(fasta, model="raw", pairwise.deletion = TRUE)
tree_bionj <- bionjs(fasta_dist)

write.tree(tree_bionj, file=gsub("\\.[^\\.]+$", "_NJ.tre", file_out))

# Select the best model for your data
mtfasta <- modelTest(as.phyDat(fasta), tree=tree_bionj, model="all")

subset(mtfasta, AIC  == min(mtfasta$AIC))
subset(mtfasta, AICc == min(mtfasta$AICc))
subset(mtfasta, BIC  == min(mtfasta$BIC))

# Run the phylogenetic analysis with the best selected model
fasta_gtr <- pml(tree_bionj, as.phyDat(fasta), k=4)
fasta_gtr <- optim.pml(fasta_gtr, 
                       model="GTR", 
                       rearrangement="stochastic", optGamma=TRUE, optInv=TRUE, optNni=TRUE) 

set.seed(as.numeric(format(Sys.time(), "%s")))
bsfasta.gtr <- bootstrap.pml(fasta_gtr, 
                             bs=bootstraps, 
                             optNni=TRUE)

tree_fasta_gtr <- plotBS(fasta_gtr$tree, 
                         bsfasta.gtr, 
                         type="phylogram")

write.tree(tree_fasta_gtr, file=file_out)

fasta_gtr

# If you run different models, you can check whether it is worth changing the model or not
anova(fasta_jc69, fasta_gtr)
SH.test(fasta_jc69, fasta_gtr)
