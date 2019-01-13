update.packages(ask = FALSE, checkBuilt = TRUE)
library(readxl)
library(data.table)
library(dplyr)
library(ggplot2)
library(ggvis)
library(corrplot)
completo  <- read.csv("Dados_v080119.csv",na.strings = "NULL",sep = ",", encoding = "latin1")
dados     <- select(completo, -numeroProposta, -dataEmissao, -numeroModalidade, -nomeAcionistaMajoritario, -dataAdimissaoAcionistaMajoritario, -cnaeTomador, -prazoMes, -ultimaTaxaAprovadaTomador, -pkCodPro, -CliExercicio_1, -CliExercicio_2, -CliExercicio_3)
# Transformar certas colunas para factors
dados$id<-as.factor(dados$id)
dados$grupoRamo<-as.factor(dados$grupoRamo)
dados$numeroCobertura<-as.factor(dados$numeroCobertura)
dados$coberturaObrigatoria<-as.factor(dados$coberturaObrigatoria)
dados$cnpjCorretora<-as.factor(dados$cnpjCorretora)
dados$cliCodigo<-as.factor(dados$cliCodigo)
dados$numeroGrupoEconomico<-as.factor(dados$numeroGrupoEconomico)
dados$dataFundacaoTomador<-as.Date(dados$dataFundacaoTomador, format = "%d/%m/%Y")
dados$dataCadastroTomador<-as.Date(dados$dataCadastroTomador, format = "%d/%m/%Y")


# Gráficos
dados %>% ggvis(~dataFundacaoTomador, ~TaxaCoberturaLiquidaCalculada, fill = ~ufTomador) %>% layer_points()
dados %>%filter(TaxaCoberturaLiquidaCalculada<1)%>%ggvis(~qntdEmissaoGrupoEconomico, ~TaxaCoberturaLiquidaCalculada, fill = ~ufTomador) %>% layer_points()
# Filtro
dadosSP <- dados%>%filter(ufTomador == "SP")
# Organizar
dados%>%filter(ufTomador == "SP")%>%arrange(CliPasCirculante_1)

for (i in 2:86) {
  reg<-lm(Y ~ X[[i]])
  Ftest<-anova(reg)
  if (!is.na(Ftest$`Pr(>F)`[1]) & Ftest$`Pr(>F)`[1] < 0.05){
  print(i)
  }
}
  
  
