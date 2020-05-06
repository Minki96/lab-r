# 변수간의 관계
# 관심 변수: 데이터의 여러 변수들 중에서 차이를 확인하고 설명하려는 변수.
# 설명 변수: 관심 변수의 차이를 설명해줄 수 있는 변수
# (예) 연비 ~ 배기량 + 구동방식, 키 ~ 유전, 가격 ~ cut, 성격 ~ 혈액형

# 두 연속형 변수들 사이의 상관 관계 - 공분산, 상관 계수
students <- read.csv(file= "data/studentlist.csv",
                     fileEncoding = "utf-8")

head(students)
str(students)

# height(키) - 관심 변수, 단위(cm)
# weight(몸무게) -설명 변수, 단위(kg)
# height ~ weight

# 산점도 그래프(scatter plot)를 그려서, 두 변수의 관계 대략 파악
library(tidyverse)
ggplot(data = students) +
  geom_point(mapping = aes(x = weight, y =height)) +
  geom_vline(xintercept = mean(students$weight), color = "darkblue") +
  geom_hline(yintercept = mean(students$height), color = "darkblue") 
             
# 1사분면 : 키, 몸무게, 모두 평균 이상
# 2사분면 : 키는 평균 이상, 몸무게는 평균 이하
# 3사분면 : 키, 몸무게 모두 평균 이하
# 4사분면 : 키 평균 이하, 몸무게 평균 이상

# 1,3사분면이 다른 평면보다 데이터가 많다면, 양의 상관 관계
# 2,4사분면이 다른 평면보다 데이터가 많다면, 음의 상관 관계
# 모든 데이터들이 두 변수의 평균과 얼마나 떨어져 있는 지의 평균
# _> 공분산(covariance) : 두 변수를 함께 사용한 분산
# covariance = ~~
# 공분산의 부호를 보면, 양의 상관 관계 인지, 음의 상관관계 인지 알 수 있음.
# 공분산의 크기(절대값)로 상관과계의 크기를 정의할 수 있을까?
# 공분산에는 단위가 포함되기 때문에 숫자 크기의 비교가 의미 없다.

h <- students$height
w <- students$weight
h_bar <- mean(students$height)
w_bar <- mean(students$Weight)
n <- NROW(students)
covarianc <- sum((h - h_bar) * (w - w_bar)) / (n -1)
covarianc

cov(h,w)
cov(h/100,w)

# 공분산의 문제를 해결하기 위해서
# 표준화( 평균 0, 표준편차 1) 된 변수들의 공분산을 계산
# 표준화된 변수들의 공분산을 계산 -> 상관계수 (correlation coefficient)
# correlation = covariance(x, y) / sd(x) * sd(y))
# -1 <= correlation <= 1
# 상관계수가 0이면, 아무 상관이 없다.
# 상관계수가 +/-1에 가깡루 수록 강한 양/ 음의 상관관계가 있다.
correlation <- cov(h,w) / (sd(h)*sd(w))
correlation
cor(h,w)


# ggplot() :: mpg 데이터 프레임에서,
# 연비(Hwy)와 배기량(displ)의 공분산, 상관계수
# 직접계산 함수이용



ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_vline(xintercept = mean(mpg$displ), color = "darkgray") +
  geom_hline(yintercept = mean(mpg$hwy), color = "darkgray") +
  geom_smooth(method = "lm", formula = y ~ x)

Hwy <- mpg$hwy
Displ <- mpg$displ
Hwy_bar <- mean(mpg$hwy)
Displ_bar <- mean(mpg$displ)
n <- NROW(mpg)

cov(Hwy,Displ)
sum((Hwy - Hwy_bar) * (Displ - Displ_bar)) / (n-1)
cov(Hwy,Displ) / (sd(Hwy)*(sd(Displ)))
cor(Hwy,Displ)

# 두 범주형 변수의 관계
head(students)
# 성별(sex)
table(students$sex)
addmargins(table(students$sex))
prop.table(table(students$sex))
addmargins(prop.table(table(students$sex)))

# 혈액형(bloodtype)
tbl_blood <- table(students$bloodtype)
tbl_blood
addmargins(tbl_blood)
prop.table(tbl_blood)

# 성별 혈액형 차이 / 관계
tbl_sex_blood <- table(students$sex, students$bloodtype)
tbl_sex_blood
addmargins(tbl_sex_blood)
addmargins(tbl_sex_blood, margin = 2)

addmargins(tbl_sex_blood, margin = 2)
# margin = 2: 같은 변수(컬럼)별 합계를 "column"로 추가

ptbl_sex_blood <-  prop.table(tbl_sex_blood)
ptbl_sex_blood
addmargins(ptbl_sex_blood)

prop.table(tbl_sex_blood, margin = 1)
# prop.table() 함수의  margin = 1 argument -> 행(row) 백분율
# 같은 행(row) 안에서 각 변수들의 비율

prop.table(tbl_sex_blood, margin = 2)
# prop.table() 함수의  margin = 2 argument -> 컬럼(column) 백분율
# 같은 컬럼(column) 안에서 각 변수들의 비율


# 건강보험 데이터 프레임 treat
treat<-read.csv(file = "data/treat.csv")
head(treat)
str(treat)
treat$MONTH <- factor(treat$MONTH)
treat$SEX <- factor(treat$SEX)
levels(treat$SEX) <- c("남자","여자")
treat$SEX
# 나이 ~ 성별  table, prop. table - 백분율, 행/ 열 백분율
tbl_age_sex <- table(treat$AGE,treat$SEX)
tbl_age_sex
prop.table(tbl_age_sex,margin = 1)
# 진료과목 ~ 성별 table, prop. table - 백분율, 행/ 열 백분율

tbl_dsbjt_age <- table(treat$DSBJT,treat$AGE)
tbl_dsbjt_age
addmargins(prop.table(tbl_dsbjt_age,margin = 1),margin = 1)

# 나이 ~ 성별 table, prop.table - 백분율, 행/열 백분율
tbl_age_sex <- table(treat$AGE, treat$SEX)
tbl_age_sex
addmargins(tbl_age_sex)

prop.table(tbl_age_sex)
addmargins(prop.table(tbl_age_sex))

prop.table(tbl_age_sex, margin = 1)
# row 백분율 - 같은 나이 대에서의 성비

prop.table(tbl_age_sex, margin = 2)
addmargins(prop.table(tbl_age_sex, margin = 2), margin = 1)
# column 백분율 - 같은 성별에서 나이대의 비율

# 진료과목 ~ 성별 table, prop.table - 백분율, 행/열 백분율
tbl_dsbjt_sex <- table(treat$DSBJT, treat$SEX)
tbl_dsbjt_sex
addmargins(tbl_dsbjt_sex)

# 같은 진료 과목 내에서의 환자들의 성비
row_prop <- round(prop.table(tbl_dsbjt_sex, margin = 1), 
                  digits = 2)
row_prop
addmargins(row_prop, margin = 2)

# 같은 성별에서 각 진료과목별 환자 비율
col_prop <- round(prop.table(tbl_dsbjt_sex, margin = 2),
                  digits = 2)
col_prop
addmargins(col_prop, margin = 1)

# heights.csv 파일을 읽어서 데이터 프레임
heights <- read.csv(file = "data/heights.csv")
heights

# 각 변수의 요약
library(tidyverse)
class(heights$father)
str(heights)
table(heights$father)
table(heights$son)
boxplot(heights)

ggplot(data = heights) +
  geom_boxplot(mapping = aes(x = "father", y = father) )+
  geom_boxplot(mapping = aes(x = "son", y = son) ) +
  ylab("height")

# 산점도 그래프~ vline, hline, smooth(method = "lm")
ggplot(data = heights, mapping = aes(x = son,y = father)) +
  geom_point()+
  geom_vline(xintercept =  mean(heights$son), color ="darkred")+
  geom_hline(yintercept = mean(heights$father), color ="darkred")+
  geom_smooth(method = "lm", formula = y ~ x)


# 공분산, 상관계수
cov(heights$son,heights$father)
cor(heights$son,heights$father)
  

# 전체 son의 숫자
n = nrow(heights)
n

# -> son이 평균보다 키가 클 확률

tall_son <- heights %>% filter(son > mean(heights$son)) %>%  NROW()
tall_son
round(tall_son / n , digits = 2) 

# 아들의 키가 180 이상인 아들들의 비율

son_h180 <- heights %>% filter(son > 180) %>%  NROW()
son_h180
round(son_h180 / n , digits = 2) 

# 아빠의 키가 평균 이상인 아들들의 비율

father_mean <- heights %>% filter(father > mean(father)) %>%  NROW()
father_mean
round(father_mean / n , digits = 2) 

# 아버지 키가 평균 이상인 경우, 아들의 키가 180 이상인 비율
tall_son_h180 <- heights %>% filter(father >= mean(father) & son >= 180) %>%  NROW()
tall_son_h180
round(tall_son_h180 / n , digits = 2) 

tall_son_h180/father_mean

# 조건부 확률 P(A|B):
# 사전 B가 일어났을 때, 사건 A가 일어날 확률
# P(A|B) = P(A&B) /P(B)


str(Titanic) 
Titanic_data <-Titanic
Titanic_data
# 1) 생존자 비율 - 생존자 확률
p1 <- 711/(1490+711)
p1

# 남자의 생존율 - 남자 중에서 생존한 비율
p2 <- (29+338)/(35+1329+29+338)
p2
# 여자의 생존율 -여자 중에서 생존한 비율
(316+28)/ (17+109+28+316)

# 아이의 생존율
57 / (52+57) # 52%

# 5) 성인의 생존율
654/(1438+654) # 31#

# 6) 3등석 탑승자의 생존율
(13+14+78+76) / (35+17+387+89+13+14+75+76)

# 7) 3등석이 아닌 탑승자(1, 2, 선원)의 생존율
(711-(13+14+78+76))/((1490+711)-(35+17+387+89+13+14+75+76))

# 8) 여자 & 3등석 승객의 생존 비율
((13+14+78+76) + (316+28)) / (1490+711)

# 9) 여자 & 3등석이 아닌 승객 생존 비율
((1490+711)-((13+14+78+76) + (316+28))) / (1490+711)

