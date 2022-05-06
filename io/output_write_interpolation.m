#{

Function that saves interpolation figures.

#}

function output_write_interpolation(i, x, y, z, pts_x, pts_y, pts_z, f_intp, f_orig)

  if not(isfolder("results"))
      mkdir("results")
  end
  
  if not(isfolder("results/data"))
      mkdir("results/data")
  end

  figure('Name', ['Interpolation'], 'NumberTitle', 'off')
  scatter3(pts_x, pts_y, pts_z, 'filled')
  hold on
  surfc(x,y,z)
  title(['Interpolation'])
  xlabel('x')
  ylabel('y')
  zlabel('z')
  xlim([0 1])
  ylim([0 1])
  zlim([-0.2 1.4])
  xticks(0:0.2:1)
  yticks(0:0.2:1)
  zticks(-0.2:0.2:1.4)
  legend({'Input points','Interpolation'})
  name = sprintf("results/data/%02d.png", i);
  print(name, '-dpng', '-S800,600');
  
  
  figure('Name', ['Interpolation error (surface)'], 'NumberTitle', 'off')
  plotSurf(x, y, f_intp, f_orig);
  name = sprintf("results/data/%02d_errsurf.png", i);
  print(name, '-dpng', '-S800,600');

  
  figure('Name', ['Interpolation error'], 'NumberTitle', 'off')
  plotError(x, y, f_intp, f_orig);
  name = sprintf("results/data/%02d_err.png", i);
  print(name, '-dpng', '-S800,600');
  
  
  figure('Name', ['Error histogram'], 'NumberTitle', 'off')
  hist(abs(f_intp - f_orig), 32);
  title(['Error histogram'])
  xlabel('x')
  ylabel('y')
  zlabel('z')
  name = sprintf("results/data/%02d_histo.png", i);
  print(name, '-dpng', '-S800,600');
  
  #{
  figure('Name',['Interpolation F', num2str(f), '(x,y) ', rbfFunction, ' contours'],'NumberTitle','off')
  contour(X,Y,newValuesInt2)
  name = sprintf("results/data%02d/%02d_errsurf.png", i, i);
  print(name, '-dpng', '-S490,490');
  #}
endfunction