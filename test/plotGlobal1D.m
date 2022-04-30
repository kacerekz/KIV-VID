#
# Plot global functions
#

function plotGlobal1D(x, a, r)
  gfun1 = exp(-(a .* r) .^ 2);
  gfun2 = r .^ 2 .* log(r + eps);
  gfun3 = 1 ./ (1 + (a .* r) .^ 2)
  gfun4 = 1 ./ sqrt(1 + (a .* r) .^ 2)
  gfun5 = sqrt(1 + (a .* r) .^ 2)

  lab = {
    'exp(-(a .* r) .^ 2)';
    'r .^ 2 .* log(r + eps)';
    '1 ./ (1 + (a .* r) .^ 2)';
    '1 ./ sqrt(1 + (a .* r) .^ 2)';
    'sqrt(1 + (a .* r) .^ 2)';
  };

  figure(1);
  plot (x, gfun1); hold on;
  plot (x, gfun2); hold on;
  plot (x, gfun3); hold on;
  plot (x, gfun4); hold on;
  plot (x, gfun5);
  legend(lab);
  title(strcat("Global kernel functions, alpha=", num2str(a)));
endfunction