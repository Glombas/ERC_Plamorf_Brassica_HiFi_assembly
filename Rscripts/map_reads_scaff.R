# THis script takes mapping files 
library(ggplot2)
library(tidyverse)
library(stringr)
library(svglite)


setwd('assembly_qc')

read_mapping_files <- list.files(path = 'read_coverage_scaffolds/',pattern = 'depth_sort_reads_to_anchored_')

for (fmap in read_mapping_files) {
  map_patternres <- str_match(fmap,'depth_sort_reads_to_anchored_\\s*(.*?)\\s*.fa._every20k.txt')
  refname <- map_patternres[,2]
  assembly_no_org_contigs <- read.table(paste0('organelle_filtered_assembly/anchored_',refname,'.fa.fai')) %>%
    select(V1:V3) %>%
    rename(c('chr'=V1,'bplength'=V2)) %>%
    filter(bplength >= 1000000)
  
  reads_map <- read.table(paste0('read_coverage_scaffolds/',fmap),sep = '\t',fill = T,header = F) %>%
    select(c(V1:V3)) %>%
    rename(c('chr'=V1,'location'=V2,'coverage'=V3)) %>%
    inner_join(assembly_no_org_contigs)
  
  ggplot(reads_map,aes(location/1000000,coverage)) +
    geom_point(size=0.3,colour='darkgreen') +
    facet_wrap(facets = 'chr',scales = 'free') +
    coord_cartesian(ylim = c(0,250)) +
    xlab(paste0('Mapping position in scaffold (Mb) in ',refname)) +
    ylab('coverage (Mb)') +
    theme_bw() +
    theme(
      axis.title = element_text(size = 32),
      axis.text = element_text(size=24)
    )

  ggsave(filename = paste0('mapped_contig_dotplots/',refname,'_read_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  ggsave(filename = paste0('mapped_contig_dotplots/',refname,'_read_mapping.svg'),device = 'svg',height = 10,width = 12,units = 'in')
  
}


# Check mapping of reads to public references to examine A2 C2 mapping

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
    inner_join(assembly_no_org_contigs)
  
  ggplot(reads_map,aes(location/1000000,coverage/59)) +
    geom_point(size=0.3,colour='darkgreen') +
    facet_wrap(facets = 'chr',scales = 'free') +
    coord_cartesian(ylim = c(0,5)) +
    xlab(paste0('Mapping position in scaffold (Mb) in ',refname)) +
    ylab('Normalised read coverage') +
    theme_bw() +
    theme(
      axis.title = element_text(size = 32),
      axis.text = element_text(size=24)
    )
  
  ggsave(filename = paste0('read_coverage_scaffolds/public_refs_check/newCchromtest/',refname,'_read_mapping_norm.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  ggsave(filename = paste0('read_coverage_scaffolds/public_refs_check/newCchromtest/',refname,'_read_mapping_norm.svg'),device = 'svg',height = 10,width = 12,units = 'in')
  
}



### Read mapping to ragtag anchored napus assemblies

read_mapping_files <- list.files(path = 'read_coverage_scaffolds/public_refs_check/ragtag_napus/',
                                 pattern = 'depth_')

for (fmap in read_mapping_files) {
  map_patternres <- str_match(fmap,'depth_\\s*(.*?)\\s*_every20k.txt')
  refname <- map_patternres[,2]
  assembly_no_org_contigs <- read.table(paste0('read_coverage_scaffolds/public_refs_check/ragtag_napus/',refname,'.fai')) %>%
    select(V1:V3) %>%
    rename(c('chr'=V1,'bplength'=V2)) %>%
    filter(bplength >= 1000000) %>%
    filter(!grepl('ptg|JAG|BNapus',chr))
  
  reads_map <- read.table(paste0('read_coverage_scaffolds/public_refs_check/ragtag_napus/',fmap),sep = '\t',fill = T,header = F) %>%
    select(c(V1:V3)) %>%
    rename(c('chr'=V1,'location'=V2,'coverage'=V3)) %>%
    inner_join(assembly_no_org_contigs)
  
  reads_map$chr <- gsub('_RagTag','',reads_map$chr)
  
  ggplot(reads_map,aes(location/1000000,coverage/58)) +
    geom_point(size=0.3,colour='darkgreen') +
    facet_wrap(facets = 'chr',scales = 'free') +
    coord_cartesian(ylim = c(0,4)) +
    xlab('Mapping position in anchored chromosome (Mb)') +
    ylab('Normalised coverage') +
    theme_bw() +
    theme(
      axis.title = element_text(size = 30),
      axis.text = element_text(size=20)
    )
  
  ggsave(filename = paste0('read_coverage_scaffolds/public_refs_check/ragtag_napus/',refname,'ei_read_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  ggsave(filename = paste0('read_coverage_scaffolds/public_refs_check/ragtag_napus/',refname,'ei_read_mapping.svg'),device = 'svg',height = 10,width = 12,units = 'in')
  
}


##### broken contig check

broken_ref <- read.table('../igv_refs/broken_contig.fa.fai') %>%
  select(V1:V2) %>%
  rename(c('chr'=V1,'bplength'=V2))

map_broken_cont <- read.table('bamfiles_mapped_to_ref/broken_contig_napus/depth_sort_out_reads_br_contig_every5k.txt') %>%
  select(c(V1:V3)) %>%
  rename(c('chr'=V1,'location'=V2,'coverage'=V3)) %>%
  inner_join(broken_ref)

ggplot(map_broken_cont,aes(location/1000000,coverage)) +
  geom_point(size=0.3,colour='darkgreen') +
  # geom_col() +
  facet_wrap(facets = 'chr',scales = 'free') +
  coord_cartesian(ylim = c(0,1000)) +
  xlab('Mapping position in scaffold (Mb)') +
  ylab('coverage (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )

