# K.Palof    8-29-17
# Figure creation in response to 8-29-17 RKC meeting.
# wants figures for each area with legal and mature biomass.  

# Load packages -------------
library(readxl)

#Load data ----------------
#biomass <- read.csv("./data/redcrab/biomass.csv") no record of historic mature biomass point estimates
# in each year so using 2017 model output

biomass <- read_excel(path = "./data/2017_biomass_model.xlsx")
fishery.status <- read_excel(path = './data/fishery.status.xlsx')
harvest <- read_excel(path = "./data/harvest.xlsx", sheet = 1) # harvest is in pounds.

# Regional biomass ----------------
glimpse(biomass)


# regional figure 

f.regional.fig(biomass, y1 = 646753, y2 = 907431) 
f.regional.table(biomass)

# regional figure with closures/ openings

f.regional.fig(biomass, y1 = 646753, y2 = 907431, closures = 1) 

### regional thresholds -------------------

f.regional.thresholds(biomass)

# Areas -----
# pybus -----

f.regional.fig(biomass, Pybus, y1 = 102618, y2 = 129266) 
f.regional.table(biomass, Pybus)

# gambier ------------

f.regional.fig(biomass, Gambier, y1 = 44763, y2 = 62684) 
f.regional.table(biomass, Gambier)

# Seymour  -----------

f.regional.fig(biomass, Seymour, y1 = 119837, y2 = 147620) 
f.regional.table(biomass, Seymour)


# Peril strait --------

f.regional.fig(biomass, Peril, y1 = 32486, y2 = 67031) 
f.regional.table(biomass, Peril)

#Juneau ----------------

f.regional.fig(biomass, Juneau, y1 = 302966, y2 = 419518) 
f.regional.table(biomass, Juneau)


# lynn sisters ------------

f.regional.fig(biomass, "Lynn Canal", y1 = 14989, y2 = 24799) 
f.regional.table(biomass, "Lynn Canal")

# excursion ---------------------

f.regional.fig(biomass, Excursion, y1 = 29095, y2 = 56413) 
f.regional.table(biomass, Excursion)



# summarize all together 
# png('./results/redcrab/figure_mature.png', res= 300, width = 8, height =11, units = "in")
# grid.arrange(pb, gb, sc, ps, ncol = 1)
# dev.off()
# png('./results/redcrab/figure_mature2.png', res= 300, width = 8, height =8.25, units = "in")
# grid.arrange(jn, lc, ei, ncol = 1)
# dev.off()
