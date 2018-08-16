# Exploratory Data Analysis
library(tidyverse)
library(MASS)
library(nycflights13)

# For discrete variables use a geom bar
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
diamonds %>% count(cut)

# For continuous variables a histogram will be more useful
ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
diamonds %>% count(cut_width(carat, 0.5))


smaller <- diamonds %>% filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) + geom_histogram(binwidth = 0.1)


ggplot(data = smaller, mapping = aes(x = carat, fill=cut)) + geom_histogram(binwidth = 0.01)


ggplot(data = faithful, mapping = aes(x = eruptions)) + geom_histogram(binwidth = 0.25)


ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)


ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
  coord_cartesian(ylim = c(0, 50),xlim=c(20,70))


unusual <- diamonds %>%  filter(y < 3 | y > 20) %>% dplyr::select(price, x, y, z) %>% arrange(y)


diamonds2 <- diamonds %>% filter(between(y, 3, 20))
diamonds2 <- diamonds %>% mutate(y = ifelse(y < 3 | y > 20, NA, y))

ggplot(data = diamonds2, mapping = aes(x = x, y = y,color=cut)) + 
  geom_point(na.rm=TRUE)


nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)


ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_boxplot()

diamonds_sample <- diamonds[sample(nrow(diamonds),nrow(diamonds)*0.05),]

ggplot(data = diamonds_sample) + geom_point(mapping = aes(x = carat, y = price, color=cut), alpha=1/2)


ggplot(data = diamonds) +
  geom_bin2d(mapping = aes(x = carat, y = price))

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.5), color=cut_width(carat, 0.5)) )


ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 10)))



ggplot(data = faithful) + 
  geom_point(mapping = aes(x = eruptions, y = waiting,color=eruptions>3.2))



library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))

ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))


ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()