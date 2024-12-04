# How to write trees  
  
In terms of formating, the simplest tree format is called [newick](https://en.wikipedia.org/wiki/Newick_format), and it is simply a nested grouping of trees, where tips are separated by commas, and nodes are grouped by parentheses.  
<img src="../resources/Figure2_tree_root.png" alt="Tree root" width="60%"/>  
The previous example would look like as follows:  
```((a,b),((c,d),(e,f)));```  
Note the semicolon (";") terminating the tree.  
Branch lengths (or the accumulated change) are provided after the given tip or node separated by a colon (":"), as follows:  
```((a:1,b:1),((c:1,d:1),(e:1,f:1)));```  
And finally, it is possible to add names to the nodes by simply including such names after the given node, as follows:  
```((a:1,b:1),((c:1,d:1),(e:1,f:1)sub-clade)clade);```  
