# R에서 데이터를 변수에 저장하는 방법
# 스칼라(scalar) : 변수에 하나의 값만 저장.
# 벡터(vector) : 변수에 한가지 타입의 값 여러개를 저장.

age <- 16 # age 변수에 숫자 타입 값(16)을 저장.
name <- "오쌤" # 변수  name에 문자열 타입 값("오쌤")을 저장.

# --- scalar
is_married = TRUE
# TRUE 나 FALSE는  R 언어에서 특별한 용도로 예약된 예약어(key) 
# 예약어는 변수 이름으로 사용 할 수 없음.
# 변수 is_married에 논릿값(boolean) 타입의 값 TRUE를 저장.                               
# Ctrl + Space: 코드 자동 완성. 코드 추천
true <- 1 # 대소문자 구별

# ---vector

ages <- c(1,3,5,2,11)
ages # 벡터 변수 ages에 저장된 모든 값들을 출력.
ages[3] # 벡터 변수 ages에서 인덱스 3번의 값만 출력.

# names 변수에 문자열 5개를 저장

names <- c("minki","minsu","minji","minho","mingu")

# names 를 출력
names

names[5]

# married 변수에 boolean 타입 값 5개를 저장.
married <- c(TRUE,TRUE,FALSE,FALSE,TRUE)
married
married[4]

#벡터는 한가지 타입만 저장할 수 있음.
vectors <- c
