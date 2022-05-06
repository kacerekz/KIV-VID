function [pts] = uniform1D(n)
  pts = linspace(0, 1, n)';
  scatter(pts, zeros(length(pts), 1), 4, 'filled');
endfunction