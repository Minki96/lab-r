# Control Statement (제어문)
# 1) 조건문
# if(조건식) {
#   조건식이 참일 때 실행 할 문장들.
# } else {
#   조건식이 거짓일 때 실행 할 문장들.
# }
x <- 11
if (x > 0) {
  print("Good")  # 0보다 클때
} else if (x < 0) {
  print("Bad") # 0보다 작을 때
} else {
  print("zero") # 그 외 나머지
}

v <- c(1, -2, 0)
v =! 0
# >, <, --, !=

# if - else 문에서 조건식에 벡터가 사용되면,
# 벡터의 첫번째 원소만 조건 검사에 사용됨.

# ifelse(조건식, 참일 때 값, 거짓일 때 값)

t <- ifelse( v > 0, "YES" ,
             ifelse(v < 0,"NO", "zero"))
t

# data/csv_exam.csv 파일에서 데이터 프레임 생성.
exam_test <- read.csv("data/csv_exam.csv")
is.data.frame(exam_test)

# 벡터 프레임에 세과목 총점/평균 컬럼(변수)을 추가.
exam_test$sum <- exam_test$math + exam_test$english + exam_test$science
exam_test$mean <- exam_test$sum / 3


# 데이터 프레임에 grade 컬럼(변수)를 추가
#  - 평균 >= 90이면, "A"
#  - 평균 >= 60이면, "B"
#  - 평균 < 60이면, "F"

exam_test$grade <- ifelse(exam_test$mean >= 80, "A", ifelse(exam_test$mean >= 60,"B","F"))
exam_test

# 2) 반복문


