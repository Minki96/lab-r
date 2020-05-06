rm(list = ls())

# 리스트(list): 객체들의 집합.
#  key(name)-value의 쌍으로 데이터를 저장할 수 있음.

student <- list(no = 1, name = "오쌤", age=16, gender = "M")
student
# 리스트에서 원소를 접근하는 방법: list$key 
student$age

student2 <- list(2, "홍길동", 20, "F")
student2
student2[[1]]

s1 <- student2[[1]] # [[]]는 값만 리턴함
s2 <- student2[1] # []는 리스트를 리턴함


contact <- list(no = 100,
                name = "오쌤",
                phone = c('010-1111-1234','02-1234-5678','02-8546-4867'),
                email = list(office = 'jake@itwill.co.kr',
                             personal= 'jake@gmail.com')
                  )

contact 
# contact 에서 name값만 출력
contact[[2]]
# contact의 전화번호(phone) 중에서 2번째 번호만 출력
contact$phone[2]
# contact 에서 office 이메일만 출력
contact$email$office


