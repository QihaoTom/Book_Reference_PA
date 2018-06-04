mu<-0.5
sigma<-3
c<-1
n<-10000
set.seed(123)
u<-runif(1,min = 0,max = 1)
u
x<-sigma*qnorm(u*pnorm((c-mu)/sigma))+mu
# 放入一个矩阵中
x<-matrix(nrow=n,ncol=1)
# 
for(i in 1:n){
  x[i]<-sigma*qnorm(runif(1)*pnorm((c-mu)/sigma))+mu
}
x
hist(x)

# 或者直接一行实现
x<-sigma*qnorm(runif(n)*pnorm((c-mu)/sigma))+mu
hist(x)


