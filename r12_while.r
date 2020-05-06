# while 반복문
# while (조건식){
#  조건식이 참인 동안에 실행할 문장들
# }

i <- 1
while (i <=5){
  cat(i,"\n")
  i <- i +1
}
# 11 구구단 2단을 while문으로 출력

i <- 1

while (i < 10) {
  cat(2,"x",i,2*i,"\n")
  i <- i+1
}

# repeat 반복문
# repeat {
# 반복할 문장들.
# 반복을 끝낼 수 있는 문장(break)
# }

i <- 1
repeat {
  if(i > 5){
    break
  }
  cat(i," ")
  i <- i + 1
}
