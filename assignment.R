
# Loading packages --------------------------------------------------------

library(tidyverse)

# Assignment --------------------------------------------------------------

iris <- as_tibble(iris)

# Question #1

iris1 <- rename(iris, sepal_length = Sepal.Length, sepal_width = Sepal.Width, petal_length = Petal.Length, petal_width = Petal.Width, species = Species) 

# Question #2

iris2 <- mutate(iris1, sepal_length = sepal_length * 10, sepal_width = sepal_width * 10, petal_length = petal_length * 10, petal_width = petal_width * 10)

# Question #3

iris3.1 <- mutate(iris2, petal_area = petal_width * petal_length, sepal_area = sepal_width * sepal_length)

iris3.2 <- select(iris3.1, -petal_width, -petal_length, -sepal_length, -sepal_width)

# Question #4

iris4.1 <- select(iris2, -petal_width, -petal_length, -sepal_width, -species)

iris4.2 <- summarize(iris4.1, mean_length = mean(sepal_length), maximum_length = max(sepal_length), minimum_length = min(sepal_length), range_length = max(sepal_length) - min(sepal_length), median_length = median(sepal_length), first_quantile = quantile(sepal_length, .25), third_quantile = quantile(sepal_length, .75), interquartile_range = IQR(sepal_length))

# Question #5

iris5.1 <- select(iris2, -sepal_length, -petal_length, -sepal_width)

iris5.2 <- group_by(iris5.1, species)

iris5.3 <- summarize(iris5.2, sample_size = n(), mean_width = mean(petal_width), standard_deviation = sd(petal_width), variance = var(petal_width), sem = mean(petal_width) / sqrt(sample_size), UCI = mean(petal_width) + (sem * 2), LCI = mean(petal_width) - (sem * 2))

# Question #6

iris6.1 <- select(iris3.1, -petal_width, -petal_area, -sepal_area, -sepal_length, -sepal_width)

ggplot(data = iris6.1) +
  geom_jitter(mapping = aes(x = species, y = petal_length), alpha = .1)

# Question #7

iris7.1 <- select(iris2, -sepal_length, -petal_width, -sepal_width)

iris7.2 <- group_by(iris7.1, species)

iris7.3 <- summarize(iris7.2, sample_size = n(), mean_length = mean(petal_length), standard_deviation = sd(petal_length), variance = var(petal_length), sem = mean(petal_length) / sqrt(sample_size), UCI = mean(petal_length) + (sem * 2), LCI = mean(petal_length) - (sem * 2))

iris7.4 <- select(iris7.3, -sample_size, -standard_deviation, -variance, -sem)

ggplot(data = iris6.1) +
  geom_jitter(mapping = aes(x = species, y = petal_length), alpha = .1) +
  geom_crossbar(
    data = iris7.4, 
    mapping = aes(x = species, y = mean_length, ymax = UCI, ymin = LCI),
    color = "red"
  )

# Question #8

iris8.1 <- select(iris2, -sepal_length, -sepal_width)

ggplot(data = iris8.1) +
  geom_point(mapping = aes(x = petal_width, y = petal_length, color = species))
