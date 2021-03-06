# An�lise de Dados de Viagens 

# Carregamento de pacotes 

library(dplyr)
library(ggplot2)
library(rmarkdown)
library(tidyr)
library(tinytex)

# Carregamento de Dados

viagens <- read.csv(
  file = "C:/Users/Rob�rio/Desktop/Mestrado em Economia/7 - Econometria/Rotinas do Rstudio/Script Rstudio - Comandos B�sicos/Curso B�sico - Linguagem R/2019_Viagem.csv",
  sep = ';',
  dec = ','
)

# Estat�stica Descritiva 

summary(viagens)
summary(viagens$Valor.passagens)

viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")
viagens$data.inicio.formatada

# Alterando Formato de Dados

glimpse(viagens)
viagens$data.inicio <- as.Date(viagens$Per�odo...Data.de.in�cio, "%d/%m/%Y")
glimpse(viagens)

# Histograma e Estat�stica 

hist(viagens$Valor.passagens)
summary(viagens$Valor.passagens)

# Estat�stica (Propor��o)

table(viagens$Situa��o)
prop.table(table(viagens$Situa��o))*100

# Visualizando os valores em um boxplot

boxplot(viagens$Valor.passagens)
sd(viagens$Valor.passagens)
colSums(is.na(viagens))
str(viagens$Situa��o)

# Qual o valor gasto por �rg�o ?

p1 <- viagens %>%
  group_by(Nome.do.�rg�o.superior) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)
names(p1) <- c("orgao", "valor")
p1

# Criando Gr�fico 1 

ggplot(p1, aes(x= reorder(orgao, valor), y = valor))+
  geom_bar(stat = "identity")+
  coord_flip()+
  labs(x="Valor", y="�rg�os")

# Qual � o valor gasto por cidade?

p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)
names(p2) <- c('destino', 'valor')
p2

# Gr�fico 2 

ggplot(p2, aes(x = reorder (destino, valor), y = valor))+
  geom_bar(stat = "identity", fill = "#0ba791")+
  geom_text(aes (label = valor), vjust=0.3, size=3)+
  coord_flip()+
  labs(x="Destino", y="Valor")
options(scipen = 999)

# Formata��o de Data 

viagens$data.inicio <- as.Date(viagens$Per�odo...Data.de.in�cio, "%d/%m/%Y")
glimpse(viagens)
viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")
viagens$data.inicio.formatada

# Qual � a quantidade de viagens por m�s?

p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(Identificador.do.processo.de.viagem))
head(p3)

# Gr�fico 3

ggplot(p3, aes(x = data.inicio.formatada, y = qtd, group = 1))+
  geom_line()+
  geom_point()

