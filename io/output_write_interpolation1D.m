#{
Function that saves interpolation figures.
#}
function output_write_interpolation1D(i, dir, input_x, render_x, f, groundTruth, interpolated)

  figure('Name', ['Interpolation'], 'NumberTitle', 'off')
  scatter(input_x, f, 10);
  hold on;
  plot(render_x, groundTruth);
  hold on;
  plot(render_x, interpolated);
  title(['Interpolation'])
  xlabel('x')
  ylabel('y')
  xlim([0 1])
  ylim([0 1])
  xticks(0:0.1:1)
  yticks(0:0.1:1)
  legend({'Input points', 'Ground truth','Interpolation'},'Location','northwest')
  name = sprintf("%s/%02d.png", dir, i);
  print(name, '-dpng', '-S800,600');
  
endfunction