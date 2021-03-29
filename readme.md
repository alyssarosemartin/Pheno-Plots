# Phenology Plots Shiny App

This repository contains the code to create a shiny app (prototype) to plot trends in date of onset for various phenophases and species and elevation bands at Great Smoky Mtns National Park

## Plot-app

This is the shiny app code, which first acquires and processes the phenology observation data using rnpn, lubridate, dplyr and base R functions. Then shiny is used to define the input and outputs.


The code runs in R, with rnpn, curl, shiny, dplyr and lubridate libraries loaded.

## PDF PhenoPlots

This is simpler code, that does essentially the same thing as the Shiny app, but outputs results (plots of phenophase onset by year) as PDFs
