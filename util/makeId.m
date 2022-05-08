function [id_string] = makeId(n, dim, uniform, interpolate, polynomial, normalize, _fun, _kernel)
  
  if dim == 1
    id_string="1D";
  else
    id_string="2D";
  endif

  if uniform
    id_string=strcat(id_string, "_U");
    id_string=strcat(id_string, int2str(n));
  else
    id_string=strcat(id_string, "_H");
    id_string=strcat(id_string, int2str(n));
  endif

  if interpolate
    id_string=strcat(id_string, "_I");
  else
    id_string=strcat(id_string, "_A");
  endif

  if polynomial
    id_string=strcat(id_string, "_P");
  endif

  if normalize == 1
    id_string=strcat(id_string, "_N1");
  elseif normalize == 2
    id_string=strcat(id_string, "_N2");
  endif

  id_string=strcat(id_string, "_F");
  id_string=strcat(id_string, int2str(_fun));

  id_string=strcat(id_string, "_K");
  id_string=strcat(id_string, int2str(_kernel));
  
endfunction