#{

Function that creates html table header.

#}
function output_write_header_row(fid)
  fdisp (fid, "<tr style=text-align:center>");

  fdisp (fid, "<th>");
  fdisp (fid, "Function");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Kernel");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Alpha");
  fdisp (fid, "</th>");

  fdisp (fid, "<th>");
  fdisp (fid, "Conditionality");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "RMSE");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "R2");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Max error");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Average difference");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Interpolation");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Error colormap");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Error graph");
  fdisp (fid, "</th>");
  
  fdisp (fid, "<th>");
  fdisp (fid, "Error histogram");
  fdisp (fid, "</th>");
  
  fdisp (fid, "</tr>");
endfunction
