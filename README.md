# `BubbleEnrich`

&nbsp;

###### [Yeon Joo Cha](https://orcid.org/0000-0003-4609-4965)


<!-- TOCbelow -->
1. About this package:<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.1. What it is ...<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.2. Who needs it ...<br/>
&nbsp;&nbsp;&nbsp;&nbsp;1.3. How it works ...<br/>
2. Details ...<br/>
3. Develop<br/>
4. Demo<br/>
5. Things to do:<br/>
6. Further reading<br/>
7. Acknowledgements<br/>

<!-- TOCabove -->

----


# 1 About this package:

This package creates a bubble graph of disease phenotypes from a gene enrichment analysis done on a gene set of interest.

&nbsp;

----

## 2 Installations 


```{r}
require("devtools")
install_github("CathyCha/BubbleEnrich")
library("BubbleEnrich")
```

----

## 3 Overview


Quick visualization of what the idea of the visualization of the package is: 


![](./inst/extdata/CHA_Y_A1.png) 


&nbsp;


## 4 Contributions

Enrichment functions from the clusterProfiler package in bioconductor was used to perform the enrichment analysis and output a enriched set result for the plotting of the bubble graph.
 
 
Acknowledgment to the DOSE package to for providing the example dataset for the demo of this package. 

&nbsp;


## 4 Quick Demo 


#### About the data

###### The example data being used for demo

For gene set enrichment analysis, we need a ranked list of genes. DOSE provides an example dataset geneList which was derived from R package breastCancerMAINZ that contained 200 samples, including 29 samples in grade I, 136 samples in grade II and 35 samples in grade III. We computed the ratios of geometric means of grade III samples versus geometric means of grade I samples. Logarithm of these ratios (base 2) were stored in geneList dataset.

The geneList contains three features:

* numeric vector: fold change or other type of numerical variable

* named vector: every number was named by the corresponding gene ID

* sorted vector: number should be sorted in decreasing order

We can load the sample data into R via:

```{r}
data(geneList, package="DOSE")
head(geneList)
```

&nbsp;


###### DisGeNET for gene-disease annotations

Using the disease to gene annotations from DisGeNET 

*Stored in <code>~/BubbleEnrich/data/disgeneAnnot.rda</code>

http://www.disgenet.org/static/disgenet_ap1/files/downloads/all_gene_disease_associations.tsv.gz

```{r}
> disgeneAnnot <- load("~/BubbleEnrich/data/disgeneAnnot.rda")
> head(disgeneAnnot)
  geneId geneSymbol   DSI   DPI diseaseId                   diseaseName diseaseType diseaseClass
1      1       A1BG 0.857 0.172  C0019209                  Hepatomegaly   phenotype      C06;C23
2      1       A1BG 0.857 0.172  C0013080                 Down Syndrome     disease      C10;C16
3      1       A1BG 0.857 0.172  C0036341                 Schizophrenia     disease          F03
4      1       A1BG 0.857 0.172  C0001418                Adenocarcinoma       group          C04
5      1       A1BG 0.857 0.172  C0002736 Amyotrophic Lateral Sclerosis     disease      C10;C18
6      1       A1BG 0.857 0.172  C0017636                  Glioblastoma     disease          C04
               diseaseSemanticType score EI YearInitial YearFinal     pmid    source
1                          Finding  0.30 NA        2017      2017 28108177 CTD_human
2              Disease or Syndrome  0.01  1        2011      2011 21360684    BEFREE
3 Mental or Behavioral Dysfunction  0.30 NA        2015      2015 25821032 CTD_human
4               Neoplastic Process  0.01 NA        2008      2008 18706098     LHGDN
5              Disease or Syndrome  0.01  1        2009      2009 18973555    BEFREE
6               Neoplastic Process  0.01  1        2014      2014 24096582    BEFREE
```


&nbsp;


#### Using your own data 

Suppose you are importing your own data from a csv file and the file contains two columns, one for gene ID (no duplicated allowed) and another one for fold change, you can prepare your own geneList via the following command:

```{r}
d <- read.csv(your_csv_file)
## assume that 1st column is ID
## 2nd column is fold change

## feature 1: numeric vector
geneList <- d[,2]

## feature 2: named vector
names(geneList) <- as.character(d[,1])

## feature 3: decreasing order
geneList <- sort(geneList, decreasing = TRUE)
```

Suppose we define fold change greater than 2 as DEGs:

```{r}
gene <- names(geneList)[abs(geneList) > 2]
head(gene)
```

&nbsp;

#### Visualizations 


Running the demo with the example data from above...


```{r}
data(geneList)
BubbleEnrich(geneList)
```

... returns the following visualization 


![](./inst/extdata/Rplot.png)



This is a work-in-progress and will be cleaned up. 


# 5 Things to do: 

* clean up the contributing genes 

* implement in R shiny so that it can funtion as an interactive applications 
    * where user can input their own geneList of interest 
    * change colour 
    * axis of interest 
    * range of pvalue considered important 


# 6 Further reading

- The [**R Packages** book](http://r-pkgs.had.co.nz/) 
- The [**CRAN** manual on writing R-extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html)
- Hornik, K., Murdoch D. and Zeileis, A. (2012) [Who Did What? The Roles of R Package Authors and How to Refer to Them](https://journal.r-project.org/archive/2012-1/RJournal_2012-1_Hornik~et~al.pdf). The R Journal 4:(1) 64-69.
- [**roxygen2** documentation](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html)
- Cyril Chapellier's [**markdown cheatsheet**](https://github.com/tchapi/markdown-cheatsheet/blob/master/README.md) 

&nbsp;

# 7 Acknowledgements

Thank you to Professor Boris Steipe for providing a R package template, rpt (https://github.com/hyginn/rpt), for BCB coursework. 

&nbsp;

&nbsp;

<!-- END -->
