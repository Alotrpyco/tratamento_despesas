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
setwd("E:/Setur/planilhas")

dados2022 <- read_excel("E:/Setur/planilhas/despesa_empenhado_liquidado_pago_2022_siafe_gerado_em_19-09-2025.xlsx")
dados2023 <- read_excel("E:/Setur/planilhas/despesa_empenhado_liquidado_pago_2023_siafe_gerado_em_19-09-2025.xlsx")
dados2024 <- read_excel("E:/Setur/planilhas/despesa_empenhado_liquidado_pago_2024_siafe_gerado_em_19-09-2025.xlsx")
dados2025 <- read_excel("E:/Setur/planilhas/despesa_empenhado_liquidado_pago_2025_siafe_gerado_em_14-01-2026.xlsx")

arquivos <- list.files(
  path = "E:/Setur/planilhas",
  pattern = "\\.xlsx$",
  full.names = TRUE
)

dados_consolidados <- arquivos %>%
  map_dfr(~ read_excel(.x, guess_max = 10000) %>%
            clean_names() %>%
            mutate(ano = str_extract(.x, "\\d{4}")))

write_xlsx(
  dados_consolidados,
  "E:/Setur/planilhas/despesa_empenhado_liquidado_pago.xlsx"
)

names(dados2023)
names(dados2024)
names(dados2025)
names(dados_consolidados)
