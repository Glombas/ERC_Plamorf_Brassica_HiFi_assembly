# CDS mapping to refs

library(ggplot2)
library(tidyverse)

setwd('assembly_qc')

bnap_darm_cds_map <- read.table('blast_cds/bnapus/out_blast_cds_ragtag.txt')
bnap_darm_cds_map <- read.table('blast_cds/bnapus/out_blast_cds_ragtag.txt') %>%
  select(V1:V2) %>%
  distinct()
colnames(bnap_darm_cds_map) <- c('query_darmor','target_assembly')
bnap_darm_cds_map$query_chr <- substr(bnap_darm_cds_map$query_darmor,1,3)
bnap_darm_cds_map$target_chr <- substr(bnap_darm_cds_map$target_assembly,1,3)
bnap_darm_cds_map$rowns <- row_number(bnap_darm_cds_map)
bnap_darm_cds_map$hit <- 'no'
bnap_darm_cds_map$hit[bnap_darm_cds_map$query_chr == bnap_darm_cds_map$target_chr] <- 'yes'
bnap_darm_cds_map$hom_hit <- 'no'
bnap_darm_cds_map$hom_hit[substr(bnap_darm_cds_map$query_chr,2,3) == substr(bnap_darm_cds_map$target_chr,2,3) &
                            substr(bnap_darm_cds_map$query_chr,1,1) == 'A' & substr(bnap_darm_cds_map$target_chr,1,1) == 'C'] <- 'A->C'
bnap_darm_cds_map$hom_hit[substr(bnap_darm_cds_map$query_chr,2,3) == substr(bnap_darm_cds_map$target_chr,2,3) &
                            substr(bnap_darm_cds_map$query_chr,1,1) == 'C' & substr(bnap_darm_cds_map$target_chr,1,1) == 'A'] <- 'C->A'



ggplot(bnap_darm_cds_map, aes(query_chr,rowns,fill=hom_hit),color='black') +
  geom_tile() +
  scale_fill_manual(values = c('pink','turquoise','darkblue')) +
  theme_light()
ggsave('blast_cds/bnapus/gene_blast_HE_identification_raw',device = 'png',height = 10,width = 18,units = 'in',dpi = 600)

