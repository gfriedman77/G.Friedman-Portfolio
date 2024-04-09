# This is the template for the R script project
# All variable names should be recognizable from lecture
# The function takes two lists, x and y, whose lengths are both n.


st625sls = function(x, y){

  x_bar = mean(x)
  y_bar = mean(y)
  n = length(x)
  
  
  SSxx = sum((x-x_bar)^2)
  SSxy = sum((x-x_bar)*(y-y_bar))
  SSyy = sum((y-y_bar)^2)
  SST = SSyy        #SST is another name for SSyy
  
  #fit the model
  beta1_hat = SSxy/SSxx
  beta0_hat = y_bar-(beta1_hat*x_bar)
  
  #find fitted values and residuals for the n inputs in vector x
  y_hat = beta0_hat+(beta1_hat*x)         #this will be a vector of length n
  residuals = y-y_hat     #this will be a vector of length n
  
  #calculate measures of fit
  SSE = sum(residuals^2)
  s = sqrt(SSE/(n-2))
  Rsq = 1-(SSE/SST)
  
  #standard errors of beta0_hat and beta1_hat
  beta0_SE = s*(sqrt((1/n)+((x_bar)^2/SSxx)))
  beta1_SE = s/(sqrt(SSxx))
  
  #t-scores for testing significance of beta0 and beta1
  beta0_tscore = (beta0_hat-0)/beta0_SE
  beta1_tscore = (beta1_hat-0)/beta1_SE
  
  #p-values for testing significance of beta0 and beta1
  beta0_pvalue = 2*pt((abs(beta0_tscore)),df=n-2,lower.tail=FALSE)
  beta1_pvalue = 2*pt((abs(beta1_tscore)),df=n-2,lower.tail=FALSE)
  
  #Plotting lines with software can be done by plotting points (the screen only has so many pixels, so isn't it the same thing?).
  #We'll plot the confidence bands by finding their values at 1000 particular x-values over the range of the x data
  xp = seq(min(x), max(x), length=1000)    #DON'T CHANGE
  
  #Calculate 95% confidence and prediction intervals at the 1000 particular x-values in xp. These will all be lists of 1000 numbers.
  yp_at_xp = beta0_hat+(beta1_hat*xp)
  SE_yp_at_xp = s*(sqrt(1+(1/n)+(xp-x_bar)^2/SSxx))
  SE_Ey_at_xp = s*(sqrt((1/n)+(xp-x_bar)^2/SSxx))
  CI_yp_upper = yp_at_xp + qt(.975, n-2)*SE_yp_at_xp   #little help :)
  CI_yp_lower = yp_at_xp - qt(.975, n-2)*SE_yp_at_xp
  CI_Ey_upper = yp_at_xp + qt(.975, n-2)*SE_Ey_at_xp 
  CI_Ey_lower = yp_at_xp - qt(.975, n-2)*SE_Ey_at_xp

  
  #DON'T CHANGE
  x_name = deparse(substitute(x))
  y_name = deparse(substitute(y))
  plot(x, y, xlab=paste("x = ", x_name), ylab=paste("y = ", y_name))
  abline(beta0_hat, beta1_hat, lwd=2)
  lines(xp, CI_yp_upper, col="red", lty=2, lwd=1.5)
  lines(xp, CI_yp_lower, col="red", lty=2, lwd=1.5)
  lines(xp, CI_Ey_upper, col="blue", lty=2, lwd=1.5)
  lines(xp, CI_Ey_lower, col="blue", lty=2, lwd=1.5)
  options(digits=4)
  
  #FIX ALL THE MISTAKES!
  cat("\nSimple Least Squares with x = ", x_name, "and y =", y_name,"\n\n")
  cat("The sample regression equation is \n\n\t y = ", beta0_hat, "+", beta1_hat, "* x\n\n")
  cat("Intercept:  SE      =", beta0_SE, "\n\t    t-score =", beta0_tscore, "\n\t    P(>|t|) =", beta0_pvalue, "\n\n")
  cat("Slope:\t    SE      =", beta1_SE, "\n\t    t-score =", beta1_tscore, "\n\t    P(>|t|) =", beta1_pvalue, "\n\n")
  cat("Residual Standard Error is s = ", s, "on", n-2, "degrees of freedom")
  cat("\nCoefficient of Determination is R^2 =", Rsq, "\n\n")

  options(digits=7) # DON'T CHANGE

}
