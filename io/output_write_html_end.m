#
# Function that ends the html document
#
function output_write_html_end(file_handle)
  fdisp(file_handle, "</body>");
  fdisp(file_handle, "</html>");
endfunction
