
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
uniform = false;
interpolate = true;
approximate = false;
polynomial = false;
normalize = 2;
dim = 1;
n = 11;
n = n ** dim;

alpha = 1;
_fun = 2;
_kernel = 9;

# Generate ID string
id_string = makeId(n, dim, uniform, interpolate, polynomial, normalize, _fun, _kernel);

# Start working
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
    pts = uniform2D(n);
  else
    pts = halton2D(n);
  endif
endif

if not(isfolder("results"))
    mkdir("results")
end

if not(isfolder("results/data"))
    mkdir("results/data")
end

dir = strcat("results/data/", id_string);

if not(isfolder(dir))
  mkdir(dir)
else
  rmdir(dir, 's')
  mkdir(dir)
end

filename = strcat(dir, ".html");
file_handle = fopen(filename, 'w');

filename2 = strcat(dir, ".csv");
file_handle2 = fopen(filename2, 'w');

output_write_html_begin(file_handle);
output_write_table_begin(file_handle);

if dim == 1
  output_write_header_row1D(file_handle);
else
  output_write_header_row(file_handle);
endif

for index = 1:total_1Ds
  _fun = index;
  [kernel, isGlobal, kname] = kernels(_kernel);
  
  # Function type y = f(x)
  if dim == 1
    [fun, fname] = testFunctions1D(_fun);
    
    if interpolate
      [COND, RMSE, R2, MAX_ERR, AVG_DIFF] = ...
        interpolate1D(index, dir, polynomial, normalize, alpha, _fun, _kernel, pts);
        output_write_row_int1D(file_handle, index, id_string, fname, kname, alpha, COND, RMSE, R2, MAX_ERR, AVG_DIFF);
        output_csv_int1D(file_handle2, index, COND, RMSE, R2, MAX_ERR, AVG_DIFF);
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
        interpolate2D(index, dir, polynomial, normalize, alpha, _fun, _kernel, pts);
        output_write_row_int(file_handle, index, id_string, fname, kname, alpha, COND, RMSE, R2, MAX_ERR, AVG_DIFF);
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
fclose(file_handle2);
