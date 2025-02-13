# This script plots the contigs length distribution for both Brapa and Bnapus

library(ggplot2)
library(tidyverse)
library(forcats)
library(svglite)


setwd('assembly_qc')

indexes <- list.files(path = 'organelle_filtered_assembly/',pattern = '_primary_assembly.no_organelles.fa.fai')

for (f in indexes) {
  ind_patternres <- str_match(f,'\\s*(.*?)\\s*_primary_assembly')
  ind_name <- ind_patternres[,2]
  assembly_indexes <- read.table(paste0('organelle_filtered_assembly/',f)) %>%
  select(V1:V2) %>%
  rename(c('contig'=V1,'bplength'=V2)) %>%
  arrange(desc(bplength))
  
  assembly_indexes$contig <- as.factor(assembly_indexes$contig)
  ggplot(assembly_indexes,aes(fct_rev(fct_reorder(contig,bplength)),bplength/1000000)) +
    geom_col(colour='black',fill='pink') +
    coord_cartesian(xlim = c(0,150)) +
    ylab('length (Mb)') +
    xlab('contig') +
    theme_classic() +
    geom_hline(yintercept = 1,linetype=2,colour='black',linewidth=0.7) +
    annotate(geom = 'text',x=120,y=2,label='1 Mb length cutoff',size=7) +
    theme(
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank(),
      panel.grid.major.y = element_line(color = 'gray',
                                        linewidth = 0.2,
                                        linetype = 1),
      axis.title = element_text(size=22),
      axis.text.y = element_text(size=18)
    )
  
  ggsave(paste0(ind_name,'_contig_summary_plot.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  ggsave(paste0(ind_name,'_contig_summary_plot.svg'),device = 'svg',height = 10,width = 12,units = 'in',dpi = 600)
}


assembly_indexes$contig <- as.factor(assembly_indexes$contig)
ggplot(assembly_indexes,aes(fct_rev(fct_reorder(contig,bplength)),bplength/1000000)) +
  geom_col(colour='black',fill='pink') +
  coord_cartesian(xlim = c(0,150)) +
  ylab('length (Mb)') +
  xlab('contig') +
  theme_classic() +
  geom_hline(yintercept = 1,linetype=2,colour='black',linewidth=0.7) +
  annotate(geom = 'text',x=120,y=2,label='1 Mb length cutoff',size=7) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid.major.y = element_line(color = 'gray',
                                      linewidth = 0.2,
                                      linetype = 1),
    axis.title = element_text(size=22),
    axis.text.y = element_text(size=18)
  )
