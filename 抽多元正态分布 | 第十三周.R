mu <- c(-1,2.5)
omega<-matrix(c(3,-0.9,-0.9,5),nrow=2,ncol=2)
omega
L<-t(chol(omega)) # 用t先转置
Z<-matrix(nrow=1000,ncol=2)
# 抽k个
set.seed(123)
for (i in 1:1000){
  Z[i,]=L%*%rnorm(2)+mu
}
X<-rnorm(2,mean=0,sd=1)
hist(Z[,1])
mean(Z[,1])
# 样本协方差矩阵
cov(Z)
library(mvtnorm)
z1<-rmvnorm(1000,mu,omega)
