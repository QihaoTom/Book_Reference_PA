# 第十五周 因变量为类别变量的回归
## 多项式回归
## 年龄与体重：类别变量，相当于5点图，显示非线性关系
recode age min/30=1 31/40=2 41/50=3 51/60=4 61/70=5 *=. g(agegroup)
reg weight b1.agegroup
## 人力资本回报
reg wage b1.level
## 收入与体重有关系嘛， 自变量以万元为单位！！系数则较大
gen inc10k=ytincome/10000
gen inc10ksq=inc10k^2
twoway (scatter weight inc10k) (lowess weight inc10k)
reg weight inc10k
reg weight inc10k inc10ksq
wherext inc10k inc10ksq
twoway (scatter weight inc10k) (lowess weight inc10k) ///
	(lfit weight inc10k) (qfit weight inc10k)
## 教育回报是否存在性别差异
    
##########################################
#########第十五周：类别数据分析（一）##########
##########################################
## 列联表与卡方检验 | 线性概率模型 | Binary logistic regression model
## 条件分布 
tab party male,row
tab party male,col
## 卡方检验为列联表，是非参数检验，检验是否相互独立，卡方适用类别变量

## 实际与期望期望频数：(列边缘*行边缘)／n
原假设为独立，显著，则显著拒绝
chi2tail(d.f.,x)
invchi2tail(d.f.,p)
dis chi2tail(1,3.2)
dis invchi2tail(1,0.05)

# 例子1：性别和走夜路
# 例子2：种族和录取
# 例子3: 党员和性别
tab party male,chi2
## 快捷命令 
## 例子：年龄与支付方式，21 27 27 36为第一行，21 36 42 90为第二行，纵轴为时间段，横轴为支付方式
tabi 21 27 27 36 \ 21 36 42 90,chi2
# 例子4:汽车品牌与消费意愿 横轴为是否，纵轴为汽车品牌
## 局限：只能检验两个变量，无法检验一个变量对另一个变量的影响！

# 线性概率模型（基本不同）
# 恒定误差：均匀分布在两侧，LPM模型是OLS回归模型的方法应用于虚拟因变量

## 使用logitic模型对类别因变量进行估计，实质上就是将因变量取值为1的概率进行转换
## Odds, odds ratio 
# 例子：
gen p=4/6 if male=0
gen odds=p(1-p)
dis exp(.6931473)
# 从probability到logit系数
logit employ male
dis exp(-1.791759) # 女性比男性就业几率比高1-exp(-1.791759)倍

# 中国城镇女性就业
tab college lfp,row # 得到概率，算几率

# 当自变量是一个连续变量 ： 教育年限
###########################################################################################################
## 为什么要转化为oddsration：oddsration的变化是恒定的数，因此，可以直接用odds来解释，同线性回归模型！
   比如，受教育年限每增加一年，女性就业的几率就上升14.8%
###########################################################################################################
logit lfp educ_y
logit lfp educ_y,or
logistic lfp educ_y
predict pry

## 模型估计方法：MLE： iterations:卡方检验, MLE比OLS更consistent，检验统计是大样本的z值，而不是t，OLS是t

##  嵌套模型的
logit lfp educ_y
est store A
logit lfp educ_y age
est store B
lrtest B A # 模型之间的比较：若显著，则说明应该要纳入模型
dis 2*(-1164.21-(-1246.5149) # 同lrtest
dis chi2tail(1,164) # 同lrtest
# OLS用的Wald test

logit lfp college age i.region, nolog






































