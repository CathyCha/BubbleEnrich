context("Bubble GSEA")
library(BubbleGSEA)
library("testthat")
library("ggplot2")
library("DOSE")

test_that("the function output is correct", {
  data(geneList)
  bubble_graph <- BubbleGSEA(geneList)
  expect_that(bubble_graph, "enrichResult")
})
