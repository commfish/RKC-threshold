# load ----
library(tidyverse)
library(extrafont)
loadfonts(device="win")
windowsFonts(Times=windowsFont("TT Times New Roman"))

theme_set(theme_bw(base_size=12,base_family='Times New Roman')+ 
            theme(panel.grid.major = element_blank(),
                  panel.grid.minor = element_blank()))

# functions ----
f.regional.fig <- function(x, region=NULL, y1, y2, closures=NULL){
  # x = data
  # region = the region of interest
  # y1 = yintercept 1
  # y2 = yintercept 2
  # closures = regional data with closures / openings (set to 1 if desired)
  
  if(missing(region)){
    
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
        geom_hline(yintercept = y1, color = "grey1") +
        geom_hline(yintercept = y2, color = "grey1", lty = 4) %>%
        ggsave("results/regional_biomass.png", device="png",
               dpi=300, height=5.0, width=7.55, units="in")
    
  } else if(missing(region) && !missing(closures)){ 
    
    x %>%
      filter(Location == y) %>%
      gather(type, pounds, legal:mature, factor_key = TRUE) %>%
      ggplot(aes(Year, pounds, group = type)) +
        geom_point(aes(color = fishery.status, shape = type), size =3) +
        geom_line(aes(color = type, group = type)) +
        scale_colour_manual(name = "", 
                            values = c("grey1", "gray75", "grey1", "grey1", "red")) +
        scale_shape_manual(name = "", values = c(16, 1, 20)) +
        ylim(0,1500000) +ggtitle("Survey areas 2017 Model") + 
        ylab("Biomass (lbs)")+ xlab("") +
        theme(plot.title = element_text(hjust =0.5)) +
        scale_x_continuous(breaks = seq(1979, 2017, by =2)) +
        theme(legend.position = c(0.8,0.7)) +
        geom_hline(yintercept = y1, color = "grey1") +
        geom_hline(yintercept = y2, color = "grey1", lty = 4) %>%
        ggsave("results/regional_open_closed.png", device="png",
               dpi=300, height=5.0, width=7.55, units="in")
  } else{

  y = deparse(substitute(region))
  
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
    geom_hline(yintercept = y1, color = "grey1") +
    geom_hline(yintercept = y2, color = "grey1", lty = 4) %>%
    ggsave(paste0("results/", y, ".png"), device="png",
           dpi=300, height=5.0, width=7.55, units="in")
  }
}
f.regional.table <- function(x, region=NULL){
  if(is.null(region)){
    x %>% 
      filter(Year <= 2007) %>% 
      summarise(legal = mean(legal), mature = mean(mature))
  } else {
  y = deparse(substitute(x))
  x %>% 
    filter(Location == y) %>% 
    filter(Year <= 2007) %>% 
    summarise(legal = mean(legal), mature = mean(mature))
  }
}

f.regional.thresholds <- function(x){
  x %>% 
    group_by(Year) %>% 
    summarise(leg = sum(legal), mat = sum(mature)) %>% 
    filter(Year >=1993 & Year <= 2007) %>% 
    summarise(legal_lt = mean(leg), mature_lt = mean(mat)) %>% 
    gather(regional_sum, type, pounds, legal_lt:mature_lt, factor_key = TRUE) %>% 
    mutate(p50 = 0.5 * pounds, 
           p60 = 0.6 * pounds, 
           p70 = 0.7 * pounds, 
           p80 = 0.8 * pounds )
}


