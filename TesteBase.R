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
dados %>% ggvis(~numeroGrupoEconomico, ~TaxaCoberturaLiquidaCalculada, fill = ~ufTomador) %>% layer_points()
dados %>%filter(TaxaCoberturaLiquidaCalculada<10)%>%ggvis(~qtdParcFalencia_MA, ~TaxaCoberturaLiquidaCalculada, fill = ~descricaoModalidade) %>% layer_points()
# Filtro
dadosSP <- dados%>%filter(ufTomador == "SP")
dados_10 <- dados %>%filter(TaxaCoberturaLiquidaCalculada<10)
# Organizar
dados%>%filter(ufTomador == "SP")%>%arrange(CliPasCirculante_1)


# Regressões iniciais
Y<-dados_10$TaxaCoberturaLiquidaCalculada
X<-dados_10
X$TaxaCoberturaLiquidaCalculada=NULL
for (i in 2:86) {
  reg<-lm(Y ~ X[[i]])
  Rsqr<-summary(reg)
  if (!is.na(Rsqr$r.squared) & Rsqr$r.squared > 0.1){
  print(c(i,colnames(X[i]),Rsqr$r.squared))
  }
}
  
  
