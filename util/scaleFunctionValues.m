#
# Scales values in array to a <0, 1> range
#

function [values] = scaleFunctionValues(x)
  minval = min(x);
  maxval = max(x);
  values = (x - minval) ./ (maxval - minval);
endfunction