function [A] = getRbfMatrix(x, c, kernel, alpha, isGlobal)
  
  A = zeros(length(x), length(c));

  for i = 1:length(x)
    for j = 1:length(c)
      r = norm(x(i, :) - c(j, :), 2);
      A(i, j) = evaluateKernel(kernel, alpha, r, isGlobal);
    endfor
  endfor

endfunction