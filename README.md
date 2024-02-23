Clustering analysis based on expression profiles in Escherichia coli, as presented in `Case Study #2` of [Using MCL to Extract Clusters from Networks](http://micans.org/mcl/lit/mimb.pdf). This study applies the [MCL algorithm](http://micans.org/mcl/) to gene expression data from the [Many Microbe Microarray Database](http://m3d.mssm.edu/norm/).

>E_coli_v4_Build_6: Dataset used that contains expression values for 4297 genes measured across 466 conditions.

## Clustering based on expression profiles

![](https://github.com/felipevzps/ecoli-co-expression-network/blob/main/results/clusterSizeDistribution.png)
>I wrote [this script](https://github.com/felipevzps/ecoli-co-expression-network/blob/main/code/clusterSizeDistribution.py) to plot cumulative fraction of genes vs cluster size.

As evidenced in the paper, the correlation of gene expression values leads to distinct networks (varying in levels of inflation and also cluster size).

Almost all genes are part of a single connected component (size 3959). As inflation increases, the network gradually breaks down, eventually forming clusters with 2 and 3 genes.

## Gene Ontology enrichment analysis: exploring biological function of modules

Below, I present the Gene Ontology (GO) enrichment analysis of a highly consistent cluster/module ([performed with this script in R](https://github.com/felipevzps/ecoli-co-expression-network/blob/main/code/enrichmentGO.R)). This module includes genes associated with motility, such as flagellum operons and chemotaxis genes. These findings suggest functional connectivity to motility, providing valuable insights and novel predictions for genes with unknown functions within this module.

<p float="left">
  <img src="https://github.com/felipevzps/ecoli-co-expression-network/blob/main/results/enrichment/I14/module_8_GO_30Terms_Fisher.png" width="450" />
  <img src="https://github.com/felipevzps/ecoli-co-expression-network/blob/main/results/enrichment/I60/module_6_GO_30Terms_Fisher.png" width="450" />
</p>

Another interesting module includes genes associated with the SOS response, triggered by DNA damage. At lower inflation values, this module also includes numerous prophage genes. However, at higher inflation levels, all prophage genes are separated, leaving behind a core group of genes exclusively involved in the SOS response and DNA repair. 
>As suggested by the authors, The set of prophage genes which were initially in the cluster could also merit further analysis, since silent bacteriophage genes are known to be induced by the SOS response.

<p float="left">
  <img src="https://github.com/felipevzps/ecoli-co-expression-network/blob/main/results/enrichment/I14/module_13_GO_30Terms_Fisher.png" width="450" />
  <img src="https://github.com/felipevzps/ecoli-co-expression-network/blob/main/results/enrichment/I60/module_17_GO_30Terms_Fisher.png" width="450" />
</p>

## References
van Dongen, S., & Abreu-Goodger, C. (2012). Using MCL to extract clusters from networks. Methods in molecular biology (Clifton, N.J.), 804, 281–295. https://doi.org/10.1007/978-1-61779-361-5_15

van Dongen, S. (2008). Graph clustering via a discrete uncoupling process, Siam Journal on Matrix Analysis and Applications 30-1, 121-141. https://doi.org/10.1137/040608635
