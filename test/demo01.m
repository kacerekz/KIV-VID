function demo01(x, xx, a, r, h, hh, algo)
  
  f = @(val) sin(15 * val .* val) + 5 * val;
  fun = f(x);
  #plot(x, fun); hold on;
  fun2 = f(xx);

  # Get important points
  # 1. Extrema
  [extrema_x, extrema_f] = specialPoints1D(x, fun, fun);
  #plot(extrema_x, extrema_f, 'xr'); hold on;

  # 1. First derivative sign change
  d1 = (f(x + hh) - f(x - hh)) / h;
  [d1_x, d1_f] = specialPoints1D(x, fun, d1);
  #plot(d1_x, d1_f, 'xb'); hold on;

  # 2. Second derivative sign change
  d2 = (f(x + h) - 2 * f(x) + f(x - h)) / (h * h);
  [d2_x, d2_f] = specialPoints1D(x, fun, d2);
  #plot(d2_x, d2_f, 'xb'); hold on;

  # 4. Boundary points
  boundary_pts = [0, 0.05, 0.95, 1];
  f_boundary_pts = f(boundary_pts);
  #plot(boundary_pts, f_boundary_pts, 'or');

  sig_pts = [extrema_x d1_x d2_x];
  sig_pts = unique(sig_pts);
  sig_pts = x;

  # Find coefficients
  kernel = @(alpha, dist) exp(-((alpha * dist) .^ 2));

  A = zeros(length(x), length(sig_pts));

  for i = 1:length(x)
    sum = 0;
    
    for j = 1:length(sig_pts)
      r = abs(x(i) - sig_pts(j));
      A(i, j) = kernel(a, r);
      if (algo == 2) sum += A(i, j); endif
      if (algo == 3) sum += A(i, j) .* A(i, j); endif
    endfor
    
    for j = 1:length(sig_pts)
      if (algo == 2) A(i, j) /= sum; endif
      if (algo == 3) A(i, j) /= sqrt(sum); endif
    endfor
  endfor
  
  lambdas = linsolve(A, fun')

  # Used functions 
  figure(2);
  sum = zeros(1, length(xx));
  
  for j = 1:length(sig_pts)
    r = abs(xx - sig_pts(j));
    if (algo == 2) sum += kernel(a, r); endif;
    if (algo == 3) sum += kernel(a, r) .* kernel(a, r); endif;
  endfor
  
  for j = 1:length(sig_pts)-1
    r = abs(xx - sig_pts(j));
    if (algo == 1) plot(xx, lambdas(j) .* (kernel(a, r))); hold on; endif;
    if (algo == 2) plot(xx, lambdas(j) .* (kernel(a, r) ./ sum)); hold on; endif;
    if (algo == 3) plot(xx, lambdas(j) .* (kernel(a, r) ./ sqrt(sum))); hold on; endif;
  endfor
  
  j = length(sig_pts);
  r = abs(xx - sig_pts(j));
  if (algo == 1) plot(xx, lambdas(j) .* (kernel(a, r))); endif;
  if (algo == 2) plot(xx, lambdas(j) .* (kernel(a, r) ./ sum)); endif;
  if (algo == 3) plot(xx, lambdas(j) .* (kernel(a, r) ./ sqrt(sum))); endif;  
  
  # Approximation
  figure(3);
  a_fun = zeros(1, length(xx));

  for i = 1:length(xx)
    sum = 0;
    
    for j = 1:length(lambdas)
      r = abs(xx(i) - sig_pts(j));
      tmp = kernel(a, r);
      if (algo == 2) sum += tmp; endif
      if (algo == 3) sum += tmp * tmp; endif
    endfor
    
    for j = 1:length(lambdas)
      r = abs(xx(i) - sig_pts(j));
      if (algo == 1) a_fun(i) += lambdas(j) * (kernel(a, r)); endif
      if (algo == 2) a_fun(i) += lambdas(j) * (kernel(a, r) / sum); endif
      if (algo == 3) a_fun(i) += lambdas(j) * (kernel(a, r) / sqrt(sum)); endif
    endfor
  endfor

  plot(xx, fun2); hold on;
  plot(xx, a_fun);

endfunction