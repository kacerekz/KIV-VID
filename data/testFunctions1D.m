function [fun, name] = testFunctions1D(i)
  
  f = {
    @(x) sin(15 * x .* x) + 5 * x;
    @(x) 0.5 * cos(20 * x) + 5 * x;
    @(x) 50 * (0.4 * sin(15 * x .* x) + 5 * x);
    @(x) sin(8 * pi * x);
    
    @(x) sin(6 * pi * x .* x);
    @(x) sin(25 * x + 0.1) ./ (25 * x + 0.1);
    @(x) 2 * sin(2 * pi * x) + sin(4 * pi * x);
    @(x) 2 * sin(2 * pi * x) + sin(4 * pi * x) + sin(8 * pi * x);
    
    @(x) -2 * sin(2 * pi * x) + cos(6 * pi * x);
    @(x) 2 * sin(2 * pi * x) + cos(6 * pi * x);
    @(x) -2 * sin(2 * pi * x) + cos(6 * pi * x) - x;
    @(x) -2 * sin(2 * pi * x) - cos(4 * pi * x);
    
    @(x) atan((10 * x - 5) .^ 3) + 0.5 * atan((10 * x - 8) .^ 3);
    @(x) (4.48 * x - 1.88) .* sin((4.48 * x - 1.88) .^ 2) + 1;
    @(x) exp(10 * x - 6) .* sin((5 * x - 2) .^ 2) + (3 * x - 1) .^ 3;
    @(x) (1 / 9) * tanh(9 * x + 0.5);
  };
  
  n = {
    '\(sin(15x^2) + 5x \)';
    '\(0.5 \cdot cos(20x) + 5x\)';
    '\(50 \cdot (0.4 \cdot sin(15x^2) + 5x)\)';
    '\(sin(8 \pi x)\)';
    
    '\(sin(6 \pi x^2)\)';
    '\(\frac{sin(25x + 0.1)}{25x + 0.1}\)';
    '\(2 \cdot sin(2 \pi x) + sin(4 \pi x)\)';
    '\(2 \cdot sin(2 \pi x) + sin(4 \pi x) + sin(8 \pi x)\)';
    
    '\(-2 \cdot sin(2 \pi x) + cos(6 \pi x)\)';
    '\(2 \cdot sin(2 \pi x) + cos(6 \pi x)\)';
    '\(-2 \cdot sin(2 \pi x) + cos(6 \pi x) - x\)';
    '\(-2 \cdot sin(2 \pi x) - cos(4 \pi x)\)';
    
    '\(atan((10x - 5)^3) + 0.5 \cdot atan((10x - 8)^3)\)';
    '\((4.48x - 1.88) \cdot sin((4.48x - 1.88)^ 2) + 1\)';
    '\(exp(10x - 6) \cdot sin((5x - 2)^2) + (3x - 1)^3\)';
    '\((1 / 9) \cdot tanh(9x + 0.5)\)';
  };
  
  fun = f{i};
  name = n{i};
  
endfunction  