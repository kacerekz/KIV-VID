#
# Scales values in array to a <0, 1> range
#

function [values] = scaleFunctionValues(varargin)
  if (nargin == 1)
    x = varargin{1};
    minval = min(x);
    maxval = max(x);
    values = (x - minval) ./ (maxval - minval);
  elseif nargin == 3
    x = varargin{1};
    minval = varargin{2};
    maxval = varargin{3};
    values = (x - minval) ./ (maxval - minval);
  else
    values = 0;
  endif
endfunction