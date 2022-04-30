#
# Plot local functions
#

function plotLocal1D(x, a, r)
  lfun1 = (1 - a .* r);
  lfun2 = (1 - a .* r) .^ 2;
  lfun3 = (1 - a .* r) .^ 3;
  lfun4 = (1 - a .* r) .^ 3 .* (3 .* a .* r + 1);
  lfun5 = (1 - a .* r) .^ 3 .* (5 .* a .* r + 1);
  lfun6 = (1 - a .* r) .^ 4 .* (4 .* a .* r + 1);
  lfun7 = (1 - a .* r) .^ 5 .* (8 .* (a .* r) .^2 + 5 .* a .* r + 1);
  lfun8 = (1 - a .* r) .^ 6 .* (35 .* (a .* r) .^2 + 18 .* a .* r + 3);
  lfun9 = (1 - a .* r) .^ 7 .* (16 .* (a .* r) .^2 + 7 .* a .* r + 1);
  lfun10= (1 - a .* r) .^ 8 .* (32 .* (a .* r) .^2 + 25 .* (a .* r) .^2 + 8 .* a .* r + 1);

  lab = {
    '1 - a .* r';
    '(1 - a .* r) .^ 2';
    '(1 - a .* r) .^ 3';
    '(1 - a .* r) .^ 3 .* (3 .* a .*r + 1)';
    '(1 - a .* r) .^ 3 .* (5 .* a .*r + 1)';
    '(4 .* (4 .* a .* r + 1)';
    '(8 .* (a .* r) .^2 + 5 .* a .* r + 1)';
    '(35 .* (a .* r) .^2 + 18 .* a .* r + 3)';
    '(16 .* (a .* r) .^2 + 7 .* a .* r + 1)';
    '(32 .* (a .* r) .^2 + 25 .* (a .* r) .^2 + 8 .* a .* r + 1)';
  };

  figure(2);
  plot (x, lfun1); hold on;
  plot (x, lfun2); hold on;
  plot (x, lfun3); hold on;
  plot (x, lfun4); hold on;
  plot (x, lfun5); hold on;
  plot (x, lfun6); hold on;
  plot (x, lfun7); hold on;
  plot (x, lfun8); hold on;
  plot (x, lfun9); hold on;
  plot (x, lfun10);
  legend(lab);
  title(strcat("Local kernel functions, alpha=", num2str(a)));
endfunction  