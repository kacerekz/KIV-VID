function [COND, RMSE, R2, MAX_ERR, AVG_DIFF] = interpolate1D(index, dir, polynomial, normalize, alpha, _fun, _kernel, pts)

  [fun] = testFunctions1D(_fun);
  [kernel, isGlobal] = kernels(_kernel);
  
  input_x = pts;
  render_x = (0:0.01:1)';
  centers_x = input_x;
  
  n = length(input_x);
  dim = 2;
    
  B = calculateMatrix(input_x, centers_x, kernel, alpha, isGlobal);
    
  # Optional normalization
  if normalize == 1 || normalize == 2
    B = calculateNormalizedMatrix(B, normalize);
  endif
  
  # Calculate target function values
  f = fun(render_x);
  minval = min(f);
  maxval = max(f);
  f = scaleFunctionValues(fun(input_x), minval, maxval);
  
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
  COND = cond(A)
  lambdas = linsolve(A, f)

  # Calculate simple error
  b = A * lambdas
  err = b - f
  
  # Visualize ground truth
  groundTruth = fun(render_x);
  groundTruth = scaleFunctionValues(groundTruth, minval, maxval);
  #plot(render_x, groundTruth);
  #hold on;
  
  # Visualize interpolated
  interpolated = calculateMatrix(render_x, centers_x, kernel, alpha, isGlobal);

  interpolated_nom = zeros(length(render_x), length(centers_x));
    
  for i = 1:length(render_x)
    for j = 1:length(centers_x)
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
    a0 = lambdas(end-1);
    a1 = lambdas(end);
    
    polynomialTerm = a0 + render_x * a1;
    interpolated += polynomialTerm;
  endif

  #plot(render_x, groundTruth);
  #hold on;
  #plot(render_x, interpolated);
  
  # Metrics
  f_orig = groundTruth;
  f_intp = interpolated;
  
  [RMSE, R2, MAX_ERR, AVG_DIFF] = calculateStatistics(f_orig, f_intp);
  
  output_write_interpolation1D(index, dir, input_x, render_x, f, groundTruth, interpolated);

endfunction