# 함수(function):

# 함수정의(definition)
# parameter( 파라미터, 매개변수, 인수):
# 전달받은  argument 를 저장하기 위해 선언하는 변수.

subtract <- function(a, b) {
  return(a - b)
}
# 함수호출(call, invoke)
subtract(3,2)

# argument: 함수를 호출할 때 함수에 전달하는 값.

subtract() # 에러발생
subtract(1) #에러발생

# 함수를 정의할 때, 기본값이 설정되지 않은  argument는
# 반드시 함수를 호출할 때 전달해야 함.

subtract(1,2,3) #에러발생
# 함수에 정의된 파라미터 개수보다 더 많은 argument를
# 전달할 수는 없음

# argument를 전달하는 방법:
# 1) positonal argument : 순서대로 전달.

# 2) argument 이름(파라미터)를 명시.
# 순서대로 전달하지 않아도 됨.
subtract(b=5, a=2)

# default argument:
# 함수를 정의할 때 파라미터에 기본값을 설정하는 것.
add <- function(x, y = 0){
  return(x + y)
}

add(1)

# 변수 범위(scope)
x <- "테스트" # global(전역) 변수

test <- function(){
  cat(x,"\n")
  x <- 100 # 지역 변수 (local variable)
  cat(x,"\n")
  
}

test()
x

# 가변 길이 인수 (variable -length argument)
add_all <- function(...){
  args <- list(...)
  sum <- 0
  for (x in args) {
    sum <- sum + x
  }
  return(sum)
}

add_all(1,2,3)


