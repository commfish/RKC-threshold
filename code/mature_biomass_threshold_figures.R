# K.Palof  10-13-17
# red king crab figures for reviewing a mature male biomass threshold.
# Figures are created using f.regional.fig function in functions.R file

rm(list = ls()) # clear workspace 

source("./code/functions.R")

#Load data ----------------

reg_biomass <- read_excel(path = "./data/regional_biomass.xlsx")
biomass_17 <- read_excel(path = "./data/2017_biomass_model.xlsx", sheet = 1)
harvest <- read_excel(path = "./data/harvest.xlsx", sheet = 1)
fishery.status <- read_excel(path = './data/fishery.status.xlsx')

# data format  -----------
biomass_17 %>% 
  mutate(Location = as.factor(Location)) -> biomass_17

### regional with LT baseline 93-07 ---------------
f.regional.table(biomass_17, startyr = 1993, endyr = 2007)

f.regional.fig(biomass_17, startyr = 1993, endyr = 2007)

# regional, baseline 93-07, closures ------------
f.regional.fig(biomass_17, startyr = 1993, endyr = 2007, closures = fishery.status)

### regional with average baseline from 93 to present ---------
f.regional.table(biomass_17, startyr = 1993, endyr = 2017)

f.regional.fig(biomass_17, startyr = 1993, endyr = 2017)

# regional, baseline 93- present, closures ------------
f.regional.fig(biomass_17, startyr = 1993, endyr = 2017, closures = fishery.status)

### area figures  ----------------
## Pybus ---------------
f.regional.table(biomass_17, region = 'Pybus', startyr = 1993, endyr = 2007)
f.regional.thresholds(biomass_17, region = 'Pybus', startyr = 1993, endyr = 2007)

f.regional.fig(biomass_17, region = 'Pybus', startyr = 1993, endyr = 2007)


