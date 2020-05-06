# 데이터 전처리(pre-Processing)
# tidyverse 패키지 : ggplot2, dplyr, tidyr,readr
install.packages("tidyverse")
library(tidyverse)
search()

# mpg 데이터 프레임
mpg
str(mpg) # data frame 구조
summary(mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y =hwy, color =class))

# dplyr::filter()
# 조건에 맞는 데이터(observation)을 추출.
랴
exam <- read_csv(file =  "data/csv_exam.csv")
head(exam)

# filter (데이터 프레임, 조건)
filter(exam, class == 1)

# 데이터 프레임 %>% filter(조건)
# dplyr %>% 파이프 연산자 : 데이터 프레임 %>% 함수 ()
# 데이터 프레임을 함수의 첫번째 argument로 전달
# Ctrl + Shift + M 단축키
exam %>% filter(class == 2)


class2 <- exam %>% filter(class == 2)
class2
# class2 데이터 프레임에서math가 80이상인 데이터만 추출
class2 %>%  filter(math >= 80)

exam %>% 
  filter(class == 2) %>%  filter(math >= 80)

# class 값이 1이 아닌 데이터만 추출.
exam %>%  filter(class != 1)

# 수학 점수가 50점 이상인 데이터 추출.
exam %>%  filter(math >= 50)
exam %>%  filter(science < 50)

# 논리 연산자 : &, |
# A & B :  A와 B가 모두  True이면 True, 그 이외에는 FALSE
# A | B : A와 B 증 적오도 하나가 True 이면 True, 아니면 FALSE.

# class가 1이고, math가 50이상인 데이터 추출.
exam %>%  filter(class == 1 & math >= 50)
exam %>%  filter(class == 2 & english >= 80)

# 수학 점수가 90점 이상 또는 영어 점수가 90점 이상
exam %>%  filter(math >= 90 | english >= 90)

summary(exam)
mean(exam$math) # 평균 계산

# 세 과목의 점수가 모두 평균 이상인 학생들 추출.
exam %>%  filter(math>=mean(math)&english>=mean(english)&
                 science>=mean(science))

# 1, 3, 5 반 학생들 추출.

exam %>%  filter(class == 1| class ==3 | class == 5)

exam %>%  filter(class %in% c(1,3,5))

# dplyr :: select(데이터 프레임,컬럼이름들, ..) : 
# 필요한 컬럼(변수)들을 추출
select(exam, math)

# id 와 수학 점수 선택.

exam %>%  select(id,math)
select(exam, id, math)

# 특정 컬럼(변수) 제외.
exam %>%  select(-math, -science)


# 1반 학생들의 id, class, math 출력
exam %>%  filter(class == 1) %>%  select(id, class, math)

# 수학 점수가 평균 이상인 학생들의 id, math를 출력.
exam %>%  filter(math >= mean(math)) %>%  select(id,math)



 
# ggplot2 :: mpg 데이터 프레임에서
# displ(배기량)이 4이하인 자동차와 5이상인 자동차의
# hwy(고속도로 연비) 평균을 계산
 
mpg1.1 <- mpg %>%  filter(displ<=4 )
mpg1.2 <- mpg %>%  filter( displ>=5)
mean(mpg1.1$hwy)
mean(mpg1.2$hwy)
 
 # 2) "audi"와 "toyota" 중 어는 manufactuner의 
 # cty(도시 연비)의 평균이 더 높은지.
mpg2.1 <- mpg %>%  filter(manufacturer == "audi" ) 
mpg2.2 <- mpg %>%  filter(manufacturer == "toyota" ) 

if (mean(mpg2.1$cty)>mean(mpg2.2$cty)) {
  print("아우디가 도시 연비가 더 높음")
} else {
  print("도요타가 도시 연비가 더 높음")
  
}
  

 # 3) "chevrolet" , "ford", "honda" 자동차를 추출해서
 # hwy의 전체 평균을 계산.

mpg3 <- mpg %>%  filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(mpg3$hwy)



# 4) class와 cty 변수로만 이루어진 데이터 프레임을 생성.
# class가 "suv"인 자동차와 "compact"인 자동차의 cty 평균.
# 어떤 클래스가  cty 평균이 더 높은지.

mpg4.1 <- mpg %>% select(class,cty) %>%  filter(class == "suv")
mpg4.2 <- mpg %>% select(class,cty) %>%  filter(class == "compact")

ifelse(mean(mpg4.1$cty) < mean(mpg4.2$cty),"suv의 평균이 더 높다","compact 평균이 더 높다")


names <- c("a","a","b","b","b","c","c")

names == "a"
names == c("a","b")

numbers <- 1:10
numbers + c(1,2)
