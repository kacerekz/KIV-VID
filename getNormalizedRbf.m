function [B] = getNormalizedRbf(B, type)
  
  if (type == 2)
    B2 = B .* B;
    Bsum = sum(B2, 2);

    for i = 1:size(B)(1)
      for j = 1:size(B)(2)
        B(i, j) /= sqrt(Bsum(i));
      endfor
    endfor
    
    clear B2;
    clear Bsum;
  
  else
    Bsum = sum(B, 2);
    
    for i = 1:size(B)(1)
      for j = 1:size(B)(2)
        B(i, j) /= Bsum(i);
      endfor
    endfor
  
    clear Bsum;
  endif

endfunction