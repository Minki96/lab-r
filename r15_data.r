# 데이터 전처리(pre-Processing) - dplyr 패키지
# filter() : 조건에 맞는 observation(행)을 추출.
# select() : 원하는 variables(변수들)을 선택.
# arrange(): 오름차순/ 내림차순 정렬.


exam <- read.csv(file = "data/csv_exam.csv")
exam

# arrange(데이터 프레임, 정렬 기준 컬럼)
# 데이터 프레임 %>%  arrange( 정렬 기준 컬럼)
arrange(exam, math)
exam %>%  arrange(math)

# arrange의 기본 정렬 방식은 오름차순.
# 내림차순으로 보려면 desc(컬럼)을 사용.
exam %>%  arrange(desc(math))
exam %>%  arrange(-math)


# 각 class에서 수학 점수를 기준으로 오름차순 정렬.
exam %>%  arrange(class, math)

# 정렬 기준 : 1) class 오름차순, 2) math 내림차순.
exam %>%  arrange(class, desc(math))

# dplyr :: mutate() - 파생 변수 생성.
# mutate(데이터프레임, 파생변수)
# 데이터 프레임 %>% mutate(파생변수)
exam %>%  mutate(total = math+ english+ science)
exam %>%  mutate(test = 
                   ifelse(science >= 60,"pass","fail"))

# 주의 : 아래의 코드는 exam 데이터 프레임을 수정함.
exam$total <- exam$math + exam$science + exam$english

rowSums(select(exam, math, english, science))
exam %>%
  select(math, english, science) %>%  rowSums()

rowMeans(select(exam, math, english, science))

exam %>%  select(math, english, science) %>%  rowMeans()

# 총점 (total), 평균(mean)  컬럼 2개를 추가
exam %>%  mutate(total= math + english + science, mean = total / 3)

# ggplt2 :: mpg 데이터 프레임에서
# 1) audi에서 생성한 자동차를 추출
mpg <- as.data.frame(ggplot2::mpg) # 복사본을 메모리에 저장장
mpg5 <- mpg %>% filter(manufacturer=="audi")
mpg5
# 2) hwy를 내림차순 정렬
# 3) hwy 순위 5위 까지만 출력
mpg5 %>%  arrange(-hwy) %>% head(5)

# 한줄로 
mpg5 <- mpg %>% filter(manufacturer=="audi")%>%
  arrange(-hwy) %>% head(5)
mpg5

# exam 데이터 프레임에서
# science가 50점 이상이면 " pass". "fail"
exam %>%  mutate(result = 
                   ifelse(science >= 50,"pass","fail"))

# mpg 데이터 프레임에서
# 1) avg_mpg 변수를 추가 = hwy와 cty의 평균
# 2) avg_mpg (평균 연비)가 25이상이면 Good, 
# 그렇지 않은면 Bad
# 3) avg_mpg 내림차순 정렬
# 4) 1~5 까지를 출력

mpg6 <- mpg %>% mutate(avg_mpg = hwy+ cty /2) # 1)
mpg6 <- mpg6 %>%  mutate(result = ifelse(avg_mpg >=25, "good","bad")) # 2)
mpg6 %>%  arrange(-avg_mpg) %>%  head(n =5) # ) 3, 4

mpg6 <- mpg %>% mutate(avg_mpg = hwy+ cty /2,result = ifelse(avg_mpg >=25, "good","bad")) %>% 
  arrange(-avg_mpg) %>%  head(n =5) 
mpg6

# 그룹별 통계 처리 : group_by() %>%  summarize()
# 비교) summary(): 요약해서 보여주기

# exam 데이터 프레임에서 class별 수학 점수 평균 계산.
exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math))
# summarise() 함수 안에서 사용할 수 있는 통계 함수들:
# sum() : 합계
# mean(): 평균
# sd() : 표준편차(standard deviation)
# min(): 최솟값
# max() : 최댓값
# n() : 빈도수

# exam 데이터 프레임에서 class별 과학 점수의 최솟값/ 최댓값

exam %>%  group_by(class) %>%  
  summarise(min(science),max(science))

# mpg 데이터 프레임에서,
# 제조사 (manufacturer) 별, 구동방식(drv) 별,
# 도시연비의 평균을 계산, 해당 자동차 대수

mpg <-  as.data.frame(ggplot2::mpg)
mpg7 <- mpg %>%  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty), n = n())
mpg7

#  mpg 데이터 프레임에서 
# 제조사별 "suv" 자동차의 도시/ 고속도로 평균연비를 계산 후
# 내림차순 정렬, 1~5위까지 출력

mpg %>% 
  group_by(manufacturer) %>%  # 제조사별 그룹
  filter(class == "suv") %>%  # suv만 추출
  mutate(mean_mpg = (cty + hwy) / 2) %>%  # 파생변수 생성
  summarise(mean = mean(mean_mpg)) %>% 
  arrange(-mean) %>%  # 내림차순 정렬
  head(n =5)

mpg %>% 
  filter(class == "suv") %>%  # suv만 추출
  group_by(manufacturer) %>%  # 제조사별 그룹
  summarise(mean = mean((cty + hwy) /2)) %>% 
  arrange(-mean) %>%  # 내림차순 정렬
  head(n =5)

# mpg 데이터 프레임에서
# Q1 ) class 별 도시 연비(cty)의 평균을 출력
mpg %>%  group_by(class) %>%  summarise(mean_cty = mean(cty))
# Q2 ) 1번의 결과를 cty 평균이 높은 순으로 정렬해서 출력
mpg %>%  group_by(class) %>%  summarise(mean_cty = mean(cty)) %>% arrange(-mean_cty)

# Q3 ) 어떤 회사의 고속도로 연비(hwy)가 좋을까요? 1~5위 출력
mpg %>%  group_by(manufacturer) %>%  summarise(mean_hwy = mean(hwy)) %>% arrange(-mean_hwy) %>% head(5)


# Q4 ) 어떤 회사에서 "compact"차종을 가장 많이 생산할까요?
mpg %>%  group_by(manufacturer) %>%  summarise(class_sum = sum(class == "compact")) %>%  head(1)
mpg %>% filter(class == "compact") %>%  group_by(manufacturer) %>%  summarise(cnt = n()) %>%  head(1)


# 회사별 compact 차종의 수를 내림차순으로 출력
mpg %>%  filter(class == "compact") %>% arrange(desc(manufacturer))

library(tidyverse)
mpg <- as.data.frame(ggplot2 :: mpg)
head(mpg)
tail(mpg)

