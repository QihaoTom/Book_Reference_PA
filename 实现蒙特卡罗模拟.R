# 抽来自均匀分布
set.seed(478)
a<-runif(100,min=0,max=1)
a
hist(a)
a<-runif(10000000,min=0,max=1)
hist(a)
set.seed(12)
b<-runif(1000000,min=0,max=1)
b
hist(b)
# 抽来自极值分布
b<--log(-log(a))
hist(b)
# 抽来自正态分布,互为反函数
qnorm(0.5)
pnorm(0)
c<-qnorm(a)
hist(c)
# 直接实现抽正态分布
a<-rnorm(100000,mean = 1,sd=3)
hist(a)
# 直接抽t分布
a<-rt(10000,df=30)
a<-rchisq(10000,df=2)
a<-rf(1000000,df1=20,df2=40)
a<-rpois(1000,lambda=4)
a[1:40]
a<-rlogis(1000000)
a<-rbinom(100000,size=10,prob=0.3)
hist(a)
# Choleski decompsion 从多元正态分布
B<-matrix(c(1,-0.2,-0.2,3),nrow=2,ncol=2)
B
chol(B)
t(chol(B))%*%(chol(B))
