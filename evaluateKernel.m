function [result] = evaluateKernel(kernel, a, r, isGlobal)
  
  r = abs(r);
    
  if isGlobal
    result = kernel(a, r);
  
  elseif r <= (1/a)
    result = kernel(a, r);
  
  else
    result = 0;
  
  endif
  
endfunction  