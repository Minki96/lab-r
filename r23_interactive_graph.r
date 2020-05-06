# 인터렉티브 그래프(interactive graph)

install.packages("plotly")

library("tidyverse")
library("plotly")

#ggplot2: mpg데이터 프레임에서
# 배기량(displ), 구동방식( drv), 고속도로연비(hwy) 간의 비교관계

g <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))
g

ggplotly(g)

# 구동방식(drv)별 고속도로 연비 boxplot
g <- ggplot(data= mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))
ggplotly(g)


# ggplot2 :: diamonds 데이터 프레임에서
# cut 변수의 막대 그래프.

str(diamonds)
table(diamonds$cut)

g <- ggplot(data = diamonds) +
  geom_col(mapping =  aes(x = cut))

# cut, clarity 변수의 막대 그래프
table(diamonds$cut, diamonds$clarity)
g <- ggplot (data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),
           position = "dodge")
ggplotly(g)

# economics 데이터 프레임에서
# 시간(data)에 따른 개인저축률(psavert)의 시계열 그래프.

g <- ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y =psavert))

# psavert가 최댓값인 date

economics %>% 
  filter(psavert == max(psavert, na.rm = TRUE)) %>% 
  select(date)
ggplotly(g)

# dygraphs : 시계열 그래피인 경우 더 많은 기능을 가지고 있음.
install.packages("dygraphs")
library(xts)
library(dygraphs)

serarch()

eco_psavernt <- xts(x = economics$psavert, #시계열 데이터
                    order.by = economics$date) #시간 
str(eco_psavernt)
# 날짜 범위 선택 가능
dygraph(eco_psavernt) %>% dyRangeSelector()

