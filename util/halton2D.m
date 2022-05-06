function [pts] = halton2D(n)
  
  n = sqrt(n);
  
  from = 0;
  to = 1;
  padding = (to - from) * 0.05;

  x = linspace(from, to, n)';
  z = zeros(n, 1);
  e = ones(n, 1);

  pts = [x, z; x, e; z, x; e, x];

  m = n * n - length(pts);
  ptsh = zeros(m, 2);
  index = 21;

  scale = @(value) value * ((to - from) - 2* padding) + padding;
  
  for i=1:m
    hx = haltonseq(index, 2);
    hy = haltonseq(index, 3);
    index += 409;
    ptsh(i, 1) = scale(hx);
    ptsh(i, 2) = scale(hy);
  endfor

  pts = [pts; ptsh];
  scatter(pts(:,1), pts(:,2), 4, 'filled');

endfunction