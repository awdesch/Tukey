![http://quantnet.wiwi.hu-berlin.de/style/banner.png](http://quantnet.wiwi.hu-berlin.de/style/banner.png)

## ![qlogo](http://quantnet.wiwi.hu-berlin.de/graphics/quantlogo.png) **TukeyQuantiles**



```yaml

Name of Quantlet: TukeyQuantiles

Published in: Gitlab

Description: 'TukeyQuantiles calculates quantiles for g- and h- modified standard normal random variables and returns a table for different g, h values and alpha levels'

Keywords: 'standard normal, Tukey transform, g-h-transform, transformation, table'

See also: 'TukeyContour, TukeyQQ, TukeyEmpirical'

Author: Awdesch Melzer
```


```R
# clear history
rm(list=ls(all=T))


tukey.fun = function(prob, g, h){
  qp   = qnorm(prob,0,1)
  if(g == 0 & h == 0){
    stat = qp
  }else if(g == 0 & h > 0){
    stat = qp*exp(h*qp^2/2)
  }else if(h==0&g!=0){
    stat = (1/g)*(exp(g*qp)-1)
  }else if(h>0 & g!=0){
   stat =  (1/g)*exp(h*qp^2/2)*(exp(g*qp)-1)
  }
  return(stat)
}


# quantile of the standard normal distribution is given as
prob = c(0.005, 0.01, 0.05, 0.9, 0.995)# seq(0.001,0.999,by=0.001)#


# specify values of 'g' and 'h' parameters
g = c(0, 0, 0, 0.5, 0.5, 0.5)
h = c(0, 0.25, 0.5, 0, 0.25, 0.5)

tab = sapply(X = 1:6, FUN=function(X){tukey.fun(prob, g[X], h[X])}, simplify = T)
stat.table = t(tab)
rownames(stat.table) = paste("g =",g, "h =",h)
colnames(stat.table) = paste(prob)
round(stat.table,2)

# 0.005  0.01  0.05  0.9 0.995
# 0 0       -2.58 -2.33 -1.64 1.28  2.58
# 0 0.25    -5.90 -4.58 -2.31 1.57  5.90
# 0 0.5    -13.53 -9.00 -3.24 1.93 13.53
# 0.5 0     -1.45 -1.38 -1.12 1.80  5.25
# 0.5 0.25  -3.32 -2.70 -1.57 2.21 12.03
# 0.5 0.5   -7.61 -5.32 -2.21 2.71 27.58

```
