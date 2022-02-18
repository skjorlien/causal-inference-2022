# Builds a bar graph with total number of months incarcerated on the y axis 
# and race/gender on the x axis. 

read_csv(here("data/NLSY97_clean.csv")) %>%
  group_by(race, gender) %>%
  summarize(months_incarcerated = mean(months_incarcerated)) %>%
  ggplot(aes(race, months_incarcerated, fill = gender)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(
      x = "Race", 
      y = "Mean # of Months Incarcerated", 
      fill = "Gender",
      title = "Mean Number of Months Incarcerated in 2002 by Race and Gender") +
    theme_minimal() +
    scale_fill_economist()



ggsave(here("figures/incarceration_by_racegender.png"), width=8, height=4.5)
