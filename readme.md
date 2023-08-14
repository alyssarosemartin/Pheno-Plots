# Phenology Plots Shiny App and Exploratory Analysis - DEMO

This repository contains the code to create a prototype shiny app to plot trends in date of onset for various phenophases and species and elevation bands at Great Smoky Mtns National Park (GRSM). It also contains RMarkdown code for doing exploratory analyses of GRSM data.

## Plot-app folder

This is the shiny app code, which first acquires and processes the phenology observation data using rnpn, lubridate, dplyr and base R functions. Then shiny is used to define the input and outputs.


The code runs in R, with rnpn, curl, shiny, dplyr and lubridate libraries loaded.

## PDF-PhenoPlots.pdf

This is simpler code, that does essentially the same thing as the Shiny app, but outputs results (plots of phenophase onset by year) as PDFs

## GRSM_Exploration.R

This RMarkdown is a prototype for addressing common questions asked by USA-NPN Local Phenology Projects. It demonstrates how to download data, and explore change over time in onset dates, and how onset dates relate to climate predictor variables. It is a work in progress. 

## GRSM_Exploration.pdf is the RMarkdown output from the GRSM_Exploration R code.
