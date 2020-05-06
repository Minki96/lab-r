# ggplot2::midwest 데이터 프레임 - 미국 중서부 지역의 인구 통계.
# ?midwest
# 데이터 프레임을 전역 변수로 복사.

midwest <- as.data.frame(ggplot2 :: midwest)
midwest

# Q1) poptotal: 전체 인구, popadult: 성인 인구
# midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수 추가.

midwest <- midwest %>%  mutate(perunderage = (1-popadults/poptotal)*100)

# Q2) 미성년 인구 비율이 가장 높은 상위 5개 county의 이름과
# 미성년 인구 백분율을 출력

midwest %>%  arrange(desc(perunderage)) %>%  head(5)

# Q3) 아래와 같은 기준의 grade 변수를 추가.
# 미성년 비율    | 등급(grade) 
#  40% 이상      | large
#  30 ~ 40% 미만 | middle
#  30% 미만      | small
# 각 등급의 지역 숫자(빈도수)를 출력

midwest<-midwest %>%  mutate(scale = ifelse(perunderage >= 40,"large",ifelse(perunderage >=30, "middle","small")))
midwest %>%  group_by(scale) %>%  summarise(cnt = n())
midwest

# Q4) popasian - 아시아 인구수
# midwest에 '전체 인구 대비 아시아 인구 백분율' 변수를 추가.
# 아시아 인구 비율 하위 10개 지역의 state, county,
# 아시아 인구 비율을출력

midwest %>% mutate( percasian1 = popasian/poptotal*100) %>%  arrange(percasian1) %>%  tail(10)# 이미 아시아 백분율 존재


table (midwest$scale)
