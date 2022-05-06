function [A] = calculateNormalizedMatrix(A, type)
  
  if (type == 2)
    A2 = A .* A;
    Asum = sum(A2, 2);

    for i = 1:size(A)(1)
      for j = 1:size(A)(2)
        A(i, j) /= sqrt(Asum(i));
      endfor
    endfor
    
    clear A2;
    clear Asum;
  
  else
    Asum = sum(A, 2);
    
    for i = 1:size(A)(1)
      for j = 1:size(A)(2)
        A(i, j) /= Asum(i);
      endfor
    endfor
  
    clear Asum;
  endif

endfunction