[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## ![qlogo](http://quantnet.wiwi.hu-berlin.de/graphics/quantlogo.png) **TukeyEmpiricalCRIX** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)



```yaml

Name of Quantlet: TukeyEmpriricalCRIX

Published in: Gitlab

Description: 'TukeyEmpirical_gh estimates parameters 'g' and 'h' by matching the skew and the kurtosis of Tukey g- and h- transformations to the empirical sample equivalents; Auxiliary code is 'TukeyRoot.R''

Keywords: 'standard normal, Tukey transform, g-h-transform, transformation, CRIX'

See also: 'TukeyContour, TukeyQQ, TukeyQuantiles'

Author: Awdesch Melzer
```


```R
# clear history
rm(list=ls(all=T))
graphics.off()


# install and load packages
libraries = c("zoo", "tseries", "xts", "moments","rootSolve")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# read data to Matlab workspace
load(file = "crix.RData")
# plot of crix
# plot(as.xts(crix), type="l", auto.grid=FALSE, main = NA)
plot(crix1, ylab = NA, xlab = NA)

# plot of crix return
ret = diff(log(crix1))

d = length(ret)

plot(density(ret))

# calculate summary statistics of the data: mean, std, skew, kurtosis
S    = skewness(ret)
K    = kurtosis(ret)
mean = mean(ret)
std  = sd(ret)

# specify obtained values S for skew and K for kurtosis in the auxiliary 'tukeyroot' file 
# find 'g' and 'h' values by solving the system of nonlinear equations
source("TukeyRoot.R")

x0 = c(1, 0)  # Make a starting guess at the solution
x = multiroot(tukeyroot,x0) # Call solver
x$root # g
x = x$root # h

# calculate two central moments of Tukey distribution as well as expectation and
# variance

E1 = (exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2));
E2 = (1-2*exp(x[1]^2/(2-4*x[2]))+exp(2*x[1]^2/(1-2*x[2])))/(x[1]^2*(1-2*x[2])^(1/2));

tukey_mean = E1;
tukey_variance = E2-E1^2;

# calculate values necessary for the linear transformation

a=std/tukey_variance;
b=mean - a*tukey_mean;

# specify linear transformation as following:

R=rnorm(10000);
fit = a*((1/x[1])*exp(x[2]*R^2/2)*(exp(x[1]*R)-1))+b;

# For reference see Headrick et al. (2008), "Parametric probability
# densities and distribution functions for Tukey g- and h- Transformations
# and their Use for Fitting Data", Applied Mathematical Science 2/9,
# 449-462.

```
