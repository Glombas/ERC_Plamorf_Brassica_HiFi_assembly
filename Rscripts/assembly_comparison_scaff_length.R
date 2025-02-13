library(ggplot2)
library(tidyverse)
setwd('assembly_qc')

comparison_files <- list.files(path = 'organelle_filtered_assembly/',pattern = 'compare_scaffolds.txt')

for (fs in comparison_files) {
  ass_comparison <- read.table(paste0('organelle_filtered_assembly/',fs)) %>%
    rename(c('chr'=V1,'length'=V2,'assembly'=V3))
  species_pat <- str_match(fs,'\\s*(.*?)\\s*_compare_scaffolds.txt')
  species <- species_pat[,2]
  ggplot(ass_comparison,aes(chr,length/1000000,fill=assembly),colour='black') +
    geom_col(position = position_dodge()) +
    scale_fill_manual(values = c("#999999", "#E69F00")) +
    ylab('Length (Mb)') +
    theme_bw()
  
  ggsave(paste0(species,'_scaffold_comparison.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  ggsave(paste0(species,'_scaffold_comparison.svg'),device = 'svg',height = 10,width = 12,units = 'in')
  
  }

