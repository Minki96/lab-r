# geom_bar() : 막대 그래프

# mpg$class의 빈도수
table(mpg$class)


ggplot(data = mpg) + 
  geom_bar(mapping = aes(x = class)) 
  

table(mpg$drv)

ggplot(data = mpg) + 
  geom_bar(mapping = aes(x = drv), fill = "red") 

# geom_bar()의
# color argument : 테두리 색깔 
# fill argument : 막대를 채우는 색깔

table(mpg$class,mpg$drv)
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv))

# geom_bar()의 position argument:
# 1) stack - 누적(stack)
# 2) dodge - 옆으로 나란히
# 3) fill - 비율

ggplot(data = mpg) +
  geom_bar(mapping =aes(x =class, fill = drv),
           position = "fill") +
  coord_flip()

ggplot(data = mpg) +
  geom_bar(mapping =aes(x =class, fill = drv),
           position = position_dodge2(preserve = "single"))
  
?diamonds
# ggplot2 :: diamonds 데이터 프레임

diamonds <- as.tibble(diamonds)

# cut 변수의 빈도수
table(diamonds$cut)

# cut 변수의 막대그래프
ggplot( data =diamonds) + geom_bar( mapping = aes(x= cut),
                                    fill = "lightblue", width = 0.2)

# cut 변수의 막대 그래프 + clarity 변수로 막대 색깔을 채움
table(diamonds$clarity)
table(diamonds$cut,diamonds$clarity)
ggplot( data =diamonds) + geom_bar( mapping = aes(x= cut, fill = clarity),
                                    alpha = 0.5, position = "dodge")


# cut 변수의 막대 그래프  + clarity 변수로 비율
ggplot( data =diamonds) + geom_bar( mapping = aes(y= cut, fill = clarity),
                                    position = "fill")

# table() : 빈도수
# prop.table() : 비율
table(diamonds$cut)
prop.table(table(diamonds$cut, diamonds$clarity))

# geom_col() : 데이터를 요약한 정보를 막대 그래프로 생성. 
# bar 그래프와 다르게 x축과 y축 모두 변수를 mapping함!

# 자동차 종류(class)별 평균 고속도로 연비(hwy)

hwy_by_class <- mpg %>% group_by(class) %>%  
  summarise(mean_hwy = mean(hwy))
hwy_by_class

ggplot(data = hwy_by_class) + 
  geom_col(mapping = aes(x = class, y = mean_hwy))

# 자동차 구동방식(drv)별 평균 고속도로 연비(hwy)

drv_by_hwy <- mpg %>%  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
drv_by_hwy

ggplot(data = drv_by_hwy) +
  geom_col(mapping = aes(x = drv, y = mean_hwy))

# 막대를 내림/ 오름차순으로 정렬해서 보여주기.
# reorder(축에 사용할 변수, 정렬 기준 변수)
ggplot(data = drv_by_hwy) +
  geom_col(mapping =  aes( x =reorder(drv, -mean_hwy), y = mean_hwy))

# Q1) 어떤 회사에서 생산한 SUV가 도시연비가 좋은지.
# SUV 차종의 평균 cty가 가장 높은 제조사 1~5위 col()

cty_by_ma <- mpg %>% filter(class == "suv") %>% group_by(manufacturer) %>%  summarise(mean_cty = mean(cty))  %>%  arrange(-mean_cty) %>%  head(5)
cty_by_ma

ggplot(data =  cty_by_ma) +
  geom_col(mapping = aes(x = reorder(manufacturer, -mean_cty),  y= mean_cty))


# Q2) 
           