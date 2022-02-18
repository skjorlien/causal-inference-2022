# Builds a LaTeX table of the sample size of subgroups
# See the pivoting vignette for how to use pivot functions.

read_csv(here("data/NLSY97_clean.csv")) %>%
  filter(months_incarcerated > 0) %>% 
  # summarize arrests by race and gender
  group_by(race, gender) %>%
  summarize(count = n()) %>%
  
  # pivot the values from race into columns
  pivot_wider(names_from = race, values_from = count) %>%
  
  # rename columns using snakecase
  rename_with(to_title_case) %>%
  
  # create the kable object. Requires booktabs and float LaTeX packages
  kbl(
    caption = "Sample Size of Each Group",
    booktabs = TRUE,
    format = "latex",
    label = "summarystats_n"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>% 
  write_lines(here("tables/n_incarceration_by_racegender.tex"))
  


