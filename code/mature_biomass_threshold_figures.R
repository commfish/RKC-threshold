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

# set defaults 

startyr = 1993 
endyr = 2007
currentyr = 2017
percent = 0.50

### regional with LT baseline 93-07 ---------------
f.regional.table(biomass_17, startyr = 1993, endyr = 2007)
t1 <- f.regional.thresholds(biomass_17, startyr = 1993, endyr = 2007)

f.regional.fig(biomass_17, startyr, endyr, currentyr)

f.threshold.fig(biomass_17, startyr, endyr, currentyr)

# regional, baseline 93-07, closures ------------
f.regional.fig(biomass_17, startyr, endyr, currentyr, closures = fishery.status)

### regional with average baseline from 93 to present ---------
# endyr here needs to be 2017 to get an average from 1993 to present.
t2 <- f.regional.thresholds(biomass_17, startyr = 1993, endyr = 2017)

f.regional.table(biomass_17, startyr = 1993, endyr = 2017)
f.regional.fig(biomass_17, startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, startyr, endyr = 2017, currentyr)
# regional, baseline 93- present, closures ------------
f.regional.fig(biomass_17, startyr, endyr = 2017, currentyr, closures = fishery.status)

### area figures  ----------------
## Pybus ---------------
f.regional.table(biomass_17, region = 'Pybus', startyr, endyr)
p1 <- f.regional.thresholds(biomass_17, region = 'Pybus', startyr, endyr)
p2 <- f.regional.thresholds(biomass_17, region = 'Pybus', startyr, endyr = 2017)

f.regional.fig(biomass_17, region = 'Pybus', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Pybus', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Pybus', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Pybus', startyr, endyr = 2017, currentyr)

## Gambier ---------------
f.regional.table(biomass_17, region = 'Gambier', startyr, endyr)

g1 <- f.regional.thresholds(biomass_17, region = 'Gambier', startyr, endyr)
g2 <- f.regional.thresholds(biomass_17, region = 'Gambier', startyr, endyr = 2017)

f.regional.fig(biomass_17, region = 'Gambier', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Gambier', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Gambier', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Gambier', startyr, endyr = 2017, currentyr)

## Seymour ---------------
f.regional.table(biomass_17, region = 'Seymour', startyr, endyr)

s1 <- f.regional.thresholds(biomass_17, region = 'Seymour', startyr, endyr)
s2 <- f.regional.thresholds(biomass_17, region = 'Seymour', startyr, endyr = 2017)

f.regional.fig(biomass_17, region = 'Seymour', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Seymour', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Seymour', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Seymour', startyr, endyr = 2017, currentyr)

## Lynn Canal ---------------
f.regional.table(biomass_17, region = 'Lynn Canal', startyr, endyr)

l1 <- f.regional.thresholds(biomass_17, region = 'Lynn Canal', startyr, endyr)
l2 <- f.regional.thresholds(biomass_17, region = 'Lynn Canal', startyr, endyr = 2017)

f.regional.fig(biomass_17, region = 'Lynn Canal', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Lynn Canal', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Lynn Canal', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Lynn Canal', startyr, endyr = 2017, currentyr)

## Juneau ---------------
f.regional.table(biomass_17, region = 'Juneau', startyr, endyr)

j1 <- f.regional.thresholds(biomass_17, region = 'Juneau', startyr, endyr)
j2 <- f.regional.thresholds(biomass_17, region = 'Juneau', startyr, endyr = 2017)
                            
f.regional.fig(biomass_17, region = 'Juneau', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Juneau', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Juneau', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Juneau', startyr, endyr = 2017, currentyr)

## Peril ---------------
f.regional.table(biomass_17, region = 'Peril', startyr, endyr)

ps1 <- f.regional.thresholds(biomass_17, region = 'Peril', startyr, endyr)
ps2 <- f.regional.thresholds(biomass_17, region = 'Peril', startyr, endyr = 2017)

f.regional.fig(biomass_17, region = 'Peril', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Peril', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Peril', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Peril', startyr, endyr = 2017, currentyr)


## Excursion ---------------
f.regional.table(biomass_17, region = 'Excursion', startyr, endyr)

e1 <- f.regional.thresholds(biomass_17, region = 'Excursion', startyr, endyr)
e2 <- f.regional.thresholds(biomass_17, region = 'Excursion', startyr, endyr = 2017)

f.regional.fig(biomass_17, region = 'Excursion', startyr, endyr, currentyr)
f.regional.fig(biomass_17, region = 'Excursion', startyr, endyr = 2017, currentyr)
f.threshold.fig(biomass_17, region = 'Excursion', startyr, endyr, currentyr)
f.threshold.fig(biomass_17, region = 'Excursion', startyr, endyr = 2017, currentyr)


# table summary of averages and thresholds ---------

t1 %>% 
  bind_rows(p1) %>% 
  bind_rows(s1) %>% 
  bind_rows(l1) %>% 
  bind_rows(j1) %>% 
  bind_rows(ps1) %>% 
  bind_rows(e1) %>% 
  select(legal, mature, p50mat, end, survey_area) -> t2007


t2 %>% 
  bind_rows(p2) %>% 
  bind_rows(s2) %>% 
  bind_rows(l2) %>% 
  bind_rows(j2) %>% 
  bind_rows(ps2) %>% 
  bind_rows(e2) %>% 
  select(legal, mature, p50mat, end, survey_area) -> t2017
