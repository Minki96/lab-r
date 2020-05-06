# Missing Value(결측치): 데이터 프레임에서 빠져있는 값.
# NA(Not Available) : 결측치를 표기하는 예약어

df <- data.frame(gender = c( "F","M", NA, "M", "F"),age = c(25, 31, 29, 34, NA))
df

str(df)
summary(df)

is.na(df)
rk table(is.na(df$gender))
table(is.na(df$age))

# age 변수의 평균
mean(df$age)
mean(df$age, na.rm = TRUE) # 29.75

# argument na.rm: NA를 제가할 것인지(TRUE), 아닌지(FALSE)

sum(df$age, na.rm = FALSE)

sum(df$age, na.rm = TRUE)
# sum(), mean(), sd(), min(), max(), ... 과 같은 함수들은
# na.rm argument를 가지고 있음.

# missing value(NA) 제거
# age 변수의 NA를 제거한 데이터 프레임을 출력.

df %>% 
  filter(!is.na(age))
# !연산자 : NOT (TRUE -> FALSE, FALSE -> TRUE)

# gender, age 모두 NA 아닌 값들을 출력
df %>% 
  filter(!is.na(age),!is.na(gender))

df_omit <- na.omit(df)
df_omit

# missing value 처리
# 1) missing value 제거 -> 데이터의 개수가 작아질 수 있음.
# 2) missing value를 대표값으로 대체
# 평균, 최빈값(가장 자주 등장하는 값.), 중앙값, ...
library(tidyverse)
exam <- read.csv(file = "data/csv_exam.csv")

# NA를 삽입
exam[c(3,8,15), "math"] <- NA
exam

# 수학 점수 평균
mean(exam$math, na.rm = TRUE)

# exam 데이터 프레임에서 수학/ 영어 /과학 평균 출력.

exam %>% 
  summarise(m_math = mean(math,na.rm = TRUE),
            m_eng = mean(english),
            m_sci = mean(science))

# exam  데이터 프레임에서 수학 점수의 합계, 평균, 표준편차
exam %>% 
  summarise(total = sum(math, na.rm = TRUE),
  avg = mean(exam$math, na.rm = TRUE),
  stddev = sd(exam$math, na.rm = TRUE))

# exam 데이터 프레임에서 math의 NA를 평균값으로 대체.

average <- mean(exam$math, na.rm =TRUE)
# floor(): 내림 , ceiling(): 올림, round() 반올림
average <- round(average)

exam$math <- ifelse(is.na(exam$math),average, exam$math)
exam

exam <- read.csv(file = "data/csv_exam.csv")
exam[c(3,8,15), "math"] <- NA
exam

# e각 반(class)의 수학 평균 점수로 NA를 대체
exam_avg <- exam %>% group_by(class) %>% 
  summarise(avg =mean(math,na.rm = TRUE))
exam_avg[1,"avg"] # tibble(data frame)
exam_avg$avg[1] # 숫자 (scalar)
exam_avg$avg <- round(exam_avg$avg)


exam$math <- ifelse(!is.na(exam$math), exam$math, 
                    ifelse(exam$class == 1,exam_avg$avg[1],
                        ifelse(exam$class == 2, exam_avg$avg[2],
                            ifelse(exam$class == 3, exam_avg$avg[3],
                                ifelse(exam$class == 4, exam_avg$avg[4],
                                  exam_avg$avg[5])))))

exam
exam[c(3,8,15), "math"] <- NA
is.na(exam$math) 
for (c in 1:20){
  if ( is.na(exam[c, "math"])){
    exam[c, "math"]<- exam_avg$avg[exam[c,"class"]]
  }  
}

# ggplot2 ::mpg 데이터 이용
# 65,124, 131, 153, 212행의 hwy값을 NA로 만듦.
library(tidyverse)
mpg <- as.data.frame(ggplot2:: mpg)
mpg[c(65,124,131,153,212), "hwy"] <- NA
mpg
# 구동방식(drv)별 고속도로연비(hwy) 평균을 계산하기 위해
# Q1) drv, hwy, 변수의 NA 개수를 확인
mpg %>% select(drv, hwy) %>%  filter(is.na(drv),is.na(hwy))
mpg

table(is.na(mpg[,"hwy"]))
table(is.na(mpg[,"drv"]))


# Q2) 모든 NA를 제거하고, drv별 hwy 평균을 계산  

avg_hwy <- round(mean(mpg$hwy, na.rm = TRUE))
mpg$hwy <- ifelse(!is.na(mpg$hwy), mpg$hwy, avg_hwy)
mpg                    
table(is.na(mpg[,"hwy"]))

mpg %>%  group_by(drv) %>%  summarise(mean(hwy, na.rm = TRUE))

