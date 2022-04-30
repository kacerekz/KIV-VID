#{

Function that saves interpolation figures.

#}

function output_write_interpolation(i, rbfFunction, f, rbf, data, X, Y, newValuesInt2)

  figure('Name', ['Interpolation ', rbfFunction],'NumberTitle','off')
  scatter3((data(:,1)),(data(:,2)),(data(:,f+2)),70,'filled')
  hold on
  surfc(X,Y,newValuesInt2)
  title(['Interpolation F', num2str(f), '(x,y) ', rbfFunction])
  xlabel('x')
  ylabel('y')
  zlabel('f')
  legend({'Zadané body','Interpolaèní povrch'})
  name = sprintf("results/data%d/Interpolation_F%d(x,y)_rbf%d.jpg", i, f, rbf);
  print(name, '-djpg', '-S970,540');
  
  figure('Name',['Interpolation F', num2str(f), '(x,y) ', rbfFunction, ' contours'],'NumberTitle','off')
  contour(X,Y,newValuesInt2)
  name = sprintf("results/data%d/Interpolation_F%d(x,y)_rbf%d_contours.jpg", i, f, rbf);
  print(name, '-djpg', '-S490,490');

endfunction