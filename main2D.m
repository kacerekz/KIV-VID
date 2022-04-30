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
normalize = 1;

alpha = 2.3;
fun = testFunctions2D(1);
[kernel, isGlobal] = kernels(9);

# Sample input data
input_x = input_y = 0:0.1:1;
render_x = render_y = 0:0.02:1;

[input_xx, input_yy] = meshgrid (input_x, input_y);
[render_xx, render_yy] = meshgrid (render_x, render_y);

x = reshape(input_xx, 1, []);
y = reshape(input_yy, 1, []);
tx = reshape(render_xx, 1, []);
ty = reshape(render_yy, 1, []);

input_pts = [x' y'];
render_pts = [tx' ty'];
center_pts = input_pts;

n = length(x);
tn = length(tx);
dim = 3;
fig = 1;

if interpolate
  B = getRbfMatrix(input_pts, center_pts, kernel, alpha, isGlobal);
  
  # Optional normalization
  if normalize == 1 || normalize == 2
    B = getNormalizedRbf(B, normalize);
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
  tf = scaleFunctionValues2(tf, minval, maxval);
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
  if normalize == 1
    interpolated_div = sum(interpolated, 2);
    interpolated = interpolated_nom ./ interpolated_div;
  elseif normalize == 2
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
  
  interpolated = reshape(interpolated, length(render_x), length(render_y));
  surfc (render_x, render_y, interpolated);
  hold on;
  
  pts = scaleFunctionValues2(fun(x', y'), minval, maxval);
  scatter3(x', y', pts, 'filled');
  
endif

##################################################################

if approximate
  # Get important points
  sig_x = sig_y = 0:0.2:1;
  [sig_xx, sig_yy] = meshgrid (sig_x, sig_y);
  sx = reshape(sig_xx, 1, []);
  sy = reshape(sig_yy, 1, []);
  sig_pts = [sx' sy'];
  
  # Find A
  A = getRbfMatrix(input_pts, sig_pts, kernel, alpha, isGlobal);
  
  # Optional normalization
  if normalize == 1 || normalize == 2
    A = getNormalizedRbf(A, normalize);
  endif
  
  # Calculate target function values
  f = fun(x', y');
  minval = min(f);
  maxval = max(f);
  f = scaleFunctionValues2(f, minval, maxval);
  
  # Optional polynomial
  if polynomial
    e = ones(n, 1);
    P = [e x' y'];
    
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
  title(strcat("Approximated, alpha=", num2str(alpha)));

  tf = fun(tx', ty');
  tf = scaleFunctionValues2(tf, minval, maxval);
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
  
  # Visualize approximated
  approximated = getRbfMatrix(render_pts, sig_pts, kernel, alpha, isGlobal);

  approximated_nom = zeros(length(render_pts), length(sig_pts));
    
  for i = 1:length(render_pts)
    for j = 1:length(sig_pts)
      approximated_nom(i, j) = approximated(i, j) * lambdas(j);
    endfor
  endfor

  approximated_nom = sum(approximated_nom, 2);

  # Optional normalization
  if normalize == 1
    approximated_div = sum(approximated, 2);
    approximated = approximated_nom ./ approximated_div;
  elseif normalize == 2
    approximated_div = sum(approximated .* approximated, 2);
    approximated = approximated_nom ./ sqrt(approximated_div);
  else
    approximated = sum(approximated_nom, 2);
  endif
  
  # Optional polynomial
  if polynomial
    a0 = lambdas(end-2);
    a1 = lambdas(end-1);
    a2 = lambdas(end);
    
    polynomialTerm = a0 + tx' * a1 + ty' * a2;
    approximated += polynomialTerm;
    b = b(1:end-3);
  endif
  
  approximated = reshape(approximated, length(render_x), length(render_y));
  surfc (render_x, render_y, approximated);
  hold on;
  
  pts = scaleFunctionValues2(fun(sx', sy'), minval, maxval);
  scatter3(sx', sy', pts, 'filled');
  
endif