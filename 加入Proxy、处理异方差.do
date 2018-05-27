* 异方差的处理（已不是重点，权当练习）






reg price lotsize bdrms sqrft
* 有没有遗漏平方项、交互项的检验，然而只能发现问题，仍然不知道问题在哪儿
ovtest
* 放入Proxy: IQ， 没有IQ，可能就得到reduced form的系数
reg lwage educ tenure married south urban black
reg lwage educ tenure married south urban black IQ
* 而，教育和能力可能存在高度相关,加入interaction: eduIQ
reg lwage educ tenure married south urban black IQ eduIQ
gen eduIQ=edu*IQ
* Proxy： 用上一期的犯罪率
reg lcrimes llawexpc unem lcrmrt_1 if year==87 
