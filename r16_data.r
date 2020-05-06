library(tidyverse)

# base 패키지의 column/row bind 기능
?cbind
?rbind
# dplyr 패키지 : left, right_joinm bind_rows
midterm_test <- data.frame(id = 1:5,
                           midterm = c(60, 80, 70, 90, 50))
midterm_test

final_test <- data.frame(id = 1:5,
                         final = c(70, 83, 65, 95, 88))
final_test

# left_join(DF1, DF2, 기준)
test1 <- left_join(midterm_test, final_test, by = "id")
test1

test2 <- right_join(midterm_test, final_test, by = "id")
test2

midterm_test <- data.frame(id = 1:4,
                          midterm = c(11, 22,33,44))
midterm_test

final_test <- data.frame(id = 2:5,
                         final = c(22,33,44,55))
final_test

test1 <- left_join(midterm_test, final_test, by = "id")
test1

test2 <- right_join(midterm_test, final_test, by = "id")
test2
# NA: Not Available (결측치), missing value

test1 <- data.frame(id = 1:3,
                    score = c(10, 20,30))
test1

test2 <- data.frame(id = 4:6,
                    score = c(40,50,60))
test2

test1_all <- bind_rows(test1, test2)
test1_all

# class, name 변수를 갖는 데이터 프레임(teachers)을 생성.
# class = 1:6
# data/csv_exam.csv 파일에서 데이트 프레임(exam) 생성
# exam과 teachers를 left/ right-join 결과 비교
exam <- read.csv(file = "data/csv_exam.csv")
exam

teachers <- data.frame(class = 1:6,
                       name = c("minki","minsu","minji",
                                "minho", "mingu", "minbi"))

teachers1 <- left_join(exam, teachers, by = "class")
teachers1

teachers2 <- right_join(exam, teachers, by = "class")
teachers2


