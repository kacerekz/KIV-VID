function plotSurf(x, y, f, f_exact)
  err = abs(f - f_exact);
  maxerr = max(err);
  fun = reshape(f, length(x), length(y));
  color = reshape(err, length(x), length(y));
  plt = surf(x, y, fun, color);
  set(plt, 'FaceColor', 'interp', 'EdgeColor', 'none');
  #view(fview)
  colormap jet;
  vcb = colorbar;
  ylim(vcb, [0, maxerr]);
  set(get(vcb, 'YLabel'), 'String', 'Error');
  
  title(['Interpolation error (surface)'])
  xlabel('x')
  ylabel('y')
  zlabel('z')
  
endfunction