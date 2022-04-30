#
# Scales values in array to a <0, 1> range
#

function [values] = scaleFunctionValues2(x, minval, maxval)
  values = (x - minval) ./ (maxval - minval);
endfunction