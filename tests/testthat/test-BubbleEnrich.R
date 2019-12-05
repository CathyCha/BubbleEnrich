context("Bubble Enrich")
library(BubbleEnrich)
library(ggplot2)
library("testthat")


############## test for BubbleEnrich.R ##############

test_that("the function output is a ggplot", {
  data(geneList, package = "DOSE")
  bubbleGraph <- BubbleEnrich(geneList)
  expect_true(is.ggplot(bubbleGraph))
})

test_that("errors are produced with incorrect input", {
  badInput <- "bad"
 expect_error(BubbleEnrich(badInput))
})


############## test for colourInput.R ###############

test_that("correct colours are returned", {
  Highcolour <- colourInput("Purple", "highcolour")
  Lowcolour <- colourInput("Purple", "lowcolour")
  expect_identical(Highcolour, "purple1")
  expect_identical(Lowcolour, "plum1")
})
