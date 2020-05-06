# 조건부 확률, Mosacit Plot, Decison Tree

str(Titanic)  # 4-dimensional array
# 4-d array를 data.frame으로 변환

Titanic_data <-as.data.frame(Titanic)
Titanic_data

# 4-d array를 이용한 mosaic plot
mosaicplot( ~ Class,data = Titanic)

mosaicplot( ~ Class + Sex, data = Titanic )
mosaicplot( ~ Class + Sex + Age, data = Titanic )
mosaicplot( ~ Class + Sex + Age + Survived, data = Titanic, color = TRUE )

mosaicplot( ~ Age + Sex + Class + Survived, data = Titanic, color = TRUE)

# 전체 탑승객 숫자
n_total <- sum(Titanic_data$Freq)

# 생존자 숫자
n_survived <- Titanic_data %>%  filter(Survived == "Yes") %>% select(Freq)%>%  summarise(sum(Freq))
n_survived

n_survived / n_total

Titanic_data %>% 
  filter(Sex == "Male") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter(Age == "Adult") %>% 
  summarise(sum(Freq))


# 1) 성별(Sex)로 분할한 경우
# 남자인 경우 생존 비율

male_n <- Titanic_data %>% 
  filter(Sex == "Male") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter( Sex == "Male" & Survived == "Yes") %>% 
  summarise(sum(Freq)) / male_n

# 여자인 경우 생존 비율
female_n <- Titanic_data %>% 
  filter(Sex == "Female") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter( Sex == "Female" & Survived == "Yes") %>% 
  summarise(sum(Freq)) / female_n

# 2) 나이(Age)로 분할한 경우

Adult_n <- Titanic_data %>% 
  filter(Age == "Adult") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter(Survived == "Yes" & Age == "Adult" ) %>% 
  summarise(sum(Freq)) / Adult_n

Child_n <- Titanic_data %>% 
  filter(Age == "Child") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter(Survived == "Yes" & Age == "Child" ) %>% 
  summarise(sum(Freq)) / Child_n


# 3등급인 경우 생존 비율

n_3rd <- Titanic_data %>% 
  filter(Class == "3rd") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter(Survived == "Yes" & Class == "3rd" ) %>% 
  summarise(sum(Freq)) / n_3rd

# 3등급이 아닌 경우 생존 비율
not_3rd <- Titanic_data %>% 
  filter(Class != "3rd") %>% 
  summarise(sum(Freq))

Titanic_data %>% 
  filter(Survived == "Yes" & Class != "3rd" ) %>% 
  summarise(sum(Freq)) / not_3rd
2512921+398067+1366342 

git_titanic<- read.csv(file = "data/titanic3.csv", na.strings = "")
# read.csv() 함수의 na.string = "" argument는
# csv 파일에 있는 빈 문자열("")을 NA로 처리함.
str(git_titanic)



#git_titanic$home.dest <- ifelse(git_titanic$home.dest == "", NA, git_titanic$home.dest)

head(git_titanic)
summary(git_titanic)

# pclass 변수를 categorical 변수로 변환 (factor)
# survived 변수를 categorical 변수로 변환(factor)
# levels를 "no"(0), "yes"(1) 지정.

git_titanic$pclass <- factor(git_titanic$pclass)
git_titanic$survived <- factor(git_titanic$survived)
levels(git_titanic$survived) <- c("no","yes")
levels(git_titanic$survived)
table(git_titanic$survived)

# mosaic plot
mosaicplot(~ sex + pclass + survived, data =git_titanic,
           color = TRUE)
library(tidyverse)
# git titanic 데이터 프레임에 adult 변수를 추가
# age <= 10 이하면 "no", 그렇지 않으면 "yes"
# adult 변수를 포함한 : mosaic plot

git_titanic <- git_titanic %>%
  mutate(adult = ifelse(age <= 10, "no","yes"))
table(git_titanic$adult)

mosaicplot(~ sex + pclass + adult +survived, data =git_titanic,
           color = TRUE)

# rpart 패키지 : recursive partitioning & regression tree
# R을 설치하면 포함되어 있음.
# rpart.plot 패키지 :  rpart의 내용을 tree로 시각화
install.packages("rpart.plot")
library(rpart.plot)

rp_titanic <- rpart()