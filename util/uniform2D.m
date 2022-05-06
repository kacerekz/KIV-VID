function [pts] = uniform2D(n)
  x = y = linspace(0, 1, sqrt(n));
  [xx, yy] = meshgrid (x, y);
  xxx = reshape(xx, 1, []);
  yyy = reshape(yy, 1, []);
  pts = [xxx' yyy'];
  scatter(pts(:,1), pts(:,2), 4, 'filled');
endfunction