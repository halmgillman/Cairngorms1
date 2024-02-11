# Loading libraries
library(tidyverse)
library(readxl)
library(janitor)

# Data input
download.file(
    "https://data.spatialhub.scot/dataset/0c903180-1778-4507-a486-9b07a1757f13/resource/88af8062-8394-42b8-8a9b-204311156fcf/download/download_turbines_2022v1.xlsx", # nolint
    "data/df1_renewable_energy_sites.xlsx"
)
df1_renewable_energy_sites <- read_excel(
  "data/df1_renewable_energy_sites.xlsx"
) %>%
  mutate(Class = factor(
    Class,
    levels = c(
      "Micro and Small",
      "Medium",
      "Large",
      "Very Large",
      "Not Known"
    )
  ))

# Formatting and summarising
no_of_sites <- nrow(df1_renewable_energy_sites)

construction_status_summary <- tabyl(
  df1_renewable_energy_sites$Status
) %>%
  select(Status = 1, `#` = 2, `%` = 3) %>%
  mutate(
    Status = case_when(
      Status == "U_Construction" ~ "Under Construction",
      Status == "Scoping_Screening" ~ "Scoping / Screening",
      .default = Status
    ),
    `%` = (round(`%`, 3) * 100)
  )

class_summary <- tabyl(df1_renewable_energy_sites$Class) %>%
  select(Class = 1, `#` = 2, `%` = 3) %>%
  mutate(`%` = (round(`%`, 3) * 100)
  )
