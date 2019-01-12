update.packages(ask = FALSE, checkBuilt = TRUE)
library(readxl)
library(data.table)
library(dplyr)
library(ggplot2)
library(ggvis)
completo  <- read.csv("Dados_v080119.csv")
dados     <- select(completo, -numeroProposta, -dataEmissao, -numeroModalidade, -dataFundacaoTomador, -dataCadastroTomador, -nomeAcionistaMajoritario, -dataAdimissaoAcionistaMajoritario, -cnaeTomador, -prazoMes, -ultimaTaxaAprovadaTomador, -pkCodPro, -CliExercicio_1, -CliExercicio_2, -CliExercicio_3)

