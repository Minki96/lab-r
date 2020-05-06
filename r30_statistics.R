rm(list = ls())
library(tidyverse)
df <- data.frame ( type = rep ( c ("A","B"),3),
                            y = c(10, 11, 7, 17, 20, 21))
                 
                 

# 전체 y값의 평균
y_bar <- mean(df$y)
y_bar

# deviance 
# sum of squares
# 각 관측치들이 전체 평균과 얼마나 떨어져 있는 지의 정도 - 분산

ss1 <- sum((df$y - y_bar)**2)
ss1

# 그룹별 평균 (type별 y의 평균)
grouped_mean <- df %>%
  group_by(type) %>% 
  summarise(yg = mean(y))

grouped_mean

df <- left_join(df, grouped_mean, by = "type")
df

# 각각의 y- 해당 그룹 y평균)**2 들의 합.
# 그룹 안에서의 개인들의 차이
ss2 <- sum((df$y - df$yg)**2)
ss2

# (해당 그룹 y평균 - 전체평균)**2 들의 합.
# 그룹 안의 개인차는 무시하고 그룹간의 차이
ss3 <- sum((df$yg - y_bar)**2)
ss3

# ss1 == ss2 + ss3
# sum(y_i - ybar)**2 = sum[(y_i -yg)] + (sum(yg-ybar)**2)
#a**2 = b**2 + c**2

?InsectSprays # dataset:: InsectSpray
insect_sprays <- InsectSprays

str(insect_sprays)
head(insect_sprays)
tail(insect_sprays)

ggplot(data =insect_sprays) +
  geom_boxplot(mapping = aes(x= spray, y=count))

# count의 전체 평균
mean_count <- mean(insect_sprays$count)
mean_count
# count의 spray 타입 별 평균

grouped_sprays <- insect_sprays %>%  group_by(spray) %>% summarise(mean_count = mean(count))
insect_sprays <- left_join(insect_sprays,grouped_sprays, by = "spray")
insect_sprays
# a ** 2 = b ** 2 + c ** 2

ss1 <- sum((insect_sprays$count - mean_count)**2)
ss2 <- sum((insect_sprays$count - insect_sprays$mean_count)**2)
ss3 <- sum((mean_count - insect_sprays$mean_count )**2)

i


