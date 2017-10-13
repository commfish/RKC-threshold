# K.Palof copied from B. Williams. 
# function for figure creation for red king crab biomass and threshold analysis 

# load ----
library(tidyverse)
library(extrafont)
loadfonts(device="win")
windowsFonts(Times=windowsFont("TT Times New Roman"))

theme_set(theme_bw(base_size=12,base_family='Times New Roman')+ 
            theme(panel.grid.major = element_blank(),
                  panel.grid.minor = element_blank()))

# functions ----
f.regional.fig <- function(x, region=NULL, startyr, endyr, closures = NULL){
  # x = data
  # region = the region of interest
  # y1 = yintercept 1
  # y2 = yintercept 2
  # closures = regional data with closures / openings (set to 1 if desired)
  
  if(missing(region) && missing(closures)){
    x %>% 
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature)) %>% 
      filter(Year >= startyr & Year <= endyr) %>%
      summarise(legal = mean(legal), mature = mean(mature)) -> out
    
    x %>%
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature)) %>% 
      gather(type, pounds, legal:mature, factor_key = TRUE) %>%
      ggplot(aes(Year, pounds, group = type)) +
      geom_point(aes(color = type, shape = type), size =3) +
      geom_line(aes(color = type, group = type)) +
      scale_colour_manual(name = "", values = c("grey1", "grey1")) +
      scale_shape_manual(name = "", values = c(16, 1)) +
      ylim(0,1500000) + ggtitle("Survey areas 2017 Model") +
      ylab("Biomass (lbs)") + xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =5)) +
      theme(legend.position = c(0.8,0.7)) +
      geom_hline(yintercept = out$legal, color = "grey1") +
      geom_hline(yintercept = out$mature, color = "grey1", lty = 4) 
      ggsave(paste0("results/regional_biomass", endyr, ".png"), plot = last_plot(), device="png",
             dpi=300, height=5.0, width=7.55, units="in")
  } else if(missing(region) && !missing(closures)){ 
    x %>% 
      left_join(closures) -> x
    x %>% 
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature)) %>% 
      filter(Year >= startyr & Year <= endyr) %>%
      summarise(legal = mean(legal), mature = mean(mature)) -> out
    
    x %>%
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature), fishery.status = unique(fishery.status)) %>% 
      gather(type, pounds, legal:mature, factor_key = TRUE) %>%
      ggplot(aes(Year, pounds, group = type)) +
      geom_point(aes(color = fishery.status, shape = type), size =3) +
      geom_line(aes(color = type, group = type)) +
      scale_colour_manual(name = "", 
                          values = c("grey1", "gray55", "grey1", "red")) +
      scale_shape_manual(name = "", values = c(16, 1, 20)) +
      ylim(0,1500000) +ggtitle("Survey areas 2017 Model") + 
      ylab("Biomass (lbs)")+ xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =5)) +
      theme(legend.position = c(0.8,0.7)) +
      geom_hline(yintercept = out$legal, color = "grey1") +
      geom_hline(yintercept = out$mature, color = "grey1", lty = 4) 
      ggsave(paste0("results/regional_open_closed", endyr, ".png"), plot = last_plot(), device="png",
             dpi=300, height=5.0, width=7.55, units="in")
  } else{
    
    y = deparse(substitute(region))
    x %>% 
      filter(Location == y) %>% 
      filter(Year >= startyr & Year <= endyr) %>% 
      summarise(legal = mean(legal), mature = mean(mature)) -> out
    x %>%
      filter(Location == y) %>%
      gather(type, pounds, legal:mature, factor_key = TRUE) %>%
      ggplot(aes(Year, pounds, group = type)) +
      geom_point(aes(color = type, shape = type), size =3) +
      geom_line(aes(color = type, group = type)) +
      scale_colour_manual(name = "", values = c("grey1", "grey1")) +
      scale_shape_manual(name = "", values = c(16, 1)) +
      ylim(0,1500000) + ggtitle("Survey areas 2017 Model") +
      ylab("Biomass (lbs)") + xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =2)) +
      theme(legend.position = c(0.8,0.7)) +
      geom_hline(yintercept = out$legal, color = "grey1") +
      geom_hline(yintercept = out$mature, color = "grey1", lty = 4) %>%
      ggsave(paste0("results/", y, ".png"), plot = last_plot(), device="png",
             dpi=300, height=5.0, width=7.55, units="in")
  }
}


f.regional.table <- function(x, region=NULL, startyr = NULL, endyr = NULL){
  if(is.null(region)){
    x %>% 
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature)) %>% 
      filter(Year >= startyr & Year <= endyr) %>%
      summarise(legal = mean(legal), mature = mean(mature))
  } else {
    y = region
    x %>% 
      filter(Location == y) %>% 
      filter(Year >= startyr & Year <= endyr) %>% 
      summarise(legal = mean(legal), mature = mean(mature))
  }
}


