# 데이터 시각화(Visualization) - ggplot2 패키지
# install.packages("tidyverse")
# library(tidyverse)

# 배기량(displ)과 고속도로 연비(hwy) 관계 : hwy ~ displ
ggplot(data = mpg) + 
  geom_point(mapping =  aes(x = displ, y= hwy))

# ggplot(데이터 설정) +  
#   그래프종류 (geometry 함수) - x/y측 매핑. +
#   추가 설정 (옵션)


#  ggplot( 데이터 설정, x/y축 매핑) +
# 그래프 종류

ggplot(data =  mpg, mapping = aes(x = displ, y= hwy) ) +
  geom_point()

str(mpg)

# 배기량(displ)이 큰 자동차들 중에서 연비(hwy)가 좋은
# 데이터가 어떤 테이터인지를 찾아보자
# 점의 색깔(color), 모양(shape), 크기(size) 등을 설정

ggplot(data = mpg) + 
  geom_point(mapping =  aes(x = displ, y= hwy,
                            color = class))

ggplot(data = mpg) + 
  geom_point(mapping =  aes(x = displ, y= hwy,
                            size = class, color = class))

# hwy ~ displ 점 그래프(scatter plot)에서
# 색깔은 class, 모양 fl, 크기는 cyl
ggplot(data = mpg) + 
  geom_point(mapping =  aes(x = displ, y= hwy,
                            size = cyl, color = class,
                            shape = fl))

ggplot(data = mpg) + 
  geom_point(mapping =  aes(x = displ, y= hwy),
                           color= "blue")
# aes()의 argument color는 데이터 프레임의 변수 값에
# 따라서 색깔을 다르게 표현하겠다는 의미.
# geom_xyz()의 argument color는 한가지 색깔을 지정할 때 사용.

# facet : 화면을 분할해서, 한 화면에 여러개의 plot 표현.
# facet_wrap(): 1차원  panel들을 여러 줄에 표현.
# facet_grid() : 두 개의 변수를 이용해서 2차원 panel 표현.

ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy)) +
  facet_wrap(vars(class))

ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy)) +
  facet_grid( rows = vars(cyl), cols = vars(class))
 

ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy)) +
  facet_grid( cyl ~ class)  # y 축 x축

ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy)) +
  facet_grid( .~class)

ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy)) +
  facet_grid( class ~ .)

g <- ggplot(data = mpg) + geom_point(mapping =  aes(x = displ, y = hwy))
g + facet_grid(drv ~ class)
g + facet_wrap(~ cyl, nrow = 4)

# 여러가지 geometry 함수들 :
# geom_point(), geom_smooth(), geom_bar(), geom_col(),
# geom_boxplot(), ...

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping =  aes(x = displ, y = hwy)) + 
  geom_point(mapping =  aes(x = displ, y = hwy)) 

ggplot(data = mpg, mapping = aes(x = displ, y= hwy)) +
  geom_point() +
  geom_smooth()

# geom_smooth()의 aesthetic 에서 x/y축 이외의 변수 설정:
# color, linetype, ...

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,
                            linetype = drv,
                              color = drv))

# 1) 산점도 그래프(scatter plot) : hwy ~ cty
ggplot(data = mpg) + geom_point(mapping =  aes(x = cty, y = hwy))

# 2) 산점도 그래프(scatter plot) : hwy ~ displ, 점의 색깔 - 구동방식(drv)
# +  smooth 그래프 : hwy ~ displ, 라인 선의 타입 - drv
ggplot(data = mpg) +  geom_point(mapping =  aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy,
                            linetype = drv))

ggplot(data = mpg, mapping = aes(x = displ, y= hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), color = "black")

# ggplot2 :: midwest
# popasian(아시아계 인구)~ poptotal(젠체 인구) 산점도

ggplot(data = midwest) + geom_point(mapping = aes(x = poptotal, y = popasian)) +
  xlim(0, 1000000) +
  ylim(0, 50000)

# xlim(), ylim() : x/y축의 범위를 제한. 


       