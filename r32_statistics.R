rand_unif<-runif(n=10000) #  0 <=  r < 1 난수 생성
hist(rand_unif, breaks = seq(0, 1, 0.1))

x <- seq(0, 1, 0.01)
y <- dunif(x) # uniform distribution

library(tidyverse)
ggplot(mapping=aes(x,y))+geom_line() +
  geom_vline(xintercept = c(0, 0.1), color = "red")

# 평균이 0이고, 표준편차가 1인 정규 분포(normal distribution) ~N(0,1) 앞이 평균 뒤가 표준편차
rand_norm <- rnorm(n=10000)
rand_norm
hist(rand_norm, breaks =  seq(-10, 10, .5))

x<- seq(-5,5,0.01)
x
y <- dnorm(x)
y
ggplot(mapping = aes(x,y))+geom_line()+
  geom_vline(xintercept = c(-1,1), linetype = 2, color = "red")+
  geom_vline(xintercept = c(-2,2), linetype = 2, color = "green")+
  geom_vline(xintercept = c(-3,3), linetype = 2, color = "blue")

integrate(dnorm, lower = -1, upper = 1) # 0.68
integrate(dnorm, lower = -2, upper = 2) # 0.95
integrate(dnorm, lower = -3, upper = 3) # 0.997

integrate(dnorm, lower = -1.64, upper = 1.64) # 0.9   90% 신뢰구간
integrate(dnorm, lower = -1.96, upper = 1.96) # 0.95, 95% 신뢰구간
integrate(dnorm, lower = -2.58, upper = 2.58) # 0.99  99% 신뢰구간

# chi-squared 
# df(degree of freedom: 자유도)
rand_chi <-rchisq(n = 10000, df = 5)
hist(rand_chi)

x <- seq(0, 20, 0.01)
y <- dchisq(x, df = 4)
ggplot(mapping = aes(x,y)) + geom_line()

# 자유도 4인 chi-squared 분포에서 0 <- x < 10 일 확률
func <- function(x) {
  dchisq(x, df = 4)
}

integrate(func, lower = 0, upper = 10) # 0.959

# heights.csv 파일을 읽어서 데이터 프레임 생성
heights <- read.csv("data/heights.csv")
summary(heights)
mean(heights$father)
sd(heights$father)

# 10명의 father의 키를 조사해서
# 전체 father의 키의 평균이 171.9인지 아닌지 테스트(검정)
# H0(d영가설, 귀무가설) : 평균 == 171.9
# H1(대립가설): 평균 != 171.9

father_sample = sample(heights$father, size = 10)

mean(father_sample)
t.test(father_sample, mu = 171.9)

rand_t <- rt(n = 10000, df =9)
hist(rand_t)

x <- seq(-6,6, 0.01)
y <- dt(x,df=9)
ggplot(mapping = aes(x,y)) +geom_line() +
  geom_vline(xintercept = 1.1114, color="red")

func <- function(x) {
  dt(x,df=9)
}

integrate(func, lower = -0.598559, upper = 0.5989)

mu <- mean(heights$father)# 모평균
sigma <- sd(heights$ father)
c(-1.96,1.96)*sigma+mu



x <- seq(-5,5,0.01)
y <- dnorm(x)
qnorm(p = c(0.025, 0.975))

ggplot(mapping = aes(x,y))+ geom_line() +
  geom_vline(xintercept = c(-1.96, 1.96),color =  "red")

x <- seq(120, 220, 0.01)
y <- dnorm(x, mean = 175.8, sd =7.5)
qnorm(p = c(0.025,0.975) ,mean = 175.8, sd =7.5)


ggplot(mapping = aes(x, y)) + geom_line() +
  geom_vline(xintercept = c(161.1003, 190.4997),color = "red")

# t Test(t 검정)
# 연속형 변수가 차이가 있는지를 테스트 할때 사용
# 연속형 변수의 평균이 0 (또는 특정값)인지 아닌지

?sleep
sleep
str(sleep)
summary(sleep)
ggplot(data= sleep, mapping = aes(x = group, y = extra)) +
  geom_boxplot()

t.test(formula= extra ~ group , data = sleep)
# H0: 두 그룹(1,2)의 extra차이는 0이다.
# H1: 두 그룹(1,2)의 extra차이는 0이 아니다.
# p-value = 0.08 > 0.05
# 유의수준 0.05로 H0를 기각 할 수 없다.

InsectSprays
ggplot(data = InsectSprays, mapping = aes(x = spray, y = count)) +
  geom_boxplot()

test_Insect <- InsectSprays %>% filter(spray == "A" | spray == "C" )
t.test(formula= count ~ spray , data = test_Insect)

survey <- MASS::survey
str(survey)
# W.Hnd, Clap 분할표(contingency table)
t <- table(survey$W.Hnd, survey$Clap)
t
chisq.test(t)

# H0 : 글씨 쓰는 손(W.Hnd)과 박수칠 때 위에 있는 손(Clap)
# 서로 독립(관련이 없다.)
# H1 : W.Hnd와 Clap 서로 독립이 아니다(관련이 있다.)

# Sex, Exer 변수의 분할표
t2 <- table(survey$Sex, survey$Exer)
t2

chisq.test(t2)
# H0 : SEX 과 Exer은 서로 독립이다.
# H1 : SEX 과 Exer은 서로 독립이 아니다.
# p가 0.05보다 크기 때문에 영가설 채택. 

# heights 데이터 프레임에서 son~ father 설명
ggplot(data = heights, mapping = aes(x= father, y = son)) +
  geom_point(size = 2)+
  geom_smooth(method = "lm",formula = y ~ x) +
  geom_vline(xintercept = mean(heights$father),color = "green") +
  geom_hline(yintercept = mean(heights$son),color = "green")

lm_heights <- lm(formula = son ~ father, data = heights)
lm_heights


summary(lm_heights)
# 선형모델이 예측하는 값
a <- 0.51391 # 선형 모델에서 직선의 기울기
b <- 86.10257 # 선형 모델에서 직선의 y절편
yhat <- a * heights$father + b
yhat

# 실제 값들과 예측값 사이의 분산
var1 <- sum((heights$son - yhat) ** 2)
var1

# 실제 값들과 평균 사이의 분산
var2 <- sum((heights$son - mean(heights$son))** 2)
var2

var1/ var2
