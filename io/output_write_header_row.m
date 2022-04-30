#{

Function that creates html table header.

#}
function output_write_header_row(fid)
  fdisp (fid, "<tr style=text-align:center>");

#{ 
  fdisp (fid, "<th>");
  fdisp (fid, "Dataset name");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Type");
  fdisp (fid, "</th>");
#}
  
  fdisp (fid, "<th>");
  fdisp (fid, "Function");
  fdisp (fid, "</th>");

#{  
  fdisp (fid, "<th>");
  fdisp (fid, "RBF function");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Cond number");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Average difference");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Max error");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "RMSE");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "R2");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Surface");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Contours");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Approximation error sum");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Approximation error hist");
  fdisp (fid, "</th>");
#}
  
  fdisp (fid, "</tr>");
endfunction
