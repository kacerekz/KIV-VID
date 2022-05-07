function [fun, name] = testFunctions2D(i)
  
  f = {
    @(x, y) 0.75 * exp(-0.25 * ((9*x-2).^2 + (9*y-2).^2)) + 0.75 * exp(-(1/49) * (9*x+1).^2 - 0.1 * (9*y+1).^2) + 0.50 * exp(-0.25 * ((9*x-7).^2 + (9*y-3).^2)) - 0.20 * exp(-((9*x-4).^2 + (9*y-7).^2));
    @(x, y) (tanh(9*y - 9*x) + 1) / 9;
    @(x, y) (1.25 + cos(4.5*y)) ./ (6 + 6*(3*x - 1).^2);
    @(x, y) (exp(-(81/16) .* (x - 0.5).^2 + (y - 0.5).^2)) / 3;
    @(x, y) (exp(-(81/4) .* (x - 0.5).^2 + (y - 0.5).^2)) / 3;
    @(x, y) (1/9) * sqrt(64 - 81*((x - 0.5).^2 + (y - 0.5).^2)) - 0.5;
    @(x, y) sin(3*x) .* cos(3*y);
    @(x, y) sin(9*x) .* cos(9*y);
    @(x, y) (2/11) * (sin((4*(2*x-1).^2) + (4*(2*y-1).^2)) - (2*x-1) + (2*y-1) - 5/2);
  };
  
  n = {
    'peaks';
    '\(\frac{tanh(9y - 9x)+1}{9}\)';
    '\(\frac{1.25 + cos(4.5y)}{6 + 6(3x - 1)^2}\)';
    '\(\frac{e^{-\frac{81}{16} (x - 0.5)^2 + (y - 0.5)^2}}{3}\)';
    '\(\frac{e^{-\frac{81}{4} (x - 0.5)^2 + (y - 0.5)^2}}{3}\)';
    '\(\frac{\sqrt{64 - 81 ((x - 0.5)^2 + (y - 0.5)^2)}}{9} - 0.5\)';
    '\(sin(3x) \cdot cos(3y)\)';
    '\(sin(9x) \cdot cos(9y)\)';
    '\(\frac{2}{11} (sin((4(2x-1)^2) + (4(2y-1)^2)) - (2x-1) + (2y-1) - \frac{5}{2})\)';
  };
  
  fun = f{i};
  name = n{i};  
  
endfunction  