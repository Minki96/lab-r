# 제어문: 조건문, 반복문.
# for 반복문
# for (변수 in 벡터/리스트....){
# 반복할 문장들.
# }
v <- 1:5
class(v)

for (i in v) {
  print(i)
}

print(i)
cat(i) # concatenate and print

cat("i =", i)


# v <- c(1:9)
# for (i in v){
#  for (j in v) {
#    cat(i,"x",j,"=",i*j,"\n")
#  }
#  cat("-----------\n")
# }

v <- c(1:9)
for (i in v){
  for (j in 1:i) {
    cat(i,"x",j,"=",i*j,"\n")
    
  }
  cat("-----------\n")
}

# a %% b: a를 b로 나눈 나머지 계산
# a %/% b: a를 b로 나눈 몫 계산

c(1, 2, 3) %% 2
c(1, 2, 3) %/% 2

v <- c(10, 21, 55, 98)
for (i in v) {
  if (i %% 2 == 0) {
    cat(i," = 짝수\n")
  } else  {
    cat (i," = 홀수\n")
  }
  
}

# break: 반복문을 중간에 종료할 때 사용.
for (i in 1:10){
  cat(i, "\n")
  if (i >= 5)
    break
}

# break를 사용한 구구단 출력
# 2중 반복문 안에서 가장 가까운 반복문만 종료함.

for (i in 1:9){
  for (j in 1:9) {
    cat(i,"x",j,"=",i*j,"\n")
    if (j == i){
      break
    }
  }
  cat("-----------\n")
}

# next: 반복하던 블록을 멈추고, 그 다음 반복을 위해서
# 반복문 처음으로 돌아감.

for (i in 1:5){
  if(i == 3){
    next
  }
  cat(i,"\n")
}

# 1~10까지 정수들 중에서 짝수만 출력

for (i in 1:10){
  if(i%%2==1){
    next
  }
  cat(i,"\n")
}

for (i in 1:10){
  if(i%%2==0){
    cat(i,"\n")
    
  }
}




