function [kernel, type, latex] = kernels(i)
  
  gf = {
    @(a, r) exp(-((a * r) .^ 2));
    @(a, r) r .^ 2 .* log(r + eps); # SOLVE THIS BETTER
    @(a, r) 1 ./ (1 + (a .* r) .^ 2);
    @(a, r) 1 ./ sqrt(1 + (a .* r) .^ 2);
    @(a, r) sqrt(1 + (a .* r) .^ 2);
   };
   
   lf = {
    @(a, r) (1 - a .* r);
    @(a, r) (1 - a .* r) .^ 2;
    @(a, r) (1 - a .* r) .^ 3;
    @(a, r) (1 - a .* r) .^ 3 .* (3 .* a .* r + 1);
    @(a, r) (1 - a .* r) .^ 3 .* (5 .* a .* r + 1);
    @(a, r) (1 - a .* r) .^ 4 .* (4 .* a .* r + 1);
    @(a, r) (1 - a .* r) .^ 5 .* (8 .* (a .* r) .^2 + 5 .* a .* r + 1);
    @(a, r) (1 - a .* r) .^ 6 .* (35 .* (a .* r) .^2 + 18 .* a .* r + 3);
    @(a, r) (1 - a .* r) .^ 7 .* (16 .* (a .* r) .^2 + 7 .* a .* r + 1);
    @(a, r) (1 - a .* r) .^ 8 .* (32 .* (a .* r) .^2 + 25 .* (a .* r) .^2 + 8 .* a .* r + 1);
  };
  
  f = {gf{:} lf{:}};
  
  globals = true(1, length(gf));
  locals = false(1, length(lf));
  
  t = [globals locals];
  
  l = {
    '\(e^{-(\alpha r)^2}\)';
    '\(r^2 \cdot log(r)\)';
    '\(\frac{1}{1 + (\alpha r)^2}\)';
    '\(\frac{1}{\sqrt(1 + (\alpha r)^2})\)';
    '\(\sqrt(1 + (\alpha r)^2})\)';
    '\(1 - \alpha r)\)';
    '\(1 - \alpha r)^2\)';
    '\(1 - \alpha r)^3\)';
    '\(1 - \alpha r)^3\)';
    '\(1 - \alpha r)^3\)';
    '\(1 - \alpha r)^4\)';
    '\(1 - \alpha r)^5\)';
    '\(1 - \alpha r)^6\)';
    '\(1 - \alpha r)^7\)';
    '\(1 - \alpha r)^8\)';
  };
  
  kernel = f{i};
  type = t(i);
  latex = l{i};
  
endfunction  