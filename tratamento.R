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
setwd()

tratar_mes <- function(df) {
  
  if (!"num_mes" %in% names(df)) {
    return(df)
  }
  
  df %>%
    mutate(
      mes = case_when(
        num_mes == 1  ~ "Janeiro",
        num_mes == 2  ~ "Fevereiro",
        num_mes == 3  ~ "Março",
        num_mes == 4  ~ "Abril",
        num_mes == 5  ~ "Maio",
        num_mes == 6  ~ "Junho",
        num_mes == 7  ~ "Julho",
        num_mes == 8  ~ "Agosto",
        num_mes == 9  ~ "Setembro",
        num_mes == 10 ~ "Outubro",
        num_mes == 11 ~ "Novembro",
        num_mes == 12 ~ "Dezembro",
        TRUE ~ NA_character_
      )
    ) %>%
    select(-any_of(c("num_mes", "num_exercicio")))
}


arquivos <- list.files(
  path = "caminho",
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
  "caminho/despesa_empenhado_liquidado_pago.xlsx"
)


glimpse(dados_consolidados)
names(dados_consolidados)
