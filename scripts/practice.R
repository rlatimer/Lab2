#packages
install.packages("fivethirtyeight")
remotes::install_github("fivethirtyeightdata/fivethirtyeightdata")
library(fivethirtyeight)
library(fivethirtyeightdata)
library(tidyverse)
library(janitor)

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
  ggplot(aes(date, mentions, color = hurricane)) +
  geom_line() +
  facet_wrap(~hurricane) +
  theme_minimal()
plot1

#part2
plot2 <- google_trends_longer %>%
  ggplot(aes(date, mentions, fill = hurricane)) +
  geom_area(position = "dodge", alpha = 0.8) +
  theme_minimal()
plot2

#part3
plot3 <- google_trends_longer %>%
  ggplot(aes(date, mentions, color = hurricane)) +
  geom_area() +
  scale_fill_continuous(low = "white", high = "red") +
  theme_minimal()

#part 4

# google_trends_longer_landfall <- google_trends_longer %>%
#   mutate(landfall = 0) %>%
#   mutate(landfall = ifelse(
#     hurricane == "harvey_us" & date == "2017-08-25" |
#     hurricane == "irma_us" & date == "2017-09-10" |
#     hurricane == "maria_us" & date == "2017-09-20",
#     1, 0))
#probably not the way Daniel intended....

landfall <- data.frame(hurricane = c("harvey_us", "irma_us", "maria_us"),
                       date = as.Date(c("2017-08-25", "2017-09-10", "2017-09-20")))

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
