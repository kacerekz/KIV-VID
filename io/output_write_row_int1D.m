#{

Function that writes html table row and fill it with given interpolationdata.

#}
function output_write_row_int1D(fid, i, dir, fname, kname, alpha, cond, rmse, r2, maxerr, avgdiff)
  fdisp (fid, "<tr style=text-align:center>");
  
  fdisp (fid, "<td>");
  fdisp (fid, fname);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, kname);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, alpha);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, cond);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fprintf (fid, "%0.3e", rmse);
  fdisp (fid, "<br>");
  fprintf (fid, "%0.3e", r2);
  fdisp (fid, "<br>");
  fprintf (fid, "%0.3e", maxerr);
  fdisp (fid, "<br>");
  fprintf (fid, "%0.3e", avgdiff);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("%s/%02d.png", dir, i);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
  
  fdisp (fid, "</tr>");
endfunction
