# Marek Glombik 2024-10-23
#This script prepares mapping files for synteny analysis and chromosome length files from .fai indexed references
library(tidyverse)
require(data.table)
library(syntenyPlotteR)

setwd('assembly_qc')

read_files <- list.files(path = 'synteny_analysis/',pattern = 'extracted_')
df1 <- data.frame()
for (fread in read_files) {
  read_patternres <- str_match(fread,'extracted_\\s*(.*?)\\s*.paf')
  refname <- read_patternres[,2]
  
  base_file <- read.table(paste0('synteny_analysis/',fread))
  base_file$V2 <- gsub('CM035447.1','A02',base_file$V2)
  base_file$V2 <- gsub('CM035457.1','C02',base_file$V2)
  base_file <- base_file %>%
    filter(grepl('A02|C02',V2))
  readnames <- as.data.frame(unique(base_file[,1]))
  colnames(readnames) <- 'V1'
  setDT(readnames)
  setDT(base_file)
  filt_base_file <- base_file[readnames,mult='first',on='V1',nomatch=0L]
  filt_base_file$cultivar <- refname
  if (length(df1)==0) {
    df1 <- rbind(filt_base_file,df1,fill=T)
  } else {
    df1 <- df1 %>%
      inner_join(filt_base_file,by='V1')
  }
}

anc_to_darm <- df1[,c('V2.x','V3.x','V4.x','V2.y.y','V3.y.y','V4.y.y','V5.y.y','cultivar.x','cultivar.y.y')]
my_to_anc <- df1[,c('V2.y','V3.y','V4.y','V2.x','V3.x','V4.x','V5.x','cultivar.y','cultivar.x')]

write.table(anc_to_darm,file = 'synteny_analysis/anc_to_darm', sep = '\t',quote = F,row.names = F,col.names = F)
write.table(my_to_anc,file = 'synteny_analysis/my_to_anc', sep = '\t',quote = F,row.names = F, col.names = F)


draw.linear('synteny_analysis/darm_anc_my_lengths.txt','synteny_analysis/anc_to_darm','synteny_analysis/my_to_anc')

