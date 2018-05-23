# IQR interquartile range
tabstat ytincome,stat(p25 p50 p75 p90 iqr cv) 
# 箱线图可视化
gr box ytincome
gr box weight
gr box weight,over(sex)
gr box ytincome,over(sex)
gr box height,over(party)
gr box weight,over(party)
gr box weight if weight<182.5&weight>58.5
# recode的作用，重新分组
recode polevel 1/3=1 4=0,g(party)
# list 来看具体的某个个体的数据
list sex height weight if height==65
# outliers奇异值
# 方差、标准差
sum weight
return list
# the coefficient of variation 差异系数：相对于均值的变异
# 标准差／均值=相对的离散程度(cv)
# 三个地区的身高,并显示数字
gr bar weight,over(region) over(party) blabel(bar)
gr bar ytincome,over(party) blabel(bar)
gr bar (median) ytincome (sd),over(party) blabel(bar)
# 可显示三个柱子！！
gr bar ytincome (median) ytincome (sd) ytincome ,over(party) blabel(bar)
#
gr bar ytincome,over(party) over(sex) blabel(bar)
# 合并柱子
gr bar ytincome,over(party) over(sex) blabel(bar) asyvars
#
gr bar (sum) weight,over(region)
# 散点图
br
line
scatter 
# 两维图
twoway(scatter)(line)
# 分开两张图by
twoway line sex year,by(sex)
# 放在一张图里是if
# graph export
gr export myfile.pdf,replace
# word里可以打开的两种
gr export myfile.emf,replace
gr export myfile.wmf,replace
# 统计推断与假设检验
# 抽样误差，样本数据推断总体何以可能？概率分布，抽样分布、中央极限定理
# 抽样分布：如果我们从一个总体不断重复抽取规模相同的样本，每个样本的特定统计值，构成
# 一个分布，这就是抽样分布
# 抽样误差：样本的统计值与总体参数之间的差异

# 模拟抽样开始
set obs 10000
gen x = _n
replace x = x-1
preserve
#从中抽了100个样本
sample 100,count
#看样本均值和总体均值的差
sum
#回到preserve时的数据
restore
# 再抽一次
prserve
sample 100,count
sum
restore

# 循环大招
foreach num of numlist 1(1)100:
    use temp,clear
    sample 200,count
    egen ytinc=mean(mytincome)
    keep in 1/1
    drop ytincome
    save 
    

# erase 掉文件 的循环大招
--

** 使用stata模拟中央极限定理
** 虚构一个10000人的总体，取值0-9999

clear
set obs 10000
gen x=_n
replace x=x-1
sum x

save temp, replace /*保存为一个临时数据以备后用*/

* 下面的命令是抽取50个样本量为200人的随机样本
* 样本数或每个样本的样本量可以自定
* 每个样本的样本量越大，抽样分布的均值越接近总体均值
* 并计算每一个样本的均值并保存为数据库

foreach num of numlist 1(1)50 {
	use temp, clear
	sample 200, count
	egen mx=mean(x)
	keep in 1/1
	drop x
	save t`num', replace
}

* 将所有均值的数据合并构成一个抽样分布
clear
use t1, clear
foreach num of numlist 2(1)50 {
	append using t`num'
}

* 检验抽样分布的特征
sum mx
kdensity mx /*检查mx是否服从正态分布*/

* 将临时文件删除
foreach num of numlist 1(1)50 {
	erase t`num'.dta
}

erase temp.dta
exit













