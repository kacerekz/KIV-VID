function [pts] = halton1D(n)
  
  from = 0;
  to = 1;
  padding = (to - from) / n;

  m = n - 2;
  ptsh = zeros(m, 1);
  index = 21;
    
  for i=1:m
    ptsh(i) = haltonseq(index, 2);
    index += 409;
  endfor
  
  min = min(ptsh);
  max = max(ptsh);

  from2 = from + padding;
  to2 = to - padding;
  
  ptsh = (ptsh - min) / (max - min);
  ptsh = ptsh * (to2 - from2) + from2;
  
  pts = [from; ptsh; to];
  scatter(pts(:,1), zeros(length(pts), 1), 4, 'filled');

endfunction