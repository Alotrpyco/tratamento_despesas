library(dplyr)
library(purrr)
library(janitor)
library(writexl)
library(readxl)
library(stringr)

getwd()
setwd("E:/scripts/3.Planilhas_Excel/3.extract")

dados2023 <- read_excel("E:/scripts/3.extract/despesa_empenhado_liquidado_pago_2023.xlsx")
dados2024 <- read_excel("E:/scripts/3.extract/despesa_empenhado_liquidado_pago_2024.xlsx")
dados2025 <- read_excel("E:/scripts/3.extract/despesa_empenhado_liquidado_pago_2025.xlsx")

arquivos <- list.files(
  path = "E:/scripts/3.extract",
  pattern = "\\.xlsx$",
  full.names = TRUE
)

dados_consolidados <- arquivos %>%
  map_dfr(~ read_excel(.x, guess_max = 10000) %>%
            clean_names() %>%
            mutate(ano = str_extract(.x, "\\d{4}")))

write_xlsx(
  dados_consolidados,
  "E:/scripts/3.extract/despesa_empenhado_liquidado_pago.xlsx"
)

names(dados2023)
names(dados2024)
names(dados2025)
names(dados_consolidados)
