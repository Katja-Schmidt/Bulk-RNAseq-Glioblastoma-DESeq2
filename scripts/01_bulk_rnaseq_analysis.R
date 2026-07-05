# ============================================================
# Project:
# Differential Gene Expression Analysis of Glioblastoma (GBM)
#
# Dataset:
# GSE147352 (Gene Expression Omnibus)
#
# Organism:
# Homo sapiens
#
# Author:
# Katarzyna Zielińska
#
# Date:
# June 2026
#
# Description:
# This project presents a complete Bulk RNA-seq workflow
# for identifying differentially expressed genes between
# healthy brain tissue and glioblastoma samples using DESeq2.
#
# The analysis includes:
# - Differential expression analysis
# - Gene annotation
# - MA Plot
# - Volcano Plot
# - Gene Ontology enrichment
# - Principal Component Analysis (PCA)
# - Heatmap visualization
# ============================================================

rm(list = ls())

set.seed(123)

# ============================================================
# 1. Load required libraries
# ============================================================

library(GEOquery)
library(DESeq2)
library(org.Hs.eg.db)
library(AnnotationDbi)
library(ggplot2)
library(ggrepel)
library(clusterProfiler)
library(enrichplot)
library(pheatmap)

# ============================================================
# 2. Load raw count matrix
# ============================================================

counts <- read.delim(
  "data/counts/GSE147352_raw_counts_GRCh38.p13_NCBI.tsv.gz"
)

rownames(counts) <- counts$GeneID
counts <- counts[, -1]

# ============================================================
# 3. Download metadata from GEO
# ============================================================

gse <- getGEO(
  "GSE147352",
  GSEMatrix = TRUE
)

pheno <- pData(gse[[1]])

colData <- pheno[, c(
  "geo_accession",
  "tissue type:ch1"
)]

colnames(colData) <- c(
  "Sample",
  "Condition"
)

# ============================================================
# 4. Prepare sample metadata
# ============================================================

colData$Condition <- factor(
  colData$Condition,
  levels = c(
    "Normal brain tissues",
    "glioblastoma tissues",
    "lower grade glioma tissues"
  ),
  labels = c(
    "Healthy",
    "GBM",
    "LGG"
  )
)

colData <- colData[
  colData$Condition != "LGG",
]

colData$Condition <- droplevels(
  colData$Condition
)

counts <- counts[
  ,
  colData$Sample
]

# Verify sample order

stopifnot(
  all(colnames(counts) == colData$Sample)
)

# ============================================================
# 5. Differential expression analysis
# ============================================================

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = colData,
  design = ~ Condition
)

# Remove low-count genes

keep <- rowSums(counts(dds)) >= 10

dds <- dds[
  keep,
]

# Run DESeq2 pipeline

dds <- DESeq(dds)

# Extract results

res <- results(dds)

# Sort by adjusted p-value

res <- res[
  order(res$padj),
]

# ============================================================
# 6. Gene annotation
# ============================================================

gene_symbols <- mapIds(
  org.Hs.eg.db,
  keys = rownames(res),
  column = "SYMBOL",
  keytype = "ENTREZID",
  multiVals = "first"
)

res$GeneSymbol <- gene_symbols

# ============================================================
# 7. Identify significant genes
# ============================================================

sig_res_fc <- subset(
  res,
  padj < 0.05 &
    abs(log2FoldChange) > 1
)

write.csv(
  as.data.frame(sig_res_fc),
  "results/Significant_genes_GBM_vs_Healthy.csv"
)

# ============================================================
# 8. MA Plot
# ============================================================
#
# Visualize differential expression results
# using an MA plot.
#

png(
  "figures/MA_plot.png",
  width = 1600,
  height = 1200,
  res = 200
)

plotMA(
  res,
  ylim = c(-9, 9)
)

dev.off()

# ============================================================
# 9. Volcano Plot
# ============================================================
#
# Visualize differentially expressed genes
# using a volcano plot.
#

# Classify genes according to significance

res$Significance <- "Not significant"

res$Significance[
  res$padj < 0.05 &
    res$log2FoldChange > 1
] <- "Upregulated"

res$Significance[
  res$padj < 0.05 &
    res$log2FoldChange < -1
] <- "Downregulated"

# Select genes for labeling

genes_to_label <- subset(
  sig_res_fc,
  GeneSymbol %in% c(
    "TOP2A",
    "MKI67",
    "TNC",
    "NES",
    "F2R"
  )
)

# Create volcano plot

# Create volcano plot

volcano_plot <- ggplot(
  as.data.frame(res),
  aes(
    x = log2FoldChange,
    y = -log10(padj),
    color = Significance
  )
) +
  geom_point(size = 1.2) +
  
  geom_text_repel(
    data = genes_to_label,
    aes(
      x = log2FoldChange,
      y = -log10(padj),
      label = GeneSymbol
    ),
    inherit.aes = FALSE,
    size = 4,
    max.overlaps = Inf
  ) +
  
  geom_vline(
    xintercept = c(-1, 1),
    linetype = "dashed"
  ) +
  
  geom_hline(
    yintercept = -log10(0.05),
    linetype = "dashed"
  ) +
  
  scale_color_manual(
    values = c(
      "Downregulated" = "red3",
      "Not significant" = "grey70",
      "Upregulated" = "royalblue3"
    )
  ) +
  
  labs(
    title = "Differential Gene Expression: GBM vs Healthy",
    x = "log2 Fold Change",
    y = "-log10 Adjusted p-value",
    color = "Expression"
  ) +
  
  theme_minimal() +
  
  theme(
    text = element_text(size = 14),
    legend.position = "right",
    plot.title = element_text(
      hjust = 0.5,
      face = "bold",
      size = 18
    )
  )

# Display volcano plot

volcano_plot

# Save volcano plot

ggsave(
  filename = "figures/Volcano_plot.png",
  plot = volcano_plot,
  width = 8,
  height = 6,
  dpi = 300
)

# ============================================================
# 10. Gene Ontology Enrichment Analysis
# ============================================================
#
# Identify enriched biological processes
# among significantly differentially
# expressed genes.
#

# Prepare gene list

gene_list <- rownames(sig_res_fc)

# Perform GO enrichment analysis

go_bp <- enrichGO(
  gene = gene_list,
  OrgDb = org.Hs.eg.db,
  keyType = "ENTREZID",
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE
)

# Convert results to data frame

go_results <- as.data.frame(go_bp)

# Save GO results

write.csv(
  go_results,
  "results/GO_BP_results.csv",
  row.names = FALSE
)

# ============================================================
# 11. GO Dotplot
# ============================================================

go_dotplot <- dotplot(
  go_bp,
  showCategory = 15,
  font.size = 12,
  title = "Top 15 Enriched Biological Processes"
)

# Display plot

go_dotplot

# Save figure

ggsave(
  "figures/GO_dotplot.png",
  plot = go_dotplot,
  width = 10,
  height = 7
)

# ============================================================
# 12. GO Barplot
# ============================================================

go_barplot <- barplot(
  go_bp,
  showCategory = 15,
  title = "Top 15 Enriched Biological Processes"
)

# Display plot

go_barplot

# Save figure

ggsave(
  "figures/GO_barplot.png",
  plot = go_barplot,
  width = 10,
  height = 7
)

# ============================================================
# 13. Principal Component Analysis (PCA)
# ============================================================
#
# Perform variance stabilizing transformation
# and visualize sample clustering.
#

# Variance stabilizing transformation

vsd <- vst(
  dds,
  blind = FALSE
)

# Create PCA plot

pca_plot <- plotPCA(
  vsd,
  intgroup = "Condition"
)

# Display plot

pca_plot

# Save figure

ggsave(
  "figures/PCA_plot.png",
  plot = pca_plot,
  width = 7,
  height = 6
)

# ============================================================
# 14. Heatmap
# ============================================================
#
# Visualize expression patterns
# of the top 30 differentially
# expressed genes.
#

# Extract normalized expression matrix

norm_counts <- assay(vsd)

# Select the top 30 significant genes

top30 <- head(sig_res_fc, 30)

# Create heatmap matrix

heatmap_data <- norm_counts[
  rownames(top30),
]

# Replace Entrez IDs with gene symbols

rownames(heatmap_data) <- top30$GeneSymbol

# Create sample annotation

annotation_col <- data.frame(
  Condition = colData$Condition
)

rownames(annotation_col) <- colData$Sample

print(dim(heatmap_data))
print(head(annotation_col))
str(annotation_col)
head(colnames(heatmap_data))
head(rownames(annotation_col))

# Create and save heatmap

pheatmap(
  heatmap_data,
  scale = "row",
  
  annotation_col = annotation_col,
  
  show_rownames = TRUE,
  show_colnames = FALSE,
  labels_col = rep("", ncol(heatmap_data)),
  
  fontsize_row = 10,
  
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "complete",
  
  border_color = NA,
  treeheight_col = 40,
  
  main = "Top 30 Differentially Expressed Genes",
  
  filename = "figures/Heatmap_top30_genes.png",
  
  width = 11,
  height = 9
)

# ============================================================
# 15. Session Information
# ============================================================

sessionInfo()