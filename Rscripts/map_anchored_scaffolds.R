library(ggplot2)
library(tidyverse)
setwd('assembly_qc')

chrsnapus <- c('A01','A02','A03','A04','A05','A06','A07','A08','A09','A10',
               'C01','C02','C03','C04','C05','C06','C07','C08','C09')

inputFile <- read.table("organelle_filtered_assembly/anchored_bnapus.markers.txt")

inputgg <- inputFile %>%
  filter(V2 %in% chrsnapus)

ggplot(inputgg,aes(V3/1000000,V5/1000000,colour=V6)) +
  # geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
  geom_point(show.legend = F,size=0.5) +
  facet_wrap(facets = 'V2',scales = 'free') +
  xlab('Position in scaffold (Mb)') +
  ylab('Position in ref genome (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )
ggsave(filename = paste0('mapped_contig_dotplots/bnapus_scaffold_Darmorv10_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
ggsave(filename = paste0('mapped_contig_dotplots/bnapus_scaffold_Darmorv10_mapping.svg'),device = 'svg',height = 10,width = 12,units = 'in')


#############

chrsrapa <- c('A01','A02','A03','A04','A05','A06','A07','A08','A09','A10')

inputFile <- read.table("organelle_filtered_assembly/anchored_brapa.markers.txt")

inputgg <- inputFile %>%
  filter(V2 %in% chrsrapa)

ggplot(inputgg,aes(V3/1000000,V5/1000000,colour=V6)) +
  # geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
  geom_point(show.legend = F,size=0.5) +
  facet_wrap(facets = 'V2',scales = 'free') +
  xlab('Position in scaffold (Mb)') +
  ylab('Position in ref genome (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )
ggsave(filename = paste0('mapped_contig_dotplots/brapa_scaffold_Chiifuv4_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
ggsave(filename = paste0('mapped_contig_dotplots/brapa_scaffold_Chiifuv4_mapping.svg'),device = 'svg',height = 10,width = 12,units = 'in')


############


chrsnapus_daae <- c('CM035446.1','CM035447.1','CM035448.1','CM035449.1','CM035450.1','CM035451.1','CM035452.1',
                    'CM035453.1','CM035454.1','CM035455.1',
               'CM035456.1','CM035457.1','CM035458.1','CM035459.1','CM035460.1','CM035461.1',
               'CM035462.1','CM035463.1','CM035464.1')

inputFile <- read.table("organelle_filtered_assembly/anchored_bnapus_daae.markers.txt")

inputgg <- inputFile %>%
  filter(V2 %in% chrsnapus_daae)

ggplot(inputgg,aes(V3/1000000,V5/1000000,colour=V6)) +
  # geom_segment(aes(x=map_start/1000000,xend =map_end/1000000,y=target_start/1000000,yend = target_end/1000000,colour=contig),show.legend = F) +
  geom_point(show.legend = F,size=0.5) +
  facet_wrap(facets = 'V2',scales = 'free') +
  xlab('Position in scaffold (Mb)') +
  ylab('Position in ref genome (Mb)') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )
ggsave(filename = paste0('mapped_contig_dotplots/bnapus_scaffold_DaAe_mapping.png'),device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
ggsave(filename = paste0('mapped_contig_dotplots/bnapus_scaffold_DaAe_mapping.svg'),device = 'svg',height = 10,width = 12,units = 'in')
