library(topGO)
library(ggplot2)

rm(list=ls())

setwd("/home/felipe/Documents/ecoli-co-expression-network/code")

# change inflation (new analysis)
I="I60/"
I_file="I60"
inflation <- "I 6.0"

new_path <- paste0("/home/felipe/Documents/ecoli-co-expression-network/results/enrichment/", I)
results_path <- new_path

# create recursive dir
dir.create(results_path, recursive = TRUE)

load_files <- function(){
  
  ## read clusters size
  f1 = paste0("../results/formated/dump.out.ecoli60.mci.", I_file, ".number")
  number.clusters <<- read.table(f1, header = F)
  
  ## read list of genes for all the network 
  geneID2GO <<- readMappings(file = "../data/GO_annotations.txt")
  
  # read genes in graph
  f2 = paste0("../results/formated/dump.out.ecoli60.mci.", I_file, ".formated.csv")
  genes_in_graph <<- as.data.frame(rownames(read.table(f2, header =F, row.names=1)))
  colnames(genes_in_graph) <<- "gene"
  
  # filter background genes to genes in the network
  geneID2GO_filtered <<- geneID2GO[genes_in_graph[,1]]
  
  #geneNames <<- names(geneID2GO_filtered)
  geneNames <<- genes_in_graph$gene
  
  # read modules
  dynamicMods <<- read.table(file = f2, header = F, row.names=1)
  colnames(dynamicMods) <<- "module_No"
}

# load things in cluster
load_files()

# make annot fun
anot_modules <- function(Module_no, results_path){
  paste0("MODULO:", Module_no,"      ","NODOS:",number.clusters[Module_no,1])
  myInterestingGenes <- genes_in_graph[dynamicMods$module_No==Module_no,]
  geneList <<- as.factor(as.integer(geneNames %in% myInterestingGenes))
  names(geneList) <- geneNames
  
  GOdata <<- new("topGOdata",
                 ontology = "BP",
                 allGenes = geneList,
                 annot = annFUN.gene2GO,
                 gene2GO = geneID2GO_filtered)
  allGO=usedGO(GOdata)

  # MIRAR SI DA VALOR Pcorregido el TOP GO
  # classic ingnora la topologia del go
  # revisar algoritmos 
  
  Classic <<- runTest(GOdata, algorithm = "classic", statistic = "fisher")
  #resultsWeight01 <- runTest(GOdata, algorithm = "weight01", statistic = "fisher")
  
  # Make results  table
  #table <- GenTable(GOdata, Classic = resultClassic, Weight01 = resultsWeight01, topNodes = length(allGO), orderBy = 'Classic')
  table <- GenTable(GOdata, Classic = Classic, topNodes = length(allGO), orderBy = 'Classic')
  
  # Filter not significant values for classic algorithm
  ####table1 <- filter(table, Classic < 0.05 )
  
  # Performing BH correction on our p values FDR
  ####p.adj <- round(p.adjust(table1$Classic,method="BH"),digits = 4)
  p.adj <- round(p.adjust(table$Classic,method="BH"),digits = 4)
  
  # Create the file with all the statistics from GO analysis
  ####all_res_final <<- cbind(table1,p.adj)
  all_res_final <<- cbind(table,p.adj)
  all_res_final <<- all_res_final[order(all_res_final$p.adj),]
  
  # Get list of significant GO before multiple testing correction
  results.table.p = all_res_final[which(all_res_final$Classic <=0.05),]
  
  # Get list of significant GO after multiple testing correction
  results.table.bh = all_res_final[which(all_res_final$p.adj<=0.05),]
  
  # Save first top 50 ontolgies sorted by adjusted pvalues
  write.table(all_res_final[1:50,], file = paste0(results_path, "module_", Module_no, ".csv"), quote=FALSE, row.names=FALSE, sep = ",")

  #### CREATE PLOTS
  module <- paste0("module_", Module_no, " (", inflation, ")")
  
  # open table 
  #topGO_all_table <- read.table("../results/enrichment/module_1.csv", sep = ",")
  topGO_all_table <<- all_res_final
  colnames(topGO_all_table) <<- c("GO.ID","Term","Annotated","Significant","Expected","Classic","p.adj")
  
  topGO_all_table <- topGO_all_table[order(topGO_all_table$Classic),]
  
  ntop <- 30
  ggdata <- topGO_all_table[1:ntop,]
  
  # Remover valores duplicados da coluna 'Term' # evitar erro por termos duplicados
  ggdata <- ggdata[!duplicated(ggdata$Term), ]
  
  ggdata$Term <- factor(ggdata$Term, levels = rev(ggdata$Term)) # fixes order
  
  # Adicionar 0.001 para o log10(1) ser diferente de 0
  ggdata$Classic <- as.numeric(ggdata$Classic) + 0.000001
  ggdata
  
  ggplot(ggdata,
         aes(x = ggdata$Term, y = -log10(Classic), size = -log10(Classic), fill = -log10(Classic))) +
    
    expand_limits(y = 1) +
    geom_point(shape = 21) +
    scale_size(range = c(2.5,12.5)) +
    scale_fill_continuous(low = 'royalblue', high = 'red4') +
    
    xlab('') + ylab('Enrichment score') +
    labs(
      title = module,
      subtitle = 'Top 30 terms ordered by Fisher Exact p-value',
      caption = 'Cut-off lines drawn at equivalents of p=0.05, p=0.01, p=0.001') +
    
    geom_hline(yintercept = c(-log10(0.05), -log10(0.01), -log10(0.001)),
               linetype = c("dotted", "longdash", "solid"),
               colour = c("black", "black", "black"),
               size = c(0.5, 1.5, 3)) +
    
    theme_bw(base_size = 24) +
    theme(
      legend.position = 'right',
      legend.background = element_rect(),
      plot.title = element_text(angle = 0, size = 16, face = 'bold', vjust = 1),
      plot.subtitle = element_text(angle = 0, size = 14, face = 'bold', vjust = 1),
      plot.caption = element_text(angle = 0, size = 12, face = 'bold', vjust = 1),
      
      axis.text.x = element_text(angle = 0, size = 12, face = 'bold', hjust = 1.10),
      axis.text.y = element_text(angle = 0, size = 12, face = 'bold', vjust = 0.5),
      axis.title = element_text(size = 12, face = 'bold'),
      axis.title.x = element_text(size = 12, face = 'bold'),
      axis.title.y = element_text(size = 12, face = 'bold'),
      axis.line = element_line(colour = 'black'),
      
      #Legend
      legend.key = element_blank(), # removes the border
      legend.key.size = unit(1, "cm"), # Sets overall area/size of the legend
      legend.text = element_text(size = 14, face = "bold"), # Text size
      title = element_text(size = 14, face = "bold")) +
    
    coord_flip()
  

  plot_path <- paste0(results_path, "module_", Module_no, "_GO_30Terms_Fisher", ".png")
  
  ggplot2::ggsave(plot_path,
                  device = NULL,
                  height = 8.5,
                  width = 12)
}

for (i in 1:dim(table(dynamicMods))){ 
  if(number.clusters[i,1]>=4){
    print(i)
    anot_modules(i,results_path)
    
  }
}
