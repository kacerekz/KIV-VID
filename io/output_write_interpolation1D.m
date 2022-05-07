#{
Function that saves interpolation figures.
#}
function output_write_interpolation1D(i, input_x, render_x, f, groundTruth, interpolated)

  if not(isfolder("results"))
      mkdir("results")
  end
  
  if not(isfolder("results/data"))
      mkdir("results/data")
  end

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
  name = sprintf("results/data/%02d.png", i);
  print(name, '-dpng', '-S800,600');
  
endfunction