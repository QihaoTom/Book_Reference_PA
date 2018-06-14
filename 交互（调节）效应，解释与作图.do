# 多元线性回归模型（一）统计交互 多元线性回归模型（二）回归假定和诊断
## 统计交互（调节） = 变异、分组、情境（contextual）
# wage=a+b1*male+b2*elite+b3*male_p
gen male=sex==1
gen party=polevel==1
gen wage=ywincome/12
gen male_p=male*party
reg wage male party male_p
性别不平等的政治身份
入党回报会由于性别不同吗
常数项，就是所有自变量为0时的含义
交互显著就是有群体差异
party:male为0时（女性时），党员多赚，男性就是再加上交互项的系数
交互模型的系数，都是有条件的！：两个虚拟变量的交互效应模型可以理解成是4个群体的比较
tab male party,sum(wage) nost nof
# 快捷命令！
reg wage male##party

# 两个以上的交互！！
gen int1=male*region2
gen int2=male*region3
reg wage male region2 region3 int1 int2
# 快捷命令！
reg wage b1.region##male
# 快捷命令！
tab region, gen(region)

########################################
# 定距定比（连续）：教育，
educ_y=a + b1*feduy+b2*male+b3*feduy_m
########################################
# 看父亲教育对子女教育有什么差异？
recode edu -3 14=. 1=0 2=2 3=6 4=9 5=11 6 7=12 8=11 9 10=15 11 12=16 13=20, g(educ_y)
gen feduy_m=feduy*male
reg educ_y feduy male feduy_m
# 系数解释时，相当于在原有的主效应上，加上了群体差异！
# 每一年的教育年限影响，前面已经把教育程度转化为教育年限
# 图示交互效应，
twoway (scatter educ_y feduy) (lfit educ_y feduy if male==0) (lfit educ_y feduy if male==1)

## 当需要控制多个变量时,教育获得的性别差异
# 定距定比，放c.
* Margins plot
reg educ_y c.feduy##male b1.region
margins male, at(feduy=(0(2)20))
marginsplot
marginsplot, noci

## 教育回报的地区差异
gen inter1=region2*educ_y
gen inter2=region3*educ_y
reg wage educ_y region2 region3 inter1 inter2,ro
由于是连续变量，常数项的数值就不像定类变量，已经没有实际含义了
reg wage c.educ_y##b1.region
# 换参照组
reg wage c.educ_y##b2.region
educ_y为中部教育回报，直接看交互项显著与否，即可
# 图1：
twoway (scatter wage educ_y)(lfit wage educ_y if region==1)(lfit wage educ_y if region==2)(lfit wage educ_y if region==3)

# Margin图
reg wage b1.region##c.educ_y
margins region,at(educ_y=(0(2)20))
marginsplot, noci

###############################
# 连续变量之间的交互效应
##############################
## 教育回报是否受到年龄的影响 | wage = a + b1*educ_y+ b2*age+ b3*age_e
gen age_e=educ_y*age
reg wage educ_y age age_e
快捷命令！
reg wage c.educ_y##c.age
## 两个连续变量如何作图！！超级fancy
margins, at(educ_y=(0(2)20) age=(20(10)60))
_marg_save, saving(temp1, replace)
preserve
use temp1,clear
# 每隔500一个颜色
tw contour _margin _at1 _at2, ccut(-1000(500)5000) crule(lin) sc(gs15) ec(gs2) saving(g1, replace)

######################
##  回归诊断
####################
# 误差项需正态分布
scatter y x || lowess y x
scatter weight height || lowess weight height
scatter wage edu || lowess wage edu
scatter wage height || lowess wage height
scatter weight wage || lowess weight wage
gen age=2010-y_birth
scatter weight age || lowess weight age

reg ytincome educ_y
predict e,re
kdensity e,normal 
qnorm e
hettest
rvfplot,yline(0) # 满足假定，是均匀分布在直线的两边！！ | 即为方差的条件零均值假定
rvpplot educ_y,yline(0)

#######
#对数修正
#######
gen lninc=log(ytincome)
reg lninc educ_y
predict e2,re
kdensity e2,normal 
qnorm e
hettest
rvfplot,yline(0)
rvpplot educ_y,yline(0)

# 取反对数 | 解决应变量分布，所以取对数！
dis exp(.145)-1


# 多项式回归 | 倒U型！彩虹关系！！
scatter weight age || lowess weight age
reg weight age,ro
gen agesq=age^2
reg weight age agesq,ro
dis 1.74/(2*0.019)
wherext age agesq
# 看拟合图和模型有多一致
twoway (scatter weight age)(lowess weight age) (qfit weight age)
twoway (scatter weight age)(lowess weight age) (lfit weight age)(qfit weight age)

## 下次课：类别变量回归
