
set autoclose=yes nowarnings=yes
execute all_filtered_align-auto_trim05.nexus
lset nst=6 rates=gamma
mcmc ngen=10000000 Nruns=3 savebrlens=yes file=all_filtered_align-auto_trim05_mrBayes
sump
sumt
quit
