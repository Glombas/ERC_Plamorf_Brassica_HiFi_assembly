# THis script takes mapping files 
library(ggplot2)
library(tidyverse)
library(stringr)
library(svglite)


setwd('assembly_qc')

mapping_files <- list.files(path = 'bamfiles_mapped_to_ref/',pattern = 'no_org_map')
ZScontigs <- data.frame(rep('GWHANRE000000',19),seq(01,19))
colnames(ZScontigs) <-c('id','id2')
ZScontigs$id2 <- sprintf('%02d', ZScontigs$id2)
ZScontigs <- ZScontigs %>%
  unite(cl,id,id2,sep='') %>%
  unlist()

for (fmap in mapping_files) {
  map_patternres <- str_match(fmap,'no_org_map_-\\s*(.*?)\\s*.paf')
  refname <- map_patternres[,2]
  ass_patternres <- str_match(fmap,'\\s*(.*?)\\s*_no_org_map_-')
  ass_name <- ass_patternres[,2]
  assembly_no_org_contigs <- read.table(paste0('organelle_filtered_assembly/',ass_name,'_primary_assembly.no_organelles.fa.fai')) %>%
    select(V1:V2) %>%
    rename(c('contig'=V1,'bplength'=V2)) %>%
    filter(bplength >= 1000000)
  
  contigs_map <- read.table(paste0('bamfiles_mapped_to_ref/',fmap),sep = '\t',fill = T,header = F) %>%
    select(c(V1,V3,V4,V6,V8,V9,V10)) %>%
    rename(c(contig=V1,map_start=V3,map_end=V4,chr=V6,target_start=V8,target_end=V9,matching_bps=V10)) %>%
    filter(!grepl('JAUJLN|BNapus_Darmor_BZH_scaffold',chr)) %>% # filtering out contigs in Zicatai, Darmor reference
    mutate(perc_match = matching_bps/(map_end-map_start)*100) %>%
    arrange(map_start) %>%
    inner_join(assembly_no_org_contigs)
  
  if (refname=='ZS11') {
    contigs_map <- contigs_map %>%
      filter(chr %in% ZScontigs)
  }

  ggplot(contigs_map,aes(map_start/1000000,target_start/1000000,colour=contig)) +
    geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
    facet_wrap(facets = 'chr',scales = 'free') +
    xlab('Mapping position in contig (Mb)') +
    ylab('Mapping position in ref genome (Mb)') +
    theme_bw() +
    theme(
      axis.title = element_text(size = 32),
      axis.text = element_text(size=24)
  )

  # ggsave(filename = paste0('mapped_contig_dotplots/',refname,'_',ass_name,'_contig_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
  # ggsave(filename = paste0('mapped_contig_dotplots/',refname,'_',ass_name,'_contig_mapping.svg'),device = 'svg',height = 10,width = 12,units = 'in')

}

####### broken contig

setwd('assembly_qc')

mapping_files <- list.files(path = 'bamfiles_mapped_to_ref/broken_contig_napus/',pattern = 'minimap')

for (fmap in mapping_files) {
  map_patternres <- str_match(fmap,'broken_contig_\\s*(.*?)\\s*_minimap.paf')
  refname <- map_patternres[,2]
  assembly_no_org_contigs <- read.table(paste0('bamfiles_mapped_to_ref/broken_contig_napus/',refname,'.fai')) %>%
    select(V1:V2) %>%
    rename(c('chr'=V1,'bplength'=V2)) %>%
    filter(bplength >= 1000000)
  
  contigs_map <- read.table(paste0('bamfiles_mapped_to_ref/broken_contig_napus/',fmap),sep = '\t',fill = T,header = F) %>%
    select(c(V1,V3,V4,V6,V8,V9,V10)) %>%
    rename(c(contig=V1,map_start=V3,map_end=V4,chr=V6,target_start=V8,target_end=V9,matching_bps=V10)) %>%
    filter(!grepl('JAGKQM|BNapus_Darmor_BZH_scaffold',chr)) %>% # filtering out contigs in Zicatai, Darmor reference
    mutate(perc_match = matching_bps/(map_end-map_start)*100) %>%
    arrange(map_start) %>%
    inner_join(assembly_no_org_contigs)
  
  c5c6_contig_map <- contigs_map[contigs_map$chr=='C5' | contigs_map$chr=='C6' |
                                   contigs_map$chr=='C05' | contigs_map$chr=='C06' |
                                   contigs_map$chr=='CM035460.1' | contigs_map$chr=='CM035461.1',]
  darmor_c5c6 <- contigs_map[contigs_map$chr=='C05' | contigs_map$chr=='C06',]
  
  ggplot(c5c6_contig_map,aes(map_start/1000000,target_start/1000000,colour=contig)) +
    geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
    facet_wrap(facets = 'chr',scales = 'free') +
    xlab('Mapping position in contig (Mb)') +
    ylab('Mapping position in ref genome (Mb)') +
    theme_bw() +
    theme(
      axis.title = element_text(size = 32),
      axis.text = element_text(size=24)
    )
  
  ggsave(filename = paste0('bamfiles_mapped_to_ref/broken_contig_napus/',refname,'_','broken_contig_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
}


assembly_no_org_contigs <- read.table('bamfiles_mapped_to_ref/broken_contig_napus/darmor.fai') %>%
  select(V1:V2) %>%
  rename(c('chr'=V1,'bplength'=V2)) %>%
  filter(bplength >= 1000000)

contigs_map <- read.table('bamfiles_mapped_to_ref/homcovBnapus_no_org_map_-Darmor.paf',sep = '\t',fill = T,header = F) %>%
  select(c(V1,V3,V4,V5,V6,V8,V9,V10)) %>%
  rename(c(contig=V1,map_start=V3,map_end=V4,strand=V5,chr=V6,target_start=V8,target_end=V9,matching_bps=V10)) %>%
  filter(!grepl('JAGKQM|BNapus_Darmor_BZH_scaffold',chr)) %>% # filtering out contigs in Zicatai, Darmor reference
  mutate(perc_match = matching_bps/(map_end-map_start)*100) %>%
  arrange(map_start) %>%
  inner_join(assembly_no_org_contigs)

darmor_c5c6 <- contigs_map[contigs_map$chr=='C05' | contigs_map$chr=='C06',]
darmor_a7c6 <- contigs_map[contigs_map$chr=='A07' | contigs_map$chr=='C06',]
darmor_c5c9 <- contigs_map[contigs_map$chr=='C05' | contigs_map$chr=='C09',]
darmor_a6_inversion <- contigs_map[contigs_map$chr=='A06',]

ptg6ctg <- contigs_map[contigs_map$contig=='ptg000006l',]
ptg7ctg <- contigs_map[contigs_map$contig=='ptg000007l',]


ggplot(ptg7ctg,aes(map_start/1000000,target_start/1000000,colour=contig)) +
  geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
  facet_wrap(facets = 'chr',scales = 'free') +
  xlab('Mapping position in contig (Mb)') +
  ylab('Mapping position in ref genome (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )


# Now checking brapa segments
rapa_assembly_no_org_contigs <- read.table('igv_read_mapping/rapa_inspector/chiifu.fai') %>%
  select(V1:V2) %>%
  rename(c('chr'=V1,'bplength'=V2)) %>%
  filter(bplength >= 1000000)

rapa_contigs_map <- read.table('bamfiles_mapped_to_ref/homcovBrapa_no_org_map_-Chiifu.paf',sep = '\t',fill = T,header = F) %>%
  select(c(V1,V3,V4,V5,V6,V8,V9,V10)) %>%
  rename(c(contig=V1,map_start=V3,map_end=V4,strand=V5,chr=V6,target_start=V8,target_end=V9,matching_bps=V10)) %>%
  # filter(!grepl('JAGKQM|BNapus_Darmor_BZH_scaffold',chr)) %>% # filtering out contigs in Zicatai, Darmor reference
  mutate(perc_match = matching_bps/(map_end-map_start)*100) %>%
  arrange(map_start) %>%
  inner_join(rapa_assembly_no_org_contigs)


a5chrrapa <- rapa_contigs_map[rapa_contigs_map$chr=='A05',]

ggplot(a5chrrapa,aes(map_start/1000000,target_start/1000000,colour=contig)) +
  geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
  facet_wrap(facets = 'chr',scales = 'free') +
  xlab('Mapping position in contig (Mb)') +
  ylab('Mapping position in ref genome (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )




# Now checking brapa nextDenovo assembly contigs to see how several chromosomes are resolved

rapa_assembly_no_org_contigs <- read.table('igv_read_mapping/rapa_inspector/chiifu.fai') %>%
  select(V1:V2) %>%
  rename(c('chr'=V1,'bplength'=V2)) %>%
  filter(bplength >= 1000000)

rapa_contigs_map <- read.table('bamfiles_mapped_to_ref/nextdenovo/nextdenovo_rapa-Chiifu41.paf',sep = '\t',fill = T,header = F) %>%
  select(c(V1,V3,V4,V5,V6,V8,V9,V10)) %>%
  rename(c(contig=V1,map_start=V3,map_end=V4,strand=V5,chr=V6,target_start=V8,target_end=V9,matching_bps=V10)) %>%
  # filter(!grepl('JAGKQM|BNapus_Darmor_BZH_scaffold',chr)) %>% # filtering out contigs in Zicatai, Darmor reference
  mutate(perc_match = matching_bps/(map_end-map_start)*100) %>%
  arrange(map_start) %>%
  inner_join(rapa_assembly_no_org_contigs)


a5chrrapa <- rapa_contigs_map[rapa_contigs_map$chr=='A05',]

ggplot(rapa_contigs_map,aes(map_start/1000000,target_start/1000000,colour=contig)) +
  geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
  facet_wrap(facets = 'chr',scales = 'free') +
  xlab('Mapping position in contig (Mb)') +
  ylab('Mapping position in ref genome (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )

