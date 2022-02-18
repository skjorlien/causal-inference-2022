# Builds a LaTeX table of mean # months incarcerated by race and gender.
# See the pivoting vignette for how to use pivot functions.

read_csv(here("data/NLSY97_clean.csv")) %>%
  filter(months_incarcerated > 0) %>% 
  # summarize arrests by race and gender
  group_by(race, gender) %>%
  summarize(months_incarcerated = mean(months_incarcerated)) %>%
  
  # pivot the values from race into columns
  pivot_wider(names_from = race, values_from = months_incarcerated) %>%
  
  # rename columns using snakecase
  rename_with(to_title_case) %>%
  
  # create the kable object. Requires booktabs and float LaTeX packages
  kbl(
    caption = "Mean Number of Months Incarcerated in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>% 
  write_lines(here("tables/incarceration_by_racegender.tex"))
  


