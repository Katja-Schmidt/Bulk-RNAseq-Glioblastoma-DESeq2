# Bulk RNA-seq Analysis of Glioblastoma (GBM)

## Project overview

This project presents a complete Bulk RNA-seq differential gene expression workflow performed in R using the DESeq2 package.

The analysis compares gene expression profiles between healthy brain tissue and glioblastoma (GBM) samples.

The workflow includes differential expression analysis, functional enrichment, dimensionality reduction and visualization.

---

## Biological question

**Which genes and biological processes are significantly altered in glioblastoma compared with healthy brain tissue?**

---

## Dataset

**GEO accession:** GSE147352

Source:

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147352

Organism:

*Homo sapiens*

---

## Workflow

- Load raw count matrix
- Download sample metadata from GEO
- Prepare metadata
- Differential expression analysis (DESeq2)
- Gene annotation
- MA Plot
- Volcano Plot
- Gene Ontology enrichment analysis
- Principal Component Analysis (PCA)
- Heatmap of top differentially expressed genes

---

## Main results

The analysis identified significantly differentially expressed genes between GBM and healthy brain tissue.

Functional enrichment analysis revealed biological processes associated with:

- immune response
- leukocyte migration
- regulation of membrane potential
- chemotaxis
- exocytosis

PCA clearly separated healthy samples from glioblastoma samples.

Heatmap clustering confirmed distinct expression patterns between both groups.

---

## Technologies

- R
- DESeq2
- GEOquery
- clusterProfiler
- enrichplot
- ggplot2
- pheatmap
- org.Hs.eg.db

---

## Repository structure

```
01_Bulk_RNAseq_R/

├── analysis/
│   └── 01_bulk_rnaseq_analysis.R
│
├── data/
│   └── counts/
│
├── figures/
│   ├── Volcano_GBM_vs_Healthy.png
│   ├── MA_plot.png
│   ├── PCA_plot.png
│   ├── GO_dotplot.png
│   ├── GO_barplot.png
│   └── Heatmap_Top30_DEGs.png
│
└── results/
    ├── DESeq2_all_results.csv
    ├── Significant_genes_GBM_vs_Healthy.csv
    └── GO_BP_results.csv
```

---

## Author
Katarzyna Zielińska
Bioinformatics Portfolio
