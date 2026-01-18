install.packages("dplyr")
install.packages("purrr")
install.packages("janitor")
install.packages("writexl")
install.packages("readxl")
install.packages("stringr")

library(dplyr)
library(purrr)
library(janitor)
library(writexl)
library(readxl)
library(stringr)

getwd()
setwd("path")
tratar_mes <- function(df) {
  df %>%
    mutate(
      mes_num = str_extract(as.character(mes),"\\d{1,2}"),
      mes_num = as.integer(mes_num),
      mes = case_when(mes_num == 1 ~ "Janeiro",
                      mes_num == 2 ~ "Fevereiro",
                      mes_num == 3 ~ "Março",
                      mes_num == 4 ~ "Abril",
                      mes_num == 5 ~ "Maio",
                      mes_num == 6 ~ "Junho",
                      mes_num == 7 ~ "Julho",
                      mes_num == 8 ~ "Agosto",
                      mes_num == 9 ~ "Setembro",
                      mes_num == 10 ~ "Outubro",
                      mes_num == 11 ~ "Novembro",
                      mes_num == 12 ~ "Dezembro",
                      TRUE ~ NA_character_
                      )
    ) %>%
    select(-mes_num)
}


dados2022 <- read_excel("path")
dados2023 <- read_excel("path")
dados2024 <- read_excel("path")
dados2025 <- read_excel("path")

arquivos <- list.files(
  path = "P:/SUPERINTENDÊNCIA ADMINISTRATIVA/SAPOFC/SERGIO/3.Planilhas_Excel/3.extract",
  pattern = "\\.xlsx$",
  full.names = TRUE
)

dados_consolidados <- arquivos %>%
  map_dfr(~ read_excel(.x, guess_max = 10000) %>%
            clean_names() %>%
            tratar_mes() %>%
            mutate(ano = str_extract(.x, "\\d{4}")))

write_xlsx(
  dados_consolidados,
  "path/despesa_empenhado_liquidado_pago.xlsx"
)


glimpse(dados2022)
names(dados2022)
names(dados2023)
names(dados2024)
names(dados2025)
names(dados_consolidados)
