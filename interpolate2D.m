function [COND, RMSE, R2, MAX_ERR, AVG_DIFF] = interpolate2D(index, dir, polynomial, normalize, alpha, _fun, _kernel, pts)
  # Sample input data
  # Sample input data
  render_x = render_y = 0:0.02:1;
  [render_xx, render_yy] = meshgrid (render_x, render_y);

  x = pts(:, 1)';
  y = pts(:, 2)';
  tx = reshape(render_xx, 1, []);
  ty = reshape(render_yy, 1, []);

  input_pts = [x' y']
  render_pts = [tx' ty'];
  center_pts = input_pts;
  
  [kernel, isGlobal] = kernels(_kernel);
  fun = testFunctions2D(_fun);

  B = calculateMatrix(input_pts, center_pts, kernel, alpha, isGlobal);
    
  # Optional normalization
  if normalize == 1 || normalize == 2
    B = calculateNormalizedMatrix(B, normalize);
  endif
  
  # Calculate target function values
  f = fun(tx', ty');
  minval = min(f);
  maxval = max(f);
  f = fun(x', y');
  f = scaleFunctionValues(f, minval, maxval);
  
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
  COND = cond(A)
  lambdas = linsolve(A, f)

  # Calculate simple error
  b = A * lambdas
  err = b - f
  
  # Visualize ground truth
  #figure(fig++);
  #title(strcat("Intepolated, alpha=", num2str(alpha)));

  tf = fun(tx', ty');
  tf = scaleFunctionValues(tf, minval, maxval);
  #tf_reshaped = reshape(tf, length(render_x), length(render_y));
  #{
  surf(render_x, render_y, tf_reshaped,...
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
  #}
  
  # Visualize interpolated
  interpolated = calculateMatrix(render_pts, center_pts, kernel, alpha, isGlobal);

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
  
  interpolated_reshaped = reshape(interpolated, length(render_x), length(render_y));
  #surfc (render_x, render_y, interpolated_reshaped);
  #hold on;
  
  pts = scaleFunctionValues(fun(x', y'), minval, maxval);
  #scatter3(x', y', pts, 'filled');
      
  # Metrics
  f_orig = tf;
  f_intp = interpolated;
  
  [RMSE, R2, MAX_ERR, AVG_DIFF] = calculateStatistics(f_orig, f_intp);
  
  #plotSurf(render_x, render_y, f_intp, f_orig);
  #plotError(render_x, render_y, f_intp, f_orig);
  #hist(abs(f_intp - f_orig), 32);
  
  output_write_interpolation(index, dir, render_x, render_y, interpolated_reshaped, x', y', pts, f_intp, f_orig);
    
endfunction