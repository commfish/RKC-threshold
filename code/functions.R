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
f.regional.fig <- function(x, region=NULL, startyr, endyr, currentyr, closures = NULL){
  # x = data
  # region = the region of interest
  # startyr = starting year to calculate long term average 
  # endyr = end year to calculate long term average
  # currentyr = the current year used to generate the biomass estimates
  # closures = file with open or closed and year 
  
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
      ylim(0,1500000) + ggtitle(paste0("Survey areas ", currentyr, " Model, ", startyr, "-", endyr, " average" )) +
      ylab("Biomass (lbs)") + xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =5)) +
      theme(legend.position = c(0.8,0.7)) +
      geom_hline(yintercept = out$legal, color = "grey1", lty = 4) +
      geom_hline(yintercept = out$mature, color = "grey1") 
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
      ylim(0,1500000) + ggtitle(paste0("Survey areas ", currentyr, " Model, ", startyr, "-", endyr, " average" )) +
      ylab("Biomass (lbs)")+ xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =5)) +
      theme(legend.position = c(0.8,0.7)) +
      geom_hline(yintercept = out$legal, color = "grey1", lty = 4) +
      geom_hline(yintercept = out$mature, color = "grey1") 
      ggsave(paste0("results/regional_open_closed", endyr, ".png"), plot = last_plot(), device="png",
             dpi=300, height=5.0, width=7.55, units="in")
  } else{
    
    y = region
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
      ggtitle(paste0( currentyr, " Model ", y, " survey area, ", startyr, "-", endyr, " average")) +
      ylab("Biomass (lbs)") + xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =5)) +
      theme(legend.position = c(0.8,0.7)) +
      geom_hline(yintercept = out$legal, color = "grey1", lty = 4) +
      geom_hline(yintercept = out$mature, color = "grey1") 
      ggsave(paste0("results/", y, endyr, ".png"), plot = last_plot(), device="png",
             dpi=300, height=5.0, width=7.55, units="in")
  }
}

f.threshold.fig <- function(x, region=NULL, startyr, endyr, currentyr, percent){
  # x = data
  # region = the region of interest
  # startyr = starting year to calculate long term average 
  # endyr = end year to calculate long term average
  # currentyr = the current year used to generate the biomass estimates
  # percent = the ratio (i.e. 0.50 used to create a threshold when applied to the mean)
  
  if(missing(region)){
    x %>% 
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature)) %>% 
      filter(Year >= startyr & Year <= endyr) %>%
      summarise(legal = mean(legal), mature = mean(mature)) %>% 
      mutate(p_mat = percent*mature) -> out
    
    x %>%
      group_by(Year) %>% 
      summarise(legal = sum(legal), mature = sum(mature)) %>% 
      gather(type, pounds, legal:mature, factor_key = TRUE) %>%
      ggplot(aes(Year, pounds, group = type)) +
      geom_point(aes(color = type, shape = type), size =3) +
      geom_line(aes(color = type, group = type)) +
      scale_colour_manual(name = "", values = c("grey1", "grey1")) +
      scale_shape_manual(name = "", values = c(16, 1)) +
      ylim(0,1500000) + ggtitle(paste0("Survey areas ", currentyr ," model, ", percent, " threshold, ", startyr, "-", endyr, " average" )) +
      ylab("Biomass (lbs)") + xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by =5)) +
      theme(legend.position = c(0.8,0.7)) +
      #geom_hline(yintercept = out$legal, color = "grey1") +
      geom_hline(yintercept = out$mature, color = "grey1") +
      geom_hline(yintercept = out$p_mat, color = "red", lty = 4)
    ggsave(paste0("results/regional_biomass_threshold", endyr, ".png"), plot = last_plot(), device="png",
           dpi=300, height=5.0, width=7.55, units="in")
  } else{
    
    y = region
    x %>% 
      filter(Location == y) %>% 
      filter(Year >= startyr & Year <= endyr) %>% 
      summarise(legal = mean(legal), mature = mean(mature)) %>% 
      mutate(p_mat = percent*mature) -> out
    x %>%
      filter(Location == y) %>%
      gather(type, pounds, legal:mature, factor_key = TRUE) %>%
      ggplot(aes(Year, pounds, group = type)) +
      geom_point(aes(color = type, shape = type), size =3) +
      geom_line(aes(color = type, group = type)) +
      scale_colour_manual(name = "", values = c("grey1", "grey1")) +
      scale_shape_manual(name = "", values = c(16, 1)) +
      ggtitle(paste0( currentyr, " Model ", y, " survey area, ", percent, " threshold, ", startyr, "-", endyr, " average" )) +
      ylab("Biomass (lbs)") + xlab("") +
      theme(plot.title = element_text(hjust =0.5)) +
      scale_x_continuous(breaks = seq(1979, 2017, by = 5)) +
      theme(legend.position = c(0.8,0.7)) +
      #geom_hline(yintercept = out$legal, color = "grey1") +
      geom_hline(yintercept = out$mature, color = "grey1") +
      geom_hline(yintercept = out$p_mat, color = "red", lty = 4)
    ggsave(paste0("results/threshold", y, endyr, percent, ".png"), plot = last_plot(), device="png",
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

f.regional.thresholds <- function(x, region=NULL, startyr = NULL, endyr = NULL){
  if(is.null(region)){
  x %>% 
    group_by(Year) %>% 
    summarise(legal = sum(legal), mature = sum(mature)) %>% 
    filter(Year >= startyr & Year <= endyr) %>% 
    summarise(legal = mean(legal), mature = mean(mature)) %>% 
    mutate(p50mat = 0.5 * mature, 
           p60mat = 0.6 * mature, 
           p70mat = 0.7 * mature, 
           p80mat = 0.8 * mature )
  } else {
    y = region
    x %>% 
      filter(Location == y) %>% 
      filter(Year >= startyr & Year <= endyr) %>% 
      summarise(legal = mean(legal), mature = mean(mature))%>% 
      mutate(p50mat = 0.5 * mature, 
             p60mat = 0.6 * mature, 
             p70mat = 0.7 * mature, 
             p80mat = 0.8 * mature )
  }
}
