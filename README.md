# Bulk RNA-seq Analysis of Glioblastoma (GBM)

## Project Overview

This project presents a complete bulk RNA-seq differential gene expression workflow performed in **R** using the **DESeq2** Bioconductor package.

The aim of the project was to identify genes differentially expressed between **healthy brain tissue** and **glioblastoma (GBM)** samples and to investigate biological processes associated with these changes.

The workflow includes differential expression analysis, Gene Ontology enrichment analysis, Principal Component Analysis (PCA), and visualization of gene expression patterns.

---

# Biological Question

**Which genes and biological processes are significantly altered in glioblastoma compared with healthy brain tissue?**

---

# Dataset

| Information | Value |
|-------------|-------|
| Database | Gene Expression Omnibus (GEO) |
| Accession | GSE147352 |
| Organism | Homo sapiens |
| Data type | Bulk RNA-seq |
| Analysis | Differential Gene Expression |

Dataset:

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147352

---

# Bioinformatics Workflow

- Load raw count matrix
- Download metadata from GEO
- Prepare sample metadata
- Differential expression analysis using DESeq2
- Gene annotation
- Identification of significantly differentially expressed genes
- MA Plot
- Volcano Plot
- Gene Ontology (GO) enrichment analysis
- GO Dotplot
- GO Barplot
- Principal Component Analysis (PCA)
- Heatmap of the top 30 differentially expressed genes

---

# Technologies

- R
- Bioconductor
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

Differentially expressed genes between healthy brain tissue and glioblastoma samples.

![Volcano Plot](figures/Volcano_plot.png)

---

## MA Plot

Normalized gene expression changes across all analyzed genes.

![MA Plot](figures/MA_plot.png)

---

## Gene Ontology Dotplot

Top enriched biological processes identified among differentially expressed genes.

![GO Dotplot](figures/GO_dotplot.png)

---

## Gene Ontology Barplot

Summary of the most significantly enriched GO Biological Processes.

![GO Barplot](figures/GO_barplot.png)

---

## Principal Component Analysis (PCA)

PCA demonstrates clear separation between healthy brain tissue and glioblastoma samples based on global gene expression profiles.

![PCA Plot](figures/PCA_plot.png)

---

## Heatmap

Expression patterns of the top 30 differentially expressed genes.

![Heatmap](figures/heatmap_top30_genes.png)

---

# Main Findings

The analysis identified numerous genes significantly dysregulated in glioblastoma compared with healthy brain tissue.

Gene Ontology enrichment analysis revealed biological processes associated with:

- immune response
- leukocyte migration
- chemotaxis
- exocytosis
- regulation of membrane potential

Principal Component Analysis showed a clear separation between healthy and glioblastoma samples.

The heatmap confirmed distinct expression patterns of the most significantly differentially expressed genes.

---

# Repository Structure

```text
Bulk-RNAseq-Glioblastoma-DESeq2
│
├── data
│   └── counts
│
├── docs
│
├── figures
│   ├── Volcano_plot.png
│   ├── MA_plot.png
│   ├── GO_dotplot.png
│   ├── GO_barplot.png
│   ├── PCA_plot.png
│   └── heatmap_top30_genes.png
│
├── results
│   ├── Significant_genes_GBM_vs_Healthy.csv
│   └── GO_BP_results.csv
│
├── scripts
│   └── 01_bulk_rnaseq_analysis.R
│
├── .gitignore
├── LICENSE
└── README.md
```

---

# Skills Demonstrated

- Bulk RNA-seq analysis
- Differential gene expression analysis
- Statistical analysis using DESeq2
- Gene annotation
- Functional enrichment analysis (Gene Ontology)
- Data visualization in R
- Principal Component Analysis (PCA)
- Heatmap visualization
- Reproducible bioinformatics workflow
- Git & GitHub project organization

---

# Author

**Katarzyna Zielińska**

Bioinformatics Portfolio

2026
