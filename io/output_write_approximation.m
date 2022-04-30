#{

Function that saves approximation figures.

#}

function output_write_approximation(i, rbfFunction, rbf, f, data, X, Y, newValuesAppr, newValuesAppr2, error, m)
  
  figure('Name', ['Approximation ', rbfFunction],'NumberTitle','off')
  scatter3((data(:,1)),(data(:,2)),(data(:,f+2)),70,'filled')
  hold on
  scatter3((data(:,1)),(data(:,2)),newValuesAppr,70,'filled')
  surfc(X,Y,newValuesAppr2)
  title(['Approximation ', rbfFunction])
  xlabel('x')
  ylabel('y')
  zlabel('f')
  legend({'Zadané body','Aproximované body', 'Aproximaèní povrch'})
  name = sprintf("results/data%d/Approximation_F%d(x,y)_rbf%d.jpg", i, f, rbf);
  print(name, '-djpg', '-S970,540');
  
  figure('Name',['Approximation F', num2str(f), '(x,y) ', rbfFunction, ' contours'],'NumberTitle','off')
  contour(X,Y,newValuesAppr2)
  name = sprintf("results/data%d/Approximation_F%d(x,y)_rbf%d_contours.jpg", i, f, rbf);
  print(name, '-djpg', '-S490,490');
  
  figure('Name','Error histogram','NumberTitle','off')
  hist(error,m)
  title({'Error histogram'})
  xlabel('error')
  ylabel('frequency')
  name = sprintf("results/data%d/Approximation_error_F%d(x,y)_rbf%d.jpg", i, f, rbf);
  print(name, '-djpg', '-S890,435');
    
endfunction