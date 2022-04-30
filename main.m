
# Clear previous executions
clc; 
clear all; 
close all;

# Add scripts from subdirectories
addpath("io");
addpath("test");
addpath("util");

# Config
interpolate = true;
approximate = true;
polynomial = true;
normalize = 2;

alpha = 2.3;
fun = testFunctions1D(1);
[kernel, isGlobal, latexName] = kernels(1);

main1D(interpolate, approximate, polynomial, normalize, alpha, fun, kernel, isGlobal)

filename = "test_file.html";
file_handle = fopen(filename, 'w');

output_write_html_begin(file_handle);
output_write_table_begin(file_handle);
output_write_header_row(file_handle);

fdisp (file_handle, "<tr style=text-align:center>");
fdisp (file_handle, "<td>");
fdisp (file_handle, latexName);
fdisp (file_handle, "</td>");
fdisp (file_handle, "</tr>");

output_write_table_end(file_handle);
output_write_html_end(file_handle);

fclose(file_handle);

