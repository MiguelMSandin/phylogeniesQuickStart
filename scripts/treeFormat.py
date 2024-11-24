#!/usr/bin/env python3

import argparse
from Bio import Phylo

parser = argparse.ArgumentParser(description="Transforms the format of a tree.")

# Add the arguments to the parser
requiredArgs = parser.add_argument_group('required arguments')

requiredArgs.add_argument("-t", "--tree", dest="tree", required=True,
						  help="A tree file.")

parser.add_argument("-f", "--formatIn", dest="formatIn", required=False, default='nexus',
					help="The input tree file format: accepted formats are: newick, nexus (default), nexml, phyloxml or cdao.")

parser.add_argument("-F", "--formatOut", dest="formatOut", required=False, default='newick',
					help="The output tree file format: accepted formats are: newick (default), nexus, nexml, phyloxml or cdao.")

parser.add_argument("-o", "--out", dest="output", required=False, default=None,
					help="The output file name. By default will change the extension of the tree to the formated output.")

parser.add_argument("-n", "--names", dest="names", required=False, action="store_false",
					help="If selected, will KEEP node names or comments. By default REMOVE node names and comments.")

parser.add_argument("-c", "--confidence", dest="confidence", required=False, action="store_true",
					help="If selected, will REMOVE confidence support in the nodes. By default KEEP confidence support.")

parser.add_argument("-k", "--keep", dest="keep", required=False, default=None,
					help="Sometimes confidence support is saved in comments. If so this option will extract the given name from the comments and save it.")

parser.add_argument("-v", "--verbose", dest="verbose", required=False, action="store_false",
					help="If selected, will not print information to the console.")

args = parser.parse_args()

# Setting variables --------------------------------------------------------------------------------
if args.output is None:
	import re
	if args.formatOut == "newick":
		tmp = "newick"
	if args.formatOut == "nexus":
		tmp = "nexus"
	if args.formatOut == "nexml":
		tmp = "nexml"
	if args.formatOut == "phyloxml":
		tmp = "phyloxml"
	if args.formatOut == "cdao":
		tmp = "cdao"
	output = re.sub("\\.[^\\.]+$", ".", args.tree) + tmp
else:
	output = args.output

# Reading file -------------------------------------------------------------------------------------
if args.verbose:
	print("  Reading", args.formatIn, "tree", args.tree)
T = Phylo.read(args.tree, args.formatIn)

# Deleting node names and confidence values if selected --------------------------------------------
if args.confidence:
	if args.verbose:
		print("  Deleting confidence support")
	for node in T.get_nonterminals():
		node.confidence = None

if args.keep is not None:
	if args.verbose:
		print("  keeping", args.keep)
	import re
	for node in T.get_nonterminals():
		tmp = str(node.comment)
		tmp = re.sub(str(".*" + args.keep + "="), "", tmp)
		tmp = re.sub(",.*", "", tmp)
		tmp = re.sub("\\]", "", tmp)
		if tmp != 'None':
			if tmp.isdigit():
				node.confidence = int(tmp)
			else:
				node.confidence = float(tmp)

if args.names:
	if args.verbose:
		print("  Deleting node names and comments")
	for node in T.get_nonterminals():
		node.name = None
		node.comment = None

# Reading file -------------------------------------------------------------------------------------
if args.verbose:
	print("  Exporting", args.formatOut, "tree to", output)
Phylo.write(T, output, args.formatOut)

if args.verbose:
	print("Done")
