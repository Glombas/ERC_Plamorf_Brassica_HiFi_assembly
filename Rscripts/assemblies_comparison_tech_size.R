# plot previous assemblies

library(ggplot2)
library(tidyverse)

prev_refs <- read.table('brassica_assemblies.tab',header = T,sep = '\t')
colnames(prev_refs) <- gsub('\\.','_',colnames(prev_refs))
prev_refs$Species <- gsub('Brassica_napus','nap',prev_refs$Species)
prev_refs$Species <- gsub('Brassica_rapa','rap',prev_refs$Species)
prev_refs <- prev_refs %>%
  filter(!Sequencing_method=='N/A')

ggplot(prev_refs,aes(round(as.numeric(Assembly_size__Mb_)),Gene_models,colour = Sequencing_method)) +
  geom_label(data = prev_refs,aes(round(as.numeric(Assembly_size__Mb_)),Gene_models,label=Cultivar_Genotype),size = 4.5) +
  # annotate(prev_refs,geom = 'text',label='Cultivar_genotype',x='Assembly_size__Mb_',y='Sequencing_method') +
  facet_wrap(facets = 'Species') +
  coord_cartesian(xlim = c(min(round(as.numeric(prev_refs$Assembly_size__Mb_))),max(round(as.numeric(prev_refs$Assembly_size__Mb_)))),
                           ylim = c(min(prev_refs$Gene_models),max(prev_refs$Gene_models))) +
  xlim(150,1250) +
  xlab('Assembly size (Mb)') +
  ylab('Sequencing methods used') +
  theme_bw() +
  theme(
    axis.title = element_text(size = 25),
    axis.text = element_text(size=20),
    strip.text = element_text(size=20),
  )
ggsave(paste0('assemblies_comp.png'),device = 'png',height = 10,width = 18,units = 'in',dpi = 600)
ggsave(paste0('assemblies_comp.svg'),device = 'svg',height = 10,width = 12,units = 'in')

  
  