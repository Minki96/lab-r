# 한국 복지 패널 데이터 분석
# sav 파일: SPSS 통계 프로그램 용 파일.
# SPSS 프로그램 용 파일을 처리하기 위한 패키지 설치
#install.packages("foreign")

# 분석, 시각하에 필요한 패키지들을 검색 경로attach
library(tidyverse)
library(readxl)
library(foreign)
search()

raw_data <- read.spss(file = "data/Koweps_hpc10_2015_beta1.sav",
                      to.data.frame = TRUE)
head(raw_data)
str(raw_data)

# 원본 데이터를 전처리하기 전에 복사

welfare <- raw_data

# 관심이 있는 변수(column)들의 변수 
df <- data.frame(var1 = 1:3, var2 = c("a", "b", "c"))
df
df <- df %>% 
  rename(id = var1, name =var2)
df
welfare <- welfare %>%  
  rename(gender = h10_g3,         # 성별
         birth = h10_g4,          # 출생 연도
         income = p1002_8aq1,     # 월급
         code_job = h10_eco9,     # 직종 코드
         code_region = h10_reg7)  # 지역 코드 
welfare %>% 
  select(gender, birth, income, code_job, code_region) %>% 
  head(6)

# 성별에 따른 월급 차이
# 나이에 따른 월급 차이
# 성별/ 나이에 따른 월급 차이
 
class(welfare$gender) # numeric
summary(welfare$gender) # NA 없음. 9 없음
table(welfare$gender) # 남(1)/ 여(2) 숫자

# 이상치와 NA가 없음을 확인. 
# gender 변수의 값을 숫자(1,2) 에서 문자열(male, female)로 변환

welfare$gender <- ifelse(welfare$gender == 1, "male", "female")
table(welfare$gender)

ggplot(data = welfare) +
  geom_bar(mapping = aes( x= gender),width=0.2)
qplot(x= welfare$gender)

# 월급(income) 변수 확인
class(welfare$income)
summary(welfare$income)
# NA 많다. 9999(이상치)는 없다.

# income 0보다 큰 값들만 유지, 0은 NA
welfare$income  <- ifelse(welfare$income == 0 |welfare$income == 9999 , NA, welfare$income )
table(is.na(welfare$income))
boxplot(welfare$income)

# income 변수의 히스토그램(histogram)
qplot(welfare$income)
ggplot(data= welfare) +
  geom_histogram(mapping =aes(x = income), bins = 10)

ggplot(data = welfare)+
  geom_density(mapping = aes(x = income))

# 성별에 따른 월급

income_by_gender <- welfare %>%  
  filter(!is.na(income)) %>%  # 월급이 NA가 아닌 데이터만 추출
  group_by(gender) %>% 
  summarise(mean_income = mean(income))

income_by_gender

ggplot(data = income_by_gender) +
  geom_col(mapping = aes(x = gender, y= mean_income,
                         fill = gender),
           width = 0.3)

# 연령대별 월급, 연령대별/ 성별 월급
# birth 변수 확인

class(welfare$birth)
table(is.na(welfare$birth))
summary(welfare$birth)

welfare$age <- 2015 - welfare$birth
summary(welfare$age)
table(welfare$age)
qplot(welfare$age)

# 연령대(age_range) 변수
welfare <- welfare %>% 
  mutate(age_range = ifelse(age < 20, "age10",
                            ifelse(age < 30, "age20",
                                   ifelse(age < 40, "age30",
                                          ifelse(age < 50, "age40",
                                                 ifelse(age < 60, "age50",
                                                        ifelse(age < 70, "age60","over70")))))))
table(welfare$age_range)
  
# 연령대별, 성별 평균 월급



income_by_age_gender <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age_range,gender) %>% 
  summarise(mean_income = mean(income))

income_by_age_gender

ggplot(data = income_by_age_gender , mapping = aes( x = age_range )) +
  geom_col(mapping = aes( y= mean_income, fill = gender),
           position = "dodge") 


# 나이별, 성별

income_by_ages_gender <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, gender) %>% 
  summarise(mean_income = mean(income))

income_by_ages_gender

ggplot(data = income_by_ages_gender) +
  geom_line(mapping = aes(x = age, y= mean_income, color = gender))


# income  있는 대상들 중에서 남/여의 성비를 연령대별로 시각화

income_by_n_gender <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age_range,gender) %>% 
  summarise( mean_income = mean(income) ,n = n())
income_by_n_gender

ggplot(data = income_by_n_gender) +
  geom_col(mapping = aes(x = age_range,
                         y = n, fill= gender),
           position = "fill",
           ) + coord_flip()


# income이 NA가 아니고, gender가 male이고, 
# age_range가 age10인 데이터에서 code_job, income의 값을 찾으세요.

welfare %>% filter(!is.na(income) & gender == "male" &
                   age_range == "age10") %>%
                  select(code_job,income)

# income이 NA가 아니고, gender가 female이고, 
# age_range가 age10인 데이터에서 code_job, income의 값을 찾으세요.
welfare %>% filter(!is.na(income)& gender == "female"&
                   age_range == "age10") %>%  select(code_job,income)
# income이 있고, income이 최댓값인 조사대상(row, observation)의
# 수입 income ,직종코드 code_job, 지역코드 code_region, 나이 
welfare$age <- 2015 - welfare$birth
welfare %>% filter(income == max(income,na.rm = TRUE)) %>%  select(income ,code_job,code_region, age)

# income이 최솟값인 조사 대상의 
# 수입 income ,직종코드 code_job, 지역코드 code_region, 나이 
welfare %>% filter(income == min(income,na.rm = TRUE)) %>%  select(income ,code_job,code_region, age)

# incomed이 중앙값(median)에 해당하는 조사 대상들의 
# 수입 income ,직종코드 code_job, 지역코드 code_region, 나이 

welfare %>% filter(income == median(income,na.rm = TRUE)) %>%  select(income ,code_job,code_region, age)


# inocme이 평균 이상이고, 연령대는 20대인 조사 대상의
# income, age_range, age, code_job을 출력

welfare %>% filter(income >= mean(income,na.rm = TRUE), age_range == "age20") %>%  select(income ,age_range, age, code_job)

# quantile() : 분위수에 해당하는 값들을 찾아줌.
q4 <- quantile(welfare$income, na.rm = TRUE)
q10 <- quantile(welfare$income, seq(0,1,0.1),na.rm = TRUE)
class(q4)


#  이름으로 접근하는 방법
q4[4] # 인덱스로 접근
q4["75%"] # 이름으로 접근하는 방법

# 소득 상위 1%인 조사 대상의 income, age, code_job을
# income의 내림차순으로 출력.

q100 <- quantile(welfare$income,seq(0,1,0.01), na.rm = TRUE)
q100

welfare %>% filter(income >= q100["99%"]) %>%  select(income , age, code_job) %>%  arrange(-income)

# 직종별 월급의 차이
summary(welfare$code_job) # 이상치 없음.
table(welfare$code_job)


# welfare 데이터 프레임에 직종의 이름을 추가하기 위해서
# 엑셀 파일에서 직종 코드 / 이름을 데이터 프레임으로 생성.
job_list <- read_excel("data/Koweps_Codebook.xlsx", sheet = 2)
job_list
# join() 함수를 사용해서 welfare 데이터 프레임 추가.
welfare <- left_join(welfare, job_list, by = "code_job")
welfare %>% 
  select(code_job, job) %>% 
  head()

welfare %>% 
  select(code_job, job) %>% 
  tail()

# 직종별 인구수. 상위 20개 code_job ,job, 인구수 출력.
table(welfare$job)
welfare %>% filter(!is.na(job)) %>%  group_by(code_job,job ) %>% summarise(n = n()) %>% arrange(-n) %>%  head(20)

# 직종별 소득 평균 ~ 상위 10개, 하위 10개

income_by_job <- welfare %>% filter(!is.na(job) & !is.na(income)) %>% # 직종과 소득  NA는 제외
  group_by(job) %>%  summarise(mean_income = mean(income))
income_by_job

top10_job <- income_by_job %>% 
  arrange(-mean_income) %>% 
  head(10)

bottom10_job <- income_by_job %>% 
  arrange(-mean_income) %>% 
  tail(10)
bottom10_job

ggplot(data = top10_job) +
  geom_col(mapping = aes(x= reorder(job,mean_income), y = mean_income))+
  coord_flip()

# 소득 평균 하위 10개 직종 막대 그래프
ggplot(data = bottom10_job) +
  geom_col(mapping = aes(x= reorder(job,-mean_income), y = mean_income))+
  coord_flip()

# 남성의 소득 평균 상위 10개 직종을 찾고, 시각화.

welfare$gender <- ifelse(welfare$gender == 1, "male", "female")
men_top10<- welfare %>%  filter(!is.na(job) & !is.na(income) & gender == "male" ) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income)) %>% 
  arrange(-mean_income) %>% 
  head(10)

men_top10

ggplot(data = men_top10) +
  geom_col(mapping = aes(x= reorder(job,mean_income ), y = mean_income)) +
  coord_flip()



# 여성의 소득 평균 상위 10개 직종을 찾고, 시각화.
women_top10<- welfare %>%  filter(!is.na(job) & !is.na(income) & gender == "female" ) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income)) %>% 
  arrange(-mean_income) %>% 
  head(n = 10)

women_top10

ggplot(data = women_top10) +
  geom_col(mapping = aes(x= reorder(job,mean_income ), y = mean_income)) +
  coord_flip()

# 직종별 남,녀 인구 상위 10개 

job_by_mentot <- welfare %>%  
  filter(!is.na(job) & gender == "male" ) %>% 
  group_by(job) %>%
  summarise(n = n()) %>% 
  arrange(-n) %>% 
  head(10)

job_by_womentot <- welfare %>%  
  filter(!is.na(job) & gender == "female" ) %>% 
  group_by(job) %>%
  summarise(n = n()) %>% 
  arrange(-n) %>% 
  head(10)

job_by_mentot
job_by_womentot

ggplot(data = job_by_mentot) +
  geom_col(mapping = aes(x= reorder(job,n ), y = n)) +
  coord_flip()

ggplot(data = job_by_womentot) +
  geom_col(mapping = aes(x= "", y = n, fill = job)) +
  coord_polar("y")

# geom_bar() vs geom_col()
df <- data.frame(v1 = c("a", "b", "c"), v2 =c(10, 5, 15))
ggplot(data = df) + 
  geom_col( mapping = aes(x = v1, y = v2))
ggplot(data = df) + 
  geom_bar( mapping = aes(x = v1, y = v2),stat = "identity")

# 종사하는 인구 50명 이상인 샘플에서 
# 소득 평균 상위 10개 직종을 찾고, 시각화



# 1) 남성 종사 인구가 50명인 샘플에서, 소득 평균 상위 10개 직종을 찾고, 시각화
m_top10_over50 <- welfare %>%  
  filter(!is.na(job) & !is.na(income) & gender == "male" ) %>% 
  group_by(job) %>%
  summarise(n = n(), mean_income = mean(income)) %>% 
  filter(n >= 50) %>% 
  arrange(-mean_income)

m_top10_over50

ggplot(data =  m_top10_over50) +
  geom_col(mapping = aes(x = reorder(job,mean_income), y = mean_income, fill = n)) +
  coord_flip() 

# 2) 여성 종사 인구가 50명인 샘플에서, 소득 평균 상위 10개 직종을 찾고, 시각화


w_top10_over50 <- welfare %>%  
  filter(!is.na(job) & !is.na(income) & gender == "female" ) %>% 
  group_by(job) %>%
  summarise(n = n(), mean_income = mean(income)) %>% 
  filter(n >= 50) %>% 
  arrange(-mean_income) %>% 
  head(10)

w_top10_over50

ggplot(data =  w_top10_over50) +
  geom_col(mapping = aes(x = reorder(job,mean_income), y = mean_income, fill = n)) +
  coord_flip() 

# 지역별, 연령대별 인구
# 지역별 평균 소득
region_list <- data.frame(code_region = 1:7,
                          region = c("서울",
                                     "수도권(인천/경기",
                          "부산/울산/경남", "대구/경북",
                          "대전/충남", "강원/ 충북", 
                          "광주/전남/전북/ 제주"))
region_list

welfare <- left_join(welfare, region_list)
table(welfare$region)

welfare %>%  group_by(region) %>% 
  summarise( n = n()) %>%  ggplot() +
  geom_col(mapping = aes(x = region, y = n))

welfare %>%  group_by(region) %>% 
  filter(!is.na(income)) %>% 
  summarise( mean_income = mean(income)) %>%  ggplot() +
  geom_col(mapping = aes(x = region, y = mean_income))



