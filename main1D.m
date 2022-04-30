#
# main1D.m
#
# Launches scripts comparing the properties of RBFs and normalized RBFs
# for approximations and interpolations of functions in y = f(x) format
#

# Clear previous executions
clc; 
clear all; 
close all;

# Add scripts from subdirectories
addpath("io");
addpath("test");
addpath("util");

# Config
interpolate = false;
approximate = true;
polynomial = true;
normalize = true;

alpha = 2.3;
fun = testFunctions1D(1);
[kernel, isGlobal] = kernels(9);

# Sample input data
input_x = (0:0.05:1)';
render_x = (0:0.01:1)';
centers_x = input_x;

n = length(input_x);
dim = 2;
fig = 1;

h = 0.01;
hh = h/2;

# Interpolate
if interpolate
  B = getRbfMatrix(input_x, centers_x, kernel, alpha, isGlobal);
  
  # Optional normalization
  if normalize 
    B = getNormalizedRbf(B);
  endif
  
  # Calculate target function values
  f = zeros(n, 1);
  for i = 1:n
    f(i) = fun(input_x(i));
  endfor
  minval = min(f);
  maxval = max(f);
  f = scaleFunctionValues2(f, minval, maxval);
  
  # Optional polynomial
  A = B;
  if polynomial
    e = ones(n, 1);
    Z = zeros(dim);
    P = [e input_x];
    A = [B P; P' Z];
    z = zeros(dim, 1);
    f = [f; z];
  endif
  
  # Calculate coefficients
  cond(A)
  lambdas = linsolve(A, f)

  # Calculate simple error
  b = A * lambdas
  err = b - f
  
  # Visualize ground truth
  figure(fig++);
  groundTruth = fun(render_x);
  groundTruth = scaleFunctionValues2(groundTruth, minval, maxval);
  plot(render_x, groundTruth);
  hold on;
  
  # Visualize interpolated
  interpolated = getRbfMatrix(render_x, centers_x, kernel, alpha, isGlobal);

  interpolated_nom = zeros(length(render_x), length(centers_x));
    
  for i = 1:length(render_x)
    for j = 1:length(centers_x)
      interpolated_nom(i, j) = interpolated(i, j) * lambdas(j);
    endfor
  endfor

  interpolated_nom = sum(interpolated_nom, 2);

  # Optional normalization
  if normalize
    interpolated_div = sum(interpolated .* interpolated, 2);
    interpolated = interpolated_nom ./ sqrt(interpolated_div);
  else
    interpolated = sum(interpolated_nom, 2);
  endif
  
  # Optional polynomial
  if polynomial
    a0 = lambdas(end-1);
    a1 = lambdas(end);
    
    polynomialTerm = a0 + render_x * a1;
    interpolated += polynomialTerm;
  endif

  plot(render_x, interpolated);
endif  

##################################################################

# Approximate
if approximate
  # Get important points
  figure(fig++);
  x = 0:0.001:1;
  
  funx = fun(x);
  minval = min(funx);
  maxval = max(funx);

  s = @(val) scaleFunctionValues2(val, minval, maxval);

  funx = s(funx); 
  plot(x, funx);
  hold on;

  # 1. Extrema
  [extrema_x, extrema_f] = specialPoints1D(x, funx, funx);
  plot(extrema_x, extrema_f, 'xr'); hold on;

  # 1. First derivative sign change
  d1 = (s(fun(x + hh)) - s(fun(x - hh))) / h;
  [d1_x, d1_f] = specialPoints1D(x, funx, d1);
  plot(d1_x, d1_f, 'xb'); hold on;

  # 2. Second derivative sign change
  d2 = (s(fun(x + h)) - 2 * funx + s(fun(x - h))) / (h * h);
  [d2_x, d2_f] = specialPoints1D(x, funx, d2);
  plot(d2_x, d2_f, 'xg'); hold on;

  # 4. Boundary points
  boundary_pts = [0, 0.05, 0.95, 1];
  f_boundary_pts = s(fun(boundary_pts));
  plot(boundary_pts, f_boundary_pts, 'or');

  # Extract only unique points
  sig_pts = [extrema_x d1_x d2_x];
  sig_pts = unique(sig_pts);
  
  # Find A
  A = zeros(length(input_x), length(sig_pts));

  for i = 1:length(input_x)
    for j = 1:length(sig_pts)
      r = norm(input_x(i) - sig_pts(j), 2);
      A(i, j) = evaluateKernel(kernel, alpha, r, isGlobal);
    endfor
  endfor
  
  # Optional normalization
  if normalize 
    A = getNormalizedRbf(A);
  endif
  
  # Calculate target function values
  f = s(fun(input_x));
  
  # Optional polynomial
  if polynomial
    e = ones(n, 1);
    P = [e input_x];
    
    AtA = A' * A;
    AtP = A' * P;
    PtA = P' * A;
    PtP = P' * P;
    Atf = A' * f;
    Ptf = P' * f;
    
    A = [AtA AtP; PtA PtP];
    f = [Atf; Ptf];
  endif
  
  # Calculate coefficients
  cond(A)
  lambdas = linsolve(A, f)

  # Calculate simple error
  b = A * lambdas
  err = b - f
  
  # Visualize ground truth
  figure(fig++);
  groundTruth = s(fun(render_x));
  plot(render_x, groundTruth);
  hold on;
  
  # Visualize approximated
  approximated = zeros(length(render_x), length(sig_pts));

  for i = 1:length(render_x)
    for j = 1:length(sig_pts)
      r = norm(render_x(i) - sig_pts(j), 2);
      approximated(i, j) = evaluateKernel(kernel, alpha, r, isGlobal);
    endfor
  endfor
  
  approximated_nom = zeros(length(render_x), length(sig_pts));
    
  for i = 1:length(render_x)
    for j = 1:length(sig_pts)
      approximated_nom(i, j) = approximated(i, j) * lambdas(j);
    endfor
  endfor

  approximated_nom = sum(approximated_nom, 2);

  # Optional normalization
  if normalize
    approximated_div = sum(approximated .* approximated, 2);
    approximated = approximated_nom ./ sqrt(approximated_div);
  else
    approximated = sum(approximated_nom, 2);
  endif
  
  # Optional polynomial
  if polynomial
    a0 = lambdas(end-1);
    a1 = lambdas(end);
    
    polynomialTerm = a0 + render_x * a1;
    approximated += polynomialTerm;
  endif

  plot(render_x, approximated);
  
endif









