library(tidyverse)

# call_chicken.csv 파일을 읽어서, data.frame을 생성
chicken <- read.csv(file = "data/call_chicken.csv")


# 데이터 프레임 대략적인 구조 파악
str(chicken)
summary(chicken)
head(chicken)
# 변수 이름들을 영문으로 변경
names(chicken) <- c(
  "Basedate", "weekday", "gu",
  "ages", "sex", "calls")
boxplot(chicken$calls)


# 구 별 통화건수의 boxplot
ggplot(data = chicken) + 
  geom_boxplot(mapping = aes(x = gu, y = calls))
# 성별(gender)별 통화건수(calls)의 boxplot  
ggplot(data = chicken) + 
  geom_boxplot(mapping = aes(x = sex, y = calls))

# 연령대(ages)벼 통화건수(calls)의 boxplot
ggplot(data = chicken) + 
  geom_boxplot(mapping = aes(x = ages, y = calls))

# 요일대별 통화건수의 boxplot
ggplot(data = chicken) + 
  geom_boxplot(mapping = aes(x = weekday, y = calls))

# 통화건수(calls)의 최솟값 / 최댓값에 해당하는 observation을 출력

chicken %>% filter(calls == min(calls) | calls == max(calls)) 

# recursive partition & regression tree

library(rpart.plot)

rp_call <- rpart(formula = calls ~ weekday + ages,
                 data = chicken)
rp_call
rpart.plot(rp_call)

# 가장 오른쪽 leaf(terminal node)의 yval = 122.465
chicken %>% 
  filter(ages %in% c("30대", "40대")&
           weekday %in% c ("금","토","일")) %>% 
  summarise(mean(calls))

# deviance = 오차들의 제곱의 합
#          = sum [(측정값 - 예측값) ** 2]
y_real <- chicken$calls
y_pred <- mean(chicken$calls)
deviance_call <- sum((y_real - y_pred) ** 2)
deviance_call

# datasets ::iris 데이터 프레임
?iris
str(iris)

# 산점도 그래프(scatter plot)

# Sepal.Length ~Sepal.Width, color = Species
ggplot(data = iris ) +
  geom_point(mapping = aes(x = Sepal.Width, y = Sepal.Length, color = Species ))

# Petal.Length ~Petal.Width, color = Species
ggplot(data = iris ) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length, color = Species ))

# 품종(Species) 별 Sepal.Length 의 boxplot

ggplot(data = iris) +
  geom_boxplot(mapping = aes( x =Species , y = Sepal.Length))


# rpart, rpart.plot 사용해서 regression tree 작성

rp_iris <- rpart(formula = Species ~ Sepal.Length + Sepal.Width+ Petal.Length + Petal.Width,
                data = iris)
rp_iris
rpart.plot(rp_iris)


# ggplot2::mpg 데이터 프레임에서
# hwy ~ displ + drv + class  regression tree 작성

rp_hwy <- rpart(formula = hwy ~ displ + drv+ class,
                 data = mpg)
rp_hwy
rpart.plot(rp_hwy)

# 상관관계(Correlation) 그래프
plot(iris)

cor(iris$Petal.Length,iris$Petal.Width)
correlations <- cor(iris[1:4])

install.packages("corrplot")
library(corrplot)

corrplot(correlations)
corrplot(correlations, method = "color")
corrplot(correlations, method = "number")

install.packages("psych")
library(psych)

pairs.panels(iris[1:4])
