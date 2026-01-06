# THis script takes mapping files 
library(ggplot2)
library(tidyverse)
library(stringr)
library(svglite)


setwd('assembly_qc')

# Check mapping of reads to public references to examine chromosome dosage

read_mapping_files <- list.files(path = 'read_coverage_scaffolds/public_refs_check/newCchromtest/',
                                 pattern = 'depth_')

for (fmap in read_mapping_files) {
  map_patternres <- str_match(fmap,'depth_\\s*(.*?)\\s*_every20k.txt')
  refname <- map_patternres[,2]
  assembly_no_org_contigs <- read.table(paste0('read_coverage_scaffolds/public_refs_check/newCchromtest/',refname,'.fai')) %>%
    select(V1:V3) %>%
    rename(c('chr'=V1,'bplength'=V2)) %>%
    filter(bplength >= 1000000) %>%
    filter(!grepl('Boleracea_scaffold|Scaffold',chr))
  
  reads_map <- read.table(paste0('read_coverage_scaffolds/public_refs_check/newCchromtest/',fmap),sep = '\t',fill = T,header = F) %>%
    select(c(V1:V3)) %>%
    rename(c('chr'=V1,'location'=V2,'coverage'=V3)) %>%
    inner_join(assembly_no_org_contigs) %>%
    mutate(color = case_when(
      str_starts(.[[1]], "A") ~ "1",
      str_starts(.[[1]], "C") ~ "2",
      TRUE ~ NA_character_
    ))
  reads_map$color <- factor(reads_map$color)
  reads_map$chr <- gsub("C","C0",reads_map$chr)
  
  #plot the mapping coverage normalised for homozygous coverage known from kmer analysis
  ggplot(reads_map,aes(location/1000000,coverage/59,colour=color)) +
    geom_point(size=0.3,show.legend = F) +
    facet_wrap(facets = 'chr',scales = 'free') +
    coord_cartesian(ylim = c(0,3)) +
    xlab('Mapping position in pseudomolecule (Mb)') +
    ylab('Normalised read coverage') +
    theme_bw() +
    scale_color_manual(values = c("#0072B2","#CC79A7")) +
    theme(
      axis.title = element_text(size = 32),
      axis.text = element_text(size=20),
      strip.text.x = element_text(size = 15),
      axis.text.x = element_blank()
    )
  
  ggsave(filename = paste0(refname,'_read_mapping_norm.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  ggsave(filename = paste0(refname,'_read_mapping_norm.svg'),device = 'svg',height = 10,width = 12,units = 'in')
  
}

