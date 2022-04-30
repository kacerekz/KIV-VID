function [fun] = testFunctions2D(i)
  
  f = {
    @(x, y) 0.75 * exp(-0.25 * ((9*x-2).^2 + (9*y-2).^2)) + 0.75 * exp(-(1/49) * (9*x+1).^2 - 0.1 * (9*y+1).^2) + 0.50 * exp(-0.25 * ((9*x-7).^2 + (9*y-3).^2)) - 0.20 * exp(-((9*x-4).^2 + (9*y-7).^2));
    @(x, y) (tanh(9*y - 9*x) + 1) / 9;
    @(x, y) (1.25 + cos(4.5*y)) ./ (6 + 6*(3*x - 1).^2);
    @(x, y) (exp(-(81/16) .* (x - 0.5).^2 + (y - 0.5).^2)) / 3;
    @(x, y) (exp(-(81/4) .* (x - 0.5).^2 + (y - 0.5).^2)) / 3;
    @(x, y) (1/9) * sqrt(64 - 81*((x - 0.5).^2 + (y - 0.5).^2)) - 0.5;
    @(x, y) sin(3*x) .* cos(3*y);
    @(x, y) sin(9*x) .* cos(9*y);
  };
  
  fun = f{i};
  
endfunction  