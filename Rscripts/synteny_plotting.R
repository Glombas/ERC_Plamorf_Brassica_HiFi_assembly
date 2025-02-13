#This script performs synteny analysis based on minimap mapping reads to various references
library(ggplot2)
library(tidyverse)
library(syntenyPlotteR)

setwd('assembly_qc')

read_files <- list.files(path = 'synteny_analysis/',pattern = 'prepared_')
chr_names_napus <- read_table('synteny_analysis/synteny_darm_ancestral_anchored_lengths_full.txt')
chr_names_napus <- unique(unlist(chr_names_napus[,1]))


for (fread in read_files) {
  read_patternres <- str_match(fread,'prepared_\\s*(.*?)\\s*_\\s*(.*?)\\s*.csv')
  qname <- read_patternres[,2]
  tname <- read_patternres[,3]
  base_file <- read.csv(paste0('synteny_analysis/',fread),header = F)
  base_file$V1 <- gsub('CM035446.1','A1',
                       gsub('CM035447.1','A2',
                            gsub('CM035448.1','A3',
                                 gsub('CM035449.1','A4',
                                      gsub('CM035450.1','A5',
                                           gsub('CM035451.1','A6',
                                                gsub('CM035452.1','A7',
                                                     gsub('CM035453.1','A8',
                                                          gsub('CM035454.1','A9',
                                                               gsub('CM035455.1','A10',base_file$V1))))))))))
  base_file$V1 <- gsub('CM035456.1','C1',
                       gsub('CM035457.1','C2',
                            gsub('CM035458.1','C3',
                                 gsub('CM035459.1','C4',
                                      gsub('CM035460.1','C5',
                                           gsub('CM035461.1','C6',
                                                gsub('CM035462.1','C7',
                                                     gsub('CM035463.1','C8',
                                                          gsub('CM035464.1','C9',base_file$V1)))))))))
  base_file$V1 <- gsub('C0','C',base_file$V1)
  base_file$V1 <- gsub('A0','A',base_file$V1)
  base_file$V4 <- gsub('C0','C',base_file$V4)
  base_file$V4 <- gsub('A0','A',base_file$V4)
  base_file <- base_file %>%
    filter(V1 %in% chr_names_napus) %>%
    filter(V4 %in% chr_names_napus)
  base_file$V8 <- qname
  base_file$V9 <- tname
  write.table(base_file,paste0('synteny_analysis/synteny_',qname,'_',tname,'.txt'),quote = F,sep = '\t',
              row.names = F,col.names = F)
}

syn_files <- list.files(path = 'synteny_analysis/',pattern = 'synteny_')
pathsyn <- 'synteny_analysis/'

draw.linear('bnapus_synteny',"synteny_analysis/synteny_darm_ancestral_anchored_lengths_full.txt", 'synteny_analysis/synteny_darmor_ancestral.txt',
            'synteny_analysis/synteny_anchored_ancestral.txt',
            directory = 'synteny_analysis/',colours = c("#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                        "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                        "#CE1256","#7BCCC4",
                                                        "#B3CDE3", "#BAE4BC","#F368A1","#4DAF4A", "#8DA0CB",
                                                        "#FECC5C","#FBB4B9","#969696","#465626",
                                                        "#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                        "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                        "#CE1256","#7BCCC4",
                                                        "#B3CDE3", "#BAE4BC","#F368A1","#4DAF4A", "#8DA0CB",
                                                        "#FECC5C","#FBB4B9","#969696","#465626"))


### Whole genome Brapa

read_files <- list.files(path = 'synteny_analysis/brapa/',pattern = 'prepared_')

chr_names <- read_table('synteny_analysis/brapa/chiifu_myrapa_z1_lengths.txt')
chr_names <- unique(unlist(chr_names[,1]))

for (fread in read_files) {
  read_patternres <- str_match(fread,'prepared_\\s*(.*?)\\s*_\\s*(.*?)\\s*.csv')
  qname <- read_patternres[,2]
  tname <- read_patternres[,3]
  base_file <- read.csv(paste0('synteny_analysis/brapa/',fread),header = F)
  base_file$V1 <- gsub('CM060803.1','A01',
                       gsub('CM060799.1','A02',
                            gsub('CM060800.1','A03',
                                 gsub('CM060804.1','A04',
                                      gsub('CM060807.1','A05',
                                           gsub('CM060808.1','A06',
                                                gsub('CM060802.1','A07',
                                                     gsub('CM060806.1','A08',
                                                          gsub('CM060805.1','A09',
                                                               gsub('CM060801.1','A10',base_file$V1))))))))))
  base_file <- base_file %>%
    filter(V1 %in% chr_names) %>%
    filter(V4 %in% chr_names)
  base_file$V8 <- qname
  base_file$V9 <- tname
  write.table(base_file,paste0('synteny_analysis/brapa/synteny_',qname,'_',tname,'.txt'),quote = F,sep = '\t',
              row.names = F,col.names = F)
}


draw.linear('rapa_synteny_z1',
            'synteny_analysis/brapa/chiifu_myrapa_z1_lengths.txt',
            'synteny_analysis/brapa/synteny_chiifu_rapa.txt',
            'synteny_analysis/brapa/synteny_z1_rapa.txt',
            directory = 'synteny_analysis/brapa/',colours = c("#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                              "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                              "#CE1256","#7BCCC4"))

                                                              "#B2E2E2", "#B3CDE3", "#BAE4BC", "#BAE4B3", "#CCCCCC", "#FDBE85", 
                                                              "#FDCC8A", "#BDC9E1", "#BDC9E1", "#D7B5D8", "#CBC9E2", "#FBB4B9", 
                                                               "#A1DAB4", "#FED98E", "#FECC5C", "#80CDC1", 
                                                              "#B8E186", "#A6DBA0", "#B2ABD2", "#92C5DE", "#BABABA", "#ABD9E9", 
                                                              "#A6D96A", "#ABDDA4", "#FDC086", "#7570B3", "#B2DF8A", "#CCEBC5", 
                                                              "#CBD5E8", "#4DAF4A", "#8DA0CB", "#BEBADA", "#6BAED6", "#66C2A4", 
                                                              "#8C96C6", "#7BCCC4", "#74C476", "#969696", "#FD8D3C", "#FC8D59", 
                                                              "#74A9CF", "#67A9CF", "#DF65B0", "#9E9AC8", "#F768A1"))


### Whole genome Brapa-ragtag

read_files <- list.files(path = 'synteny_analysis/brapa/rt_ro18',pattern = 'filtered_\\s*(.*?)\\s*_prepared.csv')

chr_names <- read_table('synteny_analysis/brapa/chiifu_myrapa_z1_lengths.txt')
chr_names <- unique(unlist(chr_names[,1]))

for (fread in read_files) {
  read_patternres <- str_match(fread,'filtered_\\s*(.*?)\\s*_rt_\\s*(.*?)\\s*_mummer.txt_prepared.csv')
  qname <- read_patternres[,2]
  tname <- read_patternres[,3]
  base_file <- read.csv(paste0('synteny_analysis/brapa/rt_ro18/',fread),header = F)
  base_file$V1 <- gsub('_RagTag','',base_file$V1)
  base_file$V4 <- gsub('_RagTag','',base_file$V4)
  base_file$V1 <- gsub('CM060803.1','A01',
                       gsub('CM060799.1','A02',
                            gsub('CM060800.1','A03',
                                 gsub('CM060804.1','A04',
                                      gsub('CM060807.1','A05',
                                           gsub('CM060808.1','A06',
                                                gsub('CM060802.1','A07',
                                                     gsub('CM060806.1','A08',
                                                          gsub('CM060805.1','A09',
                                                               gsub('CM060801.1','A10',base_file$V1))))))))))
  base_file <- base_file %>%
    filter(V1 %in% chr_names) %>%
    filter(V4 %in% chr_names)
  base_file$V8 <- qname
  base_file$V9 <- tname
  write.table(base_file,paste0('synteny_analysis/brapa/rt_ro18/synteny_rt_',qname,'_',tname,'.txt'),quote = F,sep = '\t',
              row.names = F,col.names = F)
}


draw.linear('rapa_synteny_rt_ro18-anchor',
            'synteny_analysis/brapa/rt_ro18/chiifu_raparo18_ro18_lengths.txt',
            'synteny_analysis/brapa/rt_ro18/synteny_rt_chiifu_raparo18.txt',
            'synteny_analysis/brapa/rt_ro18/synteny_rt_ro18_raparo18.txt',
            directory = 'synteny_analysis/brapa/rt_ro18/',colours = c("#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                              "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                              "#CE1256","#7BCCC4"))
### Whole genome Brapa-ragtag-haplotypes separately

read_files <- list.files(path = 'synteny_analysis/brapa/rt_haps',pattern = 'filtered_\\s*(.*?)\\s*_prepared.csv')
chr_names <- read_table('synteny_analysis/brapa/rt_haps/hap1_chiifu_hap2_lengths.txt')
chr_names <- unique(unlist(chr_names[,1]))

for (fread in read_files) {
  read_patternres <- str_match(fread,'filtered_rt_\\s*(.*?)\\s*_\\s*(.*?)\\s*.txt_prepared.csv')
  qname <- read_patternres[,2]
  tname <- read_patternres[,3]
  base_file <- read.csv(paste0('synteny_analysis/brapa/rt_haps/',fread),header = F)
  base_file$V1 <- gsub('_RagTag','',base_file$V1)
  base_file$V4 <- gsub('_RagTag','',base_file$V4)
  base_file <- base_file %>%
    filter(V1 %in% chr_names) %>%
    filter(V4 %in% chr_names)
  base_file$V8 <- qname
  base_file$V9 <- tname
  write.table(base_file,paste0('synteny_analysis/brapa/rt_haps/synteny_rt_',qname,'_',tname,'.txt'),quote = F,sep = '\t',
              row.names = F,col.names = F)
}


draw.linear('rapa_synteny_rt_hapsr',
            'synteny_analysis/brapa/rt_haps/hap1_chiifu_hap2_lengths.txt',
            'synteny_analysis/brapa/rt_haps/synteny_rt_hap2rapa_chiifu_corr.txt',
            'synteny_analysis/brapa/rt_haps/synteny_rt_hap1rapa_chiifu_corr.txt',
            directory = 'synteny_analysis/brapa/rt_haps/',colours = c("#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                                      "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                                      "#CE1256","#7BCCC4"))

### Whole genome ragtag bnapus

read_files <- list.files(path = 'synteny_analysis/bnapus/rt/man_corr_c5c6',pattern = 'filtered_\\s*(.*?)\\s*_prepared.csv')
chr_names_napus <- read_table('synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_darm_anchored_ancestral_lengths_full.txt')
chr_names_napus <- unique(unlist(chr_names_napus[,1]))
chr_names_napus <- gsub('A0','A',chr_names_napus)
chr_names_napus <- gsub('C0','C',chr_names_napus)

for (fread in read_files) {
  read_patternres <- str_match(fread,'filtered_\\s*(.*?)\\s*_rt_\\s*(.*?)\\s*.txt_prepared.csv')
  qname <- read_patternres[,2]
  tname <- read_patternres[,3]
  base_file <- read.csv(paste0('synteny_analysis/bnapus/rt/man_corr_c5c6/',fread),header = F)
  base_file$V1 <- gsub('_RagTag','',base_file$V1)
  base_file$V4 <- gsub('_RagTag','',base_file$V4)
  base_file$V1 <- gsub('CM035446.1','A1',
                       gsub('CM035447.1','A2',
                            gsub('CM035448.1','A3',
                                 gsub('CM035449.1','A4',
                                      gsub('CM035450.1','A5',
                                           gsub('CM035451.1','A6',
                                                gsub('CM035452.1','A7',
                                                     gsub('CM035453.1','A8',
                                                          gsub('CM035454.1','A9',
                                                               gsub('CM035455.1','A10',base_file$V1))))))))))
  base_file$V1 <- gsub('CM035456.1','C1',
                       gsub('CM035457.1','C2',
                            gsub('CM035458.1','C3',
                                 gsub('CM035459.1','C4',
                                      gsub('CM035460.1','C5',
                                           gsub('CM035461.1','C6',
                                                gsub('CM035462.1','C7',
                                                     gsub('CM035463.1','C8',
                                                          gsub('CM035464.1','C9',base_file$V1)))))))))
  base_file$V4 <- gsub('CM035446.1','A1',
                       gsub('CM035447.1','A2',
                            gsub('CM035448.1','A3',
                                 gsub('CM035449.1','A4',
                                      gsub('CM035450.1','A5',
                                           gsub('CM035451.1','A6',
                                                gsub('CM035452.1','A7',
                                                     gsub('CM035453.1','A8',
                                                          gsub('CM035454.1','A9',
                                                               gsub('CM035455.1','A10',base_file$V4))))))))))
  base_file$V4 <- gsub('CM035456.1','C1',
                       gsub('CM035457.1','C2',
                            gsub('CM035458.1','C3',
                                 gsub('CM035459.1','C4',
                                      gsub('CM035460.1','C5',
                                           gsub('CM035461.1','C6',
                                                gsub('CM035462.1','C7',
                                                     gsub('CM035463.1','C8',
                                                          gsub('CM035464.1','C9',base_file$V4)))))))))
  base_file$V1 <- gsub('C0','C',base_file$V1)
  base_file$V1 <- gsub('A0','A',base_file$V1)
  base_file$V4 <- gsub('C0','C',base_file$V4)
  base_file$V4 <- gsub('A0','A',base_file$V4)
  base_file <- base_file %>%
    filter(V1 %in% chr_names_napus) %>%
    filter(V4 %in% chr_names_napus)
  base_file$V8 <- qname
  base_file$V9 <- tname
  write.table(base_file,paste0('synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_',qname,'_',tname,'.txt'),quote = F,sep = '\t',
              row.names = F,col.names = F)
}


draw.linear('bnapus_synteny_rt_anchor_daae',"synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_daae_anchored_ancestral_lengths_full.txt",
            'synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_Daae_daae_man_corr.txt',
            # 'synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_insilico_napdaae.txt',
            directory = 'synteny_analysis/bnapus/rt/man_corr_c5c6/',colours = c("#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                                                "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                                                "#CE1256","#7BCCC4",
                                                                                "#B3CDE3", "#BAE4BC","#F368A1","#4DAF4A", "#8DA0CB",
                                                                                "#FECC5C","#FBB4B9","#969696","#465626"))

draw.linear('bnapus_synteny_rt_anchor_darmor',"synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_darm_anchored_ancestral_lengths_full.txt",
            'synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_Darmor_darmor_man_corr.txt',
            # 'synteny_analysis/bnapus/rt/man_corr_c5c6/synteny_insilico_napdarmor.txt',
            directory = 'synteny_analysis/bnapus/rt/man_corr_c5c6/',colours = c("#000000", "#E69F00", "#56B4E9", "#009E73", 
                                                                                "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
                                                                                "#CE1256","#7BCCC4",
                                                                                "#B3CDE3", "#BAE4BC","#F368A1","#4DAF4A", "#8DA0CB",
                                                                                "#FECC5C","#FBB4B9","#969696","#465626"))


