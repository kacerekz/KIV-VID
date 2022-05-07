function [A] = calculateNormalizedMatrix(A, type)
  
  if (type == 2)
    A2 = A .* A;
    Asum = sum(A2, 2);

    for i = 1:size(A)(1)
      for j = 1:size(A)(2)
        if Asum(i) == 0
          A(i, j) = A(i, j);
        else
          A(i, j) /= sqrt(Asum(i));
        endif
      endfor
    endfor
    
    clear A2;
    clear Asum;
  
  else
    Asum = sum(A, 2);
    
    for i = 1:size(A)(1)
      for j = 1:size(A)(2)
        if Asum(i) == 0
          A(i, j) = A(i, j);
        else
          A(i, j) /= sqrt(Asum(i));
        endif      
      endfor
    endfor
  
    clear Asum;
  endif

endfunction