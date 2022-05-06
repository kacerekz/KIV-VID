#{

Function that writes html table row and fill it with given interpolationdata.

#}
function output_write_row_int(fid, fname, kname, alpha, cond, rmse, r2, maxerr, avgdiff, i)
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
  fdisp (fid, rmse);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, r2);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, maxerr);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, avgdiff);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("results/data/%02d.png", i);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("results/data/%02d_errsurf.png", i);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("results/data/%02d_err.png", i);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("results/data/%02d_histo.png", i);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
  
  fdisp (fid, "</tr>");
endfunction
