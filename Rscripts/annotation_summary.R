# compare stats from gff files
library(ggplot2)
library(tidyverse)

rapa_fp_fai <- read.table('assembly_qc/braker_check/brapa_fp_full_cds.fa.fai') %>%
  select(V1:V2) %>%
  add_column(V3 = 'brapa_fp')
rapa_chiifu_fai <- read.table('assembly_qc/braker_check/Brapa_chiifu_v41_cds.fa.fai') %>%
  select(V1:V2) %>%
  add_column(V3 = 'brapa_chiifu')
rapa_ro18_fai <- read.table('assembly_qc/braker_check/Brassica_rapa_ro18_cds.fa.fai') %>%
  select(V1:V2) %>%
  add_column(V3 = 'brapa_ro18')
colnames(rapa_fp_fai) <- c('gene','length','cultivar')
colnames(rapa_chiifu_fai) <- c('gene','length','cultivar')
colnames(rapa_ro18_fai) <- c('gene','length','cultivar')

rapa_all <- rbind(rapa_chiifu_fai,rapa_fp_fai,rapa_ro18_fai)

ggplot(rapa_all,aes(x=cultivar,y=length,fill=cultivar)) +
  geom_violin(show.legend = F) +
  scale_fill_manual(values = c("#E69F00", "#56B4E9", "#009E73")) +
  coord_cartesian(ylim = c(0,5000)) +
  theme_classic() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )
ggsave('assembly_qc/braker_check/rapa_compare.png',device = 'png',height = 10,width = 18,units = 'in',dpi = 600)

# brapa_fp has a tail compared to the other two: cutoff at 150 bp minimum length
dim(rapa_fp_fai[rapa_fp_fai$length<150,])
# 87 transcripts < 150 bp length



# Bnapus:

napus_fp_fai <- read.table('assembly_qc/braker_check/bnapus_fp_full_cds.fa.fai') %>%
  select(V1:V2) %>%
  add_column(V3 = 'bnapus_fp')
napus_darmor_fai <- read.table('assembly_qc/braker_check/BnapusDarmor-bzh_cds.fa.fai') %>%
  select(V1:V2) %>%
  add_column(V3 = 'bnapus_darmor')
napus_daae_fai <- read.table('assembly_qc/braker_check/DaAe_cds.fa.fai') %>%
  select(V1:V2) %>%
  add_column(V3 = 'bnapus_daae')
colnames(napus_fp_fai) <- c('gene','length','cultivar')
colnames(napus_darmor_fai) <- c('gene','length','cultivar')
colnames(napus_daae_fai) <- c('gene','length','cultivar')

napus_all <- rbind(napus_darmor_fai,napus_fp_fai,napus_daae_fai)

ggplot(napus_all,aes(x=cultivar,y=length,fill=cultivar)) +
  geom_violin(show.legend = F) +
  scale_fill_manual(values = c("#E69B90", "#E2B4E9", "#B22E73")) +
  coord_cartesian(ylim = c(0,5000)) +
  theme_classic() +
  theme(
    axis.title = element_text(size = 32),
    axis.text = element_text(size=24)
  )
ggsave('assembly_qc/braker_check/napus_compare.png',device = 'png',height = 10,width = 18,units = 'in',dpi = 600)

# bnapus has a tail: cutoff at 150 bp minimum length
dim(napus_fp_fai[napus_fp_fai$length<150,])
# 97 transcripts < 150 bp length
