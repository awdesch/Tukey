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

