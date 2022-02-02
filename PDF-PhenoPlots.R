library(rnpn)
library(dplyr)
library(lubridate)
rm(list=ls())
setwd("")




cdf <- npn_download_status_data(
  request_source = 'ADD HERE', 
  network_ids = c(72),
  years = c(2010:2020), 
  species_ids = c(3, 98, 61, 82, 1187, 97, 1172, 823, 100, 79, 1189), 
  additional_fields = c("Site_Name", "Network_Name", "Phenophase_Category"),
  climate_data = TRUE
)

cdf=cdf %>%
  dplyr::mutate(year = lubridate::year(observation_date), 
                month = lubridate::month(observation_date), 
                day = lubridate::day(observation_date))

cdf$elev_bands <- cut(cdf$elevation_in_meters, c(-Inf,800,1300,Inf), c("<800m", "800-1300m", ">1300m"))

#Intensity Dataset
#Filter to 95% Intensity
icdf <- subset(cdf, 
               intensity_value == '95% or more' & phenophase_description == 'Leaves',
               select = c(species_id, phenophase_id, common_name, phenophase_description, intensity_value, site_name,
                          elevation_in_meters, elev_bands, tmin_winter, tmin_spring, tmax_winter, 
                          tmax_spring, daylength,individual_id, year, day_of_year))

#Select the earliest DOY of 95% canopy full by year by ind
icdf2 <- icdf %>%
  group_by(year, individual_id, common_name) %>%
  filter(day_of_year == min(day_of_year)) %>%
  mutate(title = paste(common_name, elev_bands, sep = '_'))

#experiment with recreating site phenometrics, not using yet.
icdf3 <- icdf2  %>%
  group_by(year, site_name, common_name)  %>%
  summarize(mean_DOY = mean(day_of_year, na.rm = TRUE))

#Phenophase Status Dataset
#Filter to 1s (yes to phenophase status), get correct columns, and filter to the Phenophase you want to make a PDF for
cdf1 <- subset(cdf, 
               phenophase_status == 1 & phenophase_description == 'Colored leaves' & day_of_year > 182,
               select = c(species_id, phenophase_id, common_name, phenophase_description, site_name,
                          elevation_in_meters, elev_bands, tmin_winter, tmin_spring, tmax_winter, 
                          tmax_spring, daylength,individual_id, year, day_of_year))

#Select the earliest DOY by year by ind
cdf2 <- cdf1 %>%
  group_by(year, individual_id, common_name) %>%
  filter(day_of_year == min(day_of_year)) %>%
  #filter(n() > 1) #drops where this is just one data point for the combo - not working well
  mutate(title = paste(common_name, elev_bands, sep = '_'))


#Create a pdf of plots for all sites - customize the dataset (icdf or cdf) to make the pdfs (also change the Plot title)
pdf(paste("GRSMTreeTrendsCanopyFullbyElev",".pdf",sep=""))
for (i in unique(icdf2$title)){
  cdf_subset <- icdf2[icdf2$title==i,] #keep only rows for that file number
  
  plot(
    cdf_subset$day_of_year~cdf_subset$year, 
    ylab=c("Day of Year"), 
    xlab=c("Year"),
    main=paste("Onset of full canopy in", unique(cdf_subset$title),  sep=" "),
    cex=2, 
    cex.axis=1.5, 
    cex.lab=1.5, 
    pch=21
  )
  abline(fit <- lm(cdf_subset$day_of_year~cdf_subset$year, data=cdf_subset), col='red')
  legend("topleft", bty="n", legend=paste("R2 =", format(summary(fit)$adj.r.squared, digits=4)))
}  
dev.off()

