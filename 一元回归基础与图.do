## 方差分析，F检验
oneway weight region, tabulate scheffe
# 大样本很少用方差分析，回归分析更有效率
# 相关分析：相关系数、协方差分析
# 例子：省平均教育年限，和，人均GDP。（人力资本与经济发展）
tab prov
label define pro ///
    11 "Beijing" 12"Tianjin"
# 要有对应的省编码，来进行合并
bysort province:egen proedu=mean(educ_y)
bysort 

tab at_hap
tab at_hap,nol
recode at_hap 4/5=1 .=. *=0,g(happy)

bysort province: egen prohap=mean(happy)
tab prohap

merge m:1 province using gdp2010.dta
tab _merge
drop _merge

# append，同样的变量合并
# 变量不一样，用merge，会把省的变量，放进个体层面，合并起来

scatter province proedu,mlabel(province)
twoway (scatter pergdp prohap, mlabel(province) (lowess prohap progdp)
# 图：身高和体重  
twoway (scatter weight height)(lowess weight height)
twoway (scatter weight age)(lowess weight age)
twoway (scatter height age)(lowess height age)
twoway (scatter weight ytincome)(lowess weight ytincome)
twoway (scatter ytincome age)(lowess ytincome age)

# 图：身高和年龄
browse sex weight height edu if height<100
drop if height<100
drop if age>100
# 相关系数
g age=2018-y_birth
pwcorr weight height age,star(0.05)

# 图：6个教师的年资与工资数据,完美的线性关系
twoway (scatter )

######################################################
# 两个指标：a,intercept/constant  b,slope/coefficient 
######################################################

# 纵轴是rise，横轴是run
# partial derivatives偏导

######################################################
a = mean(Yi) - b mean(Xi)
# 怎么写求和？？
b = sum((xi-xbar)(yi-ybar))/(xi-xbar)^2
######################################################

# 广告与汽车销售
regress depv indepv

##############################################################################
# 残差和，总变差是yi和y均值差的平方，二者相减可得model，模型变差，
# root MSE是对MSR开平方
##############################################################################

# 左上角：table of analysis of variance; 右上角：overall model fit statistics
# 汽车销售量的差异有87.7%来源于广告投入

######################################################################################
# 报告部分的置信区间即为推断总体，考虑b的抽样分布，标准误差=o/root sum(xi-mean(x))^2
# a的抽样分布，标准差=o root (1/n+x2/(sum((xi-x)^2))
#################################################################################

foreach num of numlist {
    use 
    sample 500,count
    reg
    gen a=_b[_cons]
    gem b=_b[educ_y]
    keep in 1/1
    drop ytincome educ_y
    save t'num',replace
    }

foreach num of numlist 1(1)50 {
    append using t'num'.dta
}

foreach num of numlist 1(1)50 {
    earse t'num'.dta
    }

kdensity a 

# 有了coef，和，std Err，相除可得，t值，叫标准误（因为是在样本里）
dis invttail(3,2.44)

#############################
# 决定系数（R2）=相关系数的平方 #
#############################

##############################################################################
# 教育水平影响收入:一个很好的例子，分段回归，能够识别不同群体的效应
# 把直线和曲线拟合放在一张图里，可以比较拟合效果
tw (scatter wage educ) (lowess wage educ) (lfit wage educ)
tw (scatter wage educ) (lowess wage educ) (lfitci wage educ)
##############################################################################

##############################################################################
# 图里发现，教育程度低的拟合程度低，因此，可以分群体回归，加入if educ<12
reg wage educ if educ<12
reg wage educ if educ>=12
##############################################################################

# 电视的坏处，电视导致肥胖，刺激消费，导致欠债
tw (scatter debt tel)(lowess debt tel) (lfit debt tel)

# 自变量为二项变量的简单回归，性别、户口
tab party,sum(weight)
a=mean(male=0)
b=mean(male=1)-mean(male=0)



















































