function plotError(x, y, f, f_exact)
  figure;
  err = abs(f-f_exact);
  maxerr = max(err);
  errorplot = surf(x, y, reshape(err, length(x), length(y)));
  set(errorplot, 'FaceColor', 'interp','EdgeColor','none');
  #view(fview);
  colormap jet;
  vcb = colorbar;
  ylim(vcb, [0 maxerr]);
  set(get(vcb, 'YLabel'), 'String', 'Error');
endfunction  