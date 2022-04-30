#
# Finds points where the sign changes
#

function [out_x, out_f] = specialPoints1D(x, f, fun)
  
  count = 0;
  
  for i = 2:length(x)-1
    if (sign(fun(i+1) - fun(i)) != sign(fun(i) - fun(i - 1)))
      count++;
    endif
  endfor

  out_x = zeros(1, count);
  out_f = zeros(1, count);
  count = 1;

  for i = 2:length(x)-1
    if (sign(fun(i+1) - fun(i)) != sign(fun(i) - fun(i - 1)))
      out_x(count) = x(i);
      out_f(count) = f(i);
        count++;
    endif
  endfor
  
endfunction  