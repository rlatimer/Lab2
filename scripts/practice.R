#packages
install.packages("fivethirtyeight")
install.packages("scico")
remotes::install_github("fivethirtyeightdata/fivethirtyeightdata")
library(fivethirtyeight)
library(fivethirtyeightdata)
library(tidyverse)
library(janitor)
library(scico)

#datasets
google_trends <- google_trends
tv_states <- tv_states
comic_characters <- comic_characters

#visualizing google trends data
google_trends_longer <- google_trends %>%
  pivot_longer(cols = starts_with("hurricane"),
               names_to = "hurricane",
               names_prefix = "hurricane_",
               values_to = "mentions")

#part 1
plot1 <- google_trends_longer %>%
  ggplot(aes(date, mentions)) +
  geom_line(aes(color = hurricane)) +
  theme_minimal()
plot1

# plot1 <- google_trends_longer %>%
#   ggplot(aes(date, mentions, color = hurricane)) +
#   geom_line() +
#   theme_minimal()
#they are visually identical, but is there any tangible difference between the two?

#part2
plot2 <- google_trends_longer %>%
  ggplot(aes(date, mentions)) +
  geom_area(aes(fill = hurricane), position = "dodge", alpha = 0.8) +
  theme_minimal()
plot2
#This one show up fine but there is an error message:
#[[[[Width not defined. Set with `position_dodge(width = ?)`]]]


#part3

# plot3 <- google_trends_longer %>%
#   ggplot(aes(date, mentions)) +
#   geom_area(aes(fill = hurricane)) +
#   scico:: scale_fill_scico(palette = "tokyo") +
#   theme_minimal()
# plot3
# #Error: Discrete value supplied to continuous scale
# How do I change the scales so color is mapped to a continuous scale? Hurricane is a categorical variable...


plot3 <- google_trends_longer %>%
  group_by(date) %>%
  summarize(total = sum(mentions)) %>%
  ggplot(aes(date, mentions)) +
  geom_area(aes(fill = ment)) +

  Maybe change it to
levels(google_trends_longer$hurricane)

data_plot3$hurricane = as.numeric(levels(data_plot3$hurricane))[data_plot3$hurricane]

data_plot3 <- google_trends_longer %>%
  mutate(hurricane = factor(hurricane)

plot3 <- data_plot3 %>%
  ggplot(aes(date, mentions)) +
  geom_area(aes(fill = hurricane)) +
  scico:: scale_fill_scico(palette = "tokyo") +
  theme_minimal()
plot3


#part 4

# google_trends_longer_landfall <- google_trends_longer %>%
#   mutate(landfall = 0) %>%
#   mutate(landfall = ifelse(
#     hurricane == "harvey_us" & date == "2017-08-25" |
#     hurricane == "irma_us" & date == "2017-09-10" |
#     hurricane == "maria_us" & date == "2017-09-20",
#     1, 0))
#probably not the way Daniel intended.... starting over

landfall <- data.frame(hurricane = c("harvey_us", "irma_us", "maria_us"),
                       date = as.Date(c("2017-08-25", "2017-09-10", "2017-09-20")),
                       Ref = c("Harvey landfall", "Irma landfall", "Maria landfall"),
                       stringsAsFactors = FALSE)

plot4 <- google_trends_longer %>%
  ggplot(aes(date, mentions, fill = hurricane)) +
  geom_area(position = "dodge", alpha = 0.8) +
  geom_vline(data = landfall, aes(xintercept=as.numeric(date[c(1,2,3)]))) +
  theme_minimal()
plot4

#part 5
plot5 <- google_trends_longer %>%
  ggplot(aes(date, mentions, fill = hurricane)) +
  geom_area(position = "dodge", alpha = 0.8) +
  geom_vline(data = landfall, aes(xintercept=as.numeric(date[c(1,2,3)])), linetype=4) +
  geom_text(mapping = aes(x = date,
                          y = 100,
                          label = Ref,
                          hjust = center,
                          vjust = 0),
            data = landfall) +
  labs(title = "US Google Search Interest on Hurricanes",
       x = "Date",
       y = "Search Interest",
       label = "Hurricane",
       caption = "Search interest measured in search term popularity relative to peak popularity
       in the given region and time period (with 100 as peak popularity)") +
  scale_fill_discrete(name  ="Hurricane",
                      breaks=c("harvey_us", "irma_us", "jose_us", "maria_us"),
                      labels=c("Harvey", "Irma", "Jose", "Maria")) +
  theme_minimal()

plot5



comic_plot_4 <- comic_characters %>%
  count(gender_type = sex, align) %>%
  mutate(gender_ratio = n/N) %>%
  #tabyl(gender_type, align) %>% #returns dataframe with counts with sex as row and align as column,
  ggplot(aes(gender_ratio, align, fill = gender_type)) +
  geom_col() +
  facet_wrap(~align) +
  theme_minimal()

