# Bulk RNA-seq Analysis of Glioblastoma (GBM)

## Project Overview

This project presents a complete Bulk RNA-seq differential gene expression workflow performed in **R** using the **DESeq2** package.

The analysis compares gene expression profiles between healthy brain tissue and glioblastoma (GBM) samples.

The workflow includes differential expression analysis, functional enrichment analysis, Principal Component Analysis (PCA), and visualization of the results.

---

# Biological Question

**Which genes and biological processes are significantly altered in glioblastoma compared with healthy brain tissue?**

---

# Dataset

- **Database:** Gene Expression Omnibus (GEO)
- **Accession number:** GSE147352
- **Organism:** *Homo sapiens*
- **Data type:** Bulk RNA-seq

Dataset:

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147352

---

# Bioinformatics Workflow

- Load raw count matrix
- Download sample metadata from GEO
- Prepare sample metadata
- Differential gene expression analysis using DESeq2
- Gene annotation
- MA Plot
- Volcano Plot
- Gene Ontology (GO) enrichment analysis
- Principal Component Analysis (PCA)
- Heatmap visualization

---

# Technologies

- R
- DESeq2
- GEOquery
- AnnotationDbi
- org.Hs.eg.db
- clusterProfiler
- enrichplot
- ggplot2
- ggrepel
- pheatmap

---

# Results

## Volcano Plot

The volcano plot presents differentially expressed genes between healthy brain tissue and glioblastoma samples.

![Volcano Plot](01_Bulk_RNAseq_R/figures/Volcano_plot.png)

---

## MA Plot

The MA plot visualizes gene expression changes after normalization.

![MA Plot](01_Bulk_RNAseq_R/figures/MA_plot.png)

---

## Gene Ontology Dotplot

The GO dotplot presents the most significantly enriched biological processes.

![GO Dotplot](01_Bulk_RNAseq_R/figures/GO_dotplot.png)

---

## Gene Ontology Barplot

The GO barplot summarizes enriched GO Biological Processes.

![GO Barplot](01_Bulk_RNAseq_R/figures/GO_barplot.png)

---

## Principal Component Analysis (PCA)

PCA demonstrates a clear separation between healthy brain tissue and glioblastoma samples.

![PCA Plot](01_Bulk_RNAseq_R/figures/PCA_plot.png)

---

## Heatmap

The heatmap presents expression patterns of the top 30 differentially expressed genes.

![Heatmap](01_Bulk_RNAseq_R/figures/Heatmap_top30_genes.png)

---

# Main Findings

The analysis identified numerous genes significantly dysregulated in glioblastoma compared with healthy brain tissue.

Gene Ontology enrichment analysis revealed biological processes related to:

- immune response
- leukocyte migration
- chemotaxis
- exocytosis
- regulation of membrane potential

Principal Component Analysis clearly separated healthy and glioblastoma samples.

The heatmap confirmed distinct expression patterns between both groups.

---

# Repository Structure

```text
01_Bulk_RNAseq_R
│
├── analysis
│   └── 01_bulk_rnaseq_analysis.R
│
├── data
│   └── counts
│
├── figures
│   ├── Volcano_plot.png
│   ├── MA_plot.png
│   ├── GO_dotplot.png
│   ├── GO_barplot.png
│   ├── PCA_plot.png
│   └── Heatmap_top30_genes.png
│
└── results
    ├── DESeq2_all_results.csv
    ├── Significant_genes_GBM_vs_Healthy.csv
    └── GO_BP_results.csv
```

---

# Author

**Katarzyna Zielińska**

Bioinformatics Portfolio

2026
