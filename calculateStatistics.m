function [RMSE, R2, MAX_ERR, AVG_DIFF] = calculateStatistics(f_orig, f_new)
  
  n = length(f_orig);
  
  RMSE = sqrt(sum((f_orig - f_new) .^ 2 ./ n));

  originalMeanValue = mean(f_orig);
  SStot = sum((f_orig - originalMeanValue).^2);
  SSres = sum((f_orig - f_new) .^ 2);
  R2 = 1 - SSres/SStot;
  
  MAX_ERR = max(abs(f_orig - f_new));
  AVG_DIFF = abs(sum(f_orig)/n - sum(f_new)/n);
  
endfunction  