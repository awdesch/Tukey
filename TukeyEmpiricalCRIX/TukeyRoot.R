# ----------------------------------------------------------------------------
#  Project:     Tukey g- and h- transformations    
# ----------------------------------------------------------------------------
#  Quantlet:    tukeyroot
# ----------------------------------------------------------------------------
#  Description: tukeyroot is an auxiliary code for the main code
#               TukeyEmpirical_gh; tukeyroot solves two nonlinear equations
#               in order to find 'g' and 'h' parameters for approximation
#               or replication of distributions
# ----------------------------------------------------------------------------
#  Author:      
# ----------------------------------------------------------------------------

tukeyroot = function(x){
  
  S=-0.3041; # specify the sample value for skewness 
  K=5.1572; # specify the sample value for kurtosis
  
  F = c(-S + ((3*exp(x[1]^2/(2-6*x[2]))+exp(9*x[1]^2/(2-6*x[2]))-3*exp(2*x[1]^2/(1-3*x[2]))-1)/(x[1]^3*(1-3*x[2])^(1/2)) - 
           3*((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))*((1-2*exp(x[1]^2/(2-4*x[2]))+exp(2*x[1]^2/(1-2*x[2])))/(x[1]^2*(1-2*x[2])^(1/2))) + 
           2*((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))^3)/
       (((1-2*exp(x[1]^2/(2-4*x[2]))+exp(2*x[1]^2/(1-2*x[2])))/(x[1]^2*(1-2*x[2])^(1/2)))-
         ((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))^2)^(3/2), - K + (((exp(8*x[1]^2/(1-4*x[2]))*(1+6*exp(6*x[1]^2/(4*x[2]-1))+exp(8*x[1]^2/(4*x[2]-1))-4*exp(7*x[1]^2/(8*x[2]-2))-4*exp(15*x[1]^2/(8*x[2]-2))))/(x[1]^4*(1-4*x[2])^(1/2)))-
                                                                         4*((3*exp(x[1]^2/(2-6*x[2]))+exp(9*x[1]^2/(2-6*x[2]))-3*exp(2*x[1]^2/(1-3*x[2]))-1)/(x[1]^3*(1-3*x[2])^(1/2)))*((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))-
                                                                         3*((1-2*exp(x[1]^2/(2-4*x[2]))+exp(2*x[1]^2/(1-2*x[2])))/(x[1]^2*(1-2*x[2])^(1/2)))^2 + 
                                                                         12*((1-2*exp(x[1]^2/(2-4*x[2]))+exp(2*x[1]^2/(1-2*x[2])))/(x[1]^2*(1-2*x[2])^(1/2)))*((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))^2 -
                                                                         6*((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))^4)/
       ((((1-2*exp(x[1]^2/(2-4*x[2]))+exp(2*x[1]^2/(1-2*x[2])))/(x[1]^2*(1-2*x[2])^(1/2)))-((exp(x[1]^2/(2-2*x[2]))-1)/(x[1]*(1-x[2])^(1/2)))^2)^2))
  return(F)
}
  # In the main file write the following: 
    
    # x0 = [1; 0];  # Make a starting guess at the solution
  # [x,fval] = fsolve(@tukeyroot,x0) # Call solver
  
  # For reference see Headrick et al. (2008), "Parametric probability
  # densities and distribution functions for Tukey g- and h- Transformations
  # and their Use for Fitting Data", Applied Mathematical Science 2/9,
  # 449-462.