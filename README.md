Clustering analysis based on expression profiles in Escherichia coli, as presented in `Case Study #2` of [Using MCL to Extract Clusters from Networks](http://micans.org/mcl/lit/mimb.pdf). This study applies the [MCL algorithm](http://micans.org/mcl/) to gene expression data from the [Many Microbe Microarray Database](http://m3d.mssm.edu/norm/).

>E_coli_v4_Build_6: Dataset used that contains expression values for 4297 genes measured across 466 conditions.

![](https://github.com/felipevzps/ecoli-co-expression-network/blob/main/results/clusterSizeDistribution.png)
>I wrote [this script](https://github.com/felipevzps/ecoli-co-expression-network/blob/main/code/clusterSizeDistribution.py) to plot cumulative fraction of genes vs cluster size.

As evidenced in the paper, the correlation of gene expression values leads to distinct networks (varying in levels of inflation and also cluster size).

Almost all genes are part of a single connected component (size 3959). As inflation increases, the network gradually breaks down, eventually forming clusters with 2 and 3 genes.

## References
van Dongen, S., & Abreu-Goodger, C. (2012). Using MCL to extract clusters from networks. Methods in molecular biology (Clifton, N.J.), 804, 281–295. https://doi.org/10.1007/978-1-61779-361-5_15

van Dongen, S. (2008). Graph clustering via a discrete uncoupling process, Siam Journal on Matrix Analysis and Applications 30-1, 121-141. https://doi.org/10.1137/040608635
