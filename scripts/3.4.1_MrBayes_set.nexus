begin mrbayes;
	set autoclose=yes nowarn=yes;
	execute FILE.nexus;
	lset nst=6 rates=gamma;
	mcmc ngen=10000000 Nruns=4 savebrlens=yes file=OUTPUT;
	sump;
	sumt;
end;
