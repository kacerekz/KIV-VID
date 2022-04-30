#
# Plots all 1D test functions
#

function plotData1D(x)
  tdfun01 = sin(15 * x .* x) + 5 * x;
  tdfun02 = 0.5 * cos(20 * x) + 5 * x;
  tdfun03 = 50 * (0.4 * sin(15 * x .* x) + 5 * x);
  tdfun04 = sin(8 * pi * x);
  tdfun05 = sin(6 * pi * x .* x);
  tdfun06 = sin(25 * x + 0.1) ./ (25 * x + 0.1);
  tdfun07 = 2 * sin(2 * pi * x) + sin(4 * pi * x);
  tdfun08 = 2 * sin(2 * pi * x) + sin(4 * pi * x) + sin(8 * pi * x);
  tdfun09 = -2 * sin(2 * pi * x) + cos(6 * pi * x);
  tdfun10 = 2 * sin(2 * pi * x) + cos(6 * pi * x);
  tdfun11 = -2 * sin(2 * pi * x) + cos(6 * pi * x) - x;
  tdfun12 = -2 * sin(2 * pi * x) - cos(4 * pi * x);
  tdfun13 = atan((10 * x - 5) .^ 3) + 0.5 * atan((10 * x - 8) .^ 3);
  tdfun14 = (4.48 * x - 1.88) .* sin((4.48 * x - 1.88) .^ 2) + 1;
  tdfun15 = exp(10 * x - 6) .* sin((5 * x - 2) .^ 2) + (3 * x - 1) .^ 3;
  tdfun16 = (1 / 9) * tanh(9 * x + 0.5);

  functions = {
    tdfun01;
    tdfun02;
    tdfun03;
    tdfun04;
    tdfun05;
    tdfun06;
    tdfun07;
    tdfun08;
    tdfun09;
    tdfun10;
    tdfun11;
    tdfun12;
    tdfun13;
    tdfun14;
    tdfun15;
    tdfun16;
  };

  # Scale each to <0, 1>
  for i = 1:16
    functions{i} = scaleFunctionValues(functions{i}, 0, 1);
  end

  # Graph 1
  figure(1);
  for i = 1:3
    plot(x, functions{i}); hold on;
  end
  plot(x, functions{4}); 

  # Graph 2
  figure(2);
  for i = 5:7
    plot(x, functions{i}); hold on;
  end
  plot(x, functions{8}); 

  # Graph 3
  figure(3);
  for i = 9:10
    plot(x, functions{i}); hold on;
  end
  plot(x, functions{11});
  
  # Graph 3
  figure(4);
  for i = 12:115
    plot(x, functions{i}); hold on;
  end
  plot(x, functions{16});
endfunction  