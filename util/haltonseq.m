function [r] = haltonseq(i, b)
  f = 1;
  r = 0;
  
  while i > 0
    f = f / b;
    r = r + f * mod(i, b);
    i = floor(i / b);
  endwhile
endfunction