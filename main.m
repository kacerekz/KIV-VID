
# Clear previous executions
clc; 
clear all; 
close all;

# Add scripts from subdirectories
addpath("io");
addpath("test");
addpath("util");
addpath("data");

# Config
uniform = true;
interpolate = true;
approximate = false;
polynomial = false;
normalize = 2;
dim = 1;
n = 11;

alpha = 1;
_fun = 2;
_kernel = 9;

total_kernels = 15;
total_1Ds = 16;
total_2Ds = 9;

if dim == 1
  if uniform
    pts = uniform1D(n);
  else
    pts = halton1D(n);
  endif
  
elseif dim == 2
  if uniform
    pts = uniform2D(n*n);
  else
    pts = halton2D(n*n);
  endif
endif


filename = "test.html";
file_handle = fopen(filename, 'w');

output_write_html_begin(file_handle);
output_write_table_begin(file_handle);
output_write_header_row(file_handle);

for index = 1:total_1Ds
  _fun = index;
  [kernel, isGlobal, kname] = kernels(_kernel);
  
  # Function type y = f(x)
  if dim == 1
    [fun, fname] = testFunctions1D(_fun);
    
    if interpolate
      [COND, RMSE, R2, MAX_ERR, AVG_DIFF] = ...
        interpolate1D(index, polynomial, normalize, alpha, _fun, _kernel, pts);
        #output_write_row_int(file_handle, index, fname, kname, alpha, COND, RMSE, R2, MAX_ERR, AVG_DIFF);
    endif
    
    if approximate
      [COND, RMSE, R2, MAX_ERR, AVG_DIFF, APPROX_ERR] = ...
        approximate1D(index, polynomial, normalize, alpha, _fun, _kernel, pts);
        output_write_row_appr(file_handle, index, fname, kname, alpha, COND, RMSE, R2, MAX_ERR, AVG_DIFF, APPROX_ERR);
    endif
  
  # Function type z = f(x, y)  
  elseif dim == 2
    [fun, fname] = testFunctions2D(_fun);
    
    if interpolate
      [COND, RMSE, R2, MAX_ERR, AVG_DIFF] = ...
        interpolate2D(index, polynomial, normalize, alpha, _fun, _kernel, pts);
        output_write_row_int(file_handle, index, fname, kname, alpha, COND, RMSE, R2, MAX_ERR, AVG_DIFF);
    endif
    
    if approximate
      [COND, RMSE, R2, MAX_ERR, AVG_DIFF, APPROX_ERR] = ...
        approximate2D(index, polynomial, normalize, alpha, _fun, _kernel, pts);
        output_write_row_appr(file_handle, index, fname, kname, alpha, COND, RMSE, R2, MAX_ERR, AVG_DIFF, APPROX_ERR);
    endif
  endif
  
  close all;
endfor

output_write_table_end(file_handle);
output_write_html_end(file_handle);

fclose(file_handle);
