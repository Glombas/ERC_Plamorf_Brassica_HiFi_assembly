library(ggplot2)
library(tidyverse)
library(stringr)
library(svglite)

setwd('assembly_qc/')

brapahist <- read.table('kmc/histo_m84049_240319_214729_s1.hifi_reads.bc2005.fastq')
ggplot(brapahist,aes(V1,V2)) +
  geom_point(size=2.5) +
  xlab(label = 'k-mer size') +
  ylab(label = 'k-mer frequency') +
  coord_cartesian(xlim = c(10,200),ylim = c(0,1e7)) +
  theme_bw() +
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size = 23))
ggsave(filename = 'kmc/brapa_kmerfreq.png',device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
ggsave(filename = 'kmc/brapa_kmerfreq.svg',device = 'svg',height = 10,width = 12,units = 'in')

bnapushist <- read.table('kmc/histo_m84049_240319_214729_s1.hifi_reads.bc2016.fastq')
ggplot(bnapushist,aes(V1,V2)) +
  geom_point(size=2.5) +
  xlab(label = 'k-mer size') +
  ylab(label = 'k-mer frequency') +
  coord_cartesian(xlim = c(10,200),ylim = c(0,1.5e7)) +
  theme_bw() +
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size = 23))
ggsave(filename = 'kmc/bnapus_kmerfreq.png',device = 'png',height = 10,width = 12,units = 'in',dpi = 600)
ggsave(filename = 'kmc/bnapus_kmerfreq.svg',device = 'svg',height = 10,width = 12,units = 'in')
