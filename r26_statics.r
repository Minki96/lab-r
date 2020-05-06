# 연속형 변수 요약
# data/salary_data.csv 파일 읽어서 데이터 프레임 생성
salary <- read.csv("data/salary_data.csv")
head(salary)

# 1) 정렬하기 -> min, max, quantile
min(salary)
max(salary)
qs <- quantile(salary$salary,seq(0,1,0.1) )
quantile(salary$salary, 0.7)
summary(salary)
boxplot(salary)
# 2) 소득 하위 70%에 해당하는 소득이 얼마인지 찾아보세요.
qs["70%"]

# dplyr의 전처리 함수 들을 이용해서

# 1) 하위 소득 70% 이하 소득자들의 숫자는 7000명
salary %>%  filter(salary <= quantile(salary, 0.7)) %>%
  summarise(pop = n())

# 2) 중위 소득의 150% 이하 소득자들의 숫자?
salary %>%  filter(salary <= quantile(salary, 0.5)*1.5) %>%
  summarise(pop = n())

# 3) 히스토그램
hist(salary$salary,breaks = seq(0, 9000, 500))

# 4) salary를 표준화(standardization)
# 표준화된 변수들의 평균은 0, 표준편차는 1임을 확인하세요.

# 범주형 변수 요약


