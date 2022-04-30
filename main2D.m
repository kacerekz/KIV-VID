#
# main2D.m
#
# Launches scripts comparing the properties of RBFs and normalized RBFs
# for approximations and interpolations of functions in z = f(x, y) format
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
interpolate = true;
approximate = true;
polynomial = true;
normalize = true;

alpha = 2.3;
fun = testFunctions2D(1);
[kernel, isGlobal] = kernels(6);

# Sample input data
input_x = input_y = 0:0.2:1;
render_x = render_y = 0:0.02:1;

[input_xx, input_yy] = meshgrid (input_x, input_y);
[render_xx, render_yy] = meshgrid (render_x, render_y);

x = reshape(input_xx, 1, []);
y = reshape(input_yy, 1, []);
tx = reshape(render_xx, 1, []);
ty = reshape(render_yy, 1, []);

input_pts = [x' y']
render_pts = [tx' ty'];
center_pts = input_pts;

n = length(x);
tn = length(tx);
dim = 3;
fig = 1;

if interpolate
  B = getRbfMatrix(input_pts, center_pts, kernel, alpha, isGlobal);
  
  # Optional normalization
  if normalize 
    B = getNormalizedRbf(B);
  endif
  
  # Calculate target function values
  f = fun(x', y');
  minval = min(f);
  maxval = max(f);
  f = scaleFunctionValues2(f, minval, maxval);
  
  # Optional polynomial
  A = B;
  if polynomial
    e = ones(n, 1);
    Z = zeros(dim);
    P = [e x' y'];
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
  title(strcat("Intepolated, alpha=", num2str(alpha)));

  tf = fun(tx', ty');
  tf = scaleFunctionValues(tf, minval, maxval);
  tf = reshape(tf, length(render_x), length(render_y));
  surf(render_x, render_y, tf,...
    'FaceLighting','gouraud',...
    'MeshStyle','column',...
    'SpecularColorReflectance',0,...
    'SpecularExponent',5,...
    'SpecularStrength',0.2,...
    'DiffuseStrength',1,...
    'AmbientStrength',0.4,...
    'LineWidth',0.2,...
    'FaceAlpha',0.2,...
    'FaceColor',[0.07 0.6 1],...
    'EdgeAlpha',0.2);
  hold on;

  # Visualize interpolated
  interpolated = getRbfMatrix(render_pts, center_pts, kernel, alpha, isGlobal);

  interpolated_nom = zeros(length(render_pts), length(center_pts));
    
  for i = 1:length(render_pts)
    for j = 1:length(center_pts)
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
    a0 = lambdas(end-2);
    a1 = lambdas(end-1);
    a2 = lambdas(end);
    
    polynomialTerm = a0 + tx' * a1 + ty' * a2;
    interpolated += polynomialTerm;
    b = b(1:end-3);
  endif
  
  #figure(fig++);
  interpolated = reshape(interpolated, length(render_x), length(render_y));
  surfc (render_x, render_y, interpolated);
  hold on;
  
  scatter3(x', y', b, 'filled');
  
endif

if approximate
endif


#{
B = zeros(n);

for i = 1:n
  for j = 1:n
    d = norm(train_pts(j, :) - train_pts(i, :), 2);
    B(i, j) = kernel(alpha, d);
  endfor
endfor

#
B2 = B .* B;
Bsum = sum(B2, 2);

for i = 1:n
  for j = 1:n
    B(i, j) /= sqrt(Bsum(i));
  endfor
endfor
#

e = ones(n, 1);
Z = zeros(dim);
P = [e x' y'];
A = [B P; P' Z];

nx = length(train_pts_x);
ny = length(train_pts_y);

f = zeros(nx*ny, 1);

index = 1;
for i = 1:nx
  for j = 1:ny
    f(index++) = fun(train_pts_x(i), train_pts_y(j)); 
  endfor
endfor

z = zeros(dim, 1);
fz = [f; z];

cond(A)
lambdas = linsolve(A, fz)

interpolated = A * lambdas
err = interpolated - fz


figure(1);
surfc (test_pts_x, test_pts_y, fun(test_pts_xx, test_pts_yy));
#f2(train_pts_xx, train_pts_yy)
#surfc([1 2 3], [4 5 6], [1 2 3; 4 5 6; 7 8 9]);

tn = length(tx);
test_interpolated = zeros(tn, 1);

a0 = lambdas(end-2);
a1 = lambdas(end-1);
a2 = lambdas(end);

for i = 1:tn
  sum = 0;
  for j = 1:n
    d = norm(test_pts(i, :) - train_pts(j, :), 2);
    tmp = kernel(alpha, d);
    sum += tmp * tmp;
    test_interpolated(i) += lambdas(j) * tmp;
  endfor
  p_term = a0 + test_pts(i, 1) * a1 + test_pts(i, 2) * a2;
  test_interpolated(i) /= sqrt(sum);
  test_interpolated(i) += p_term;
endfor

tnx = length(test_pts_x);
tny = length(test_pts_y);

figure(2);
test_interpolated = reshape(test_interpolated, tnx, tny);
surfc (test_pts_x, test_pts_y, test_interpolated);
#}

#{
Calculate input values
h = 0.05;
hh = h  * 0.5;

x = [0, 0.025, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.975, 1];
x = 0:h:1;      # training data points
xx = 0:0.01:1;  # testing data points
r = x;          # distances from center
a = 2.3;        # shape parameter

plotGlobal1D(x, a, r);
plotLocal1D(x, a, r);
plotData1D(x);
demo01(x, xx, a, r, h, hh, 1);
#}