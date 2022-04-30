#{

Function that writes html table row and fill it with given interpolationdata.

#}
function output_write_row_int(fid, i, typ, f, rbf, rbfFunction, cond, rozdil, maxError, RMSE, R2)
  fdisp (fid, "<tr style=text-align:center>");
  
  fdisp (fid, "<td>");
  fdisp (fid, ['Dataset',num2str(i),'.txt']);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, typ);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, ['F',num2str(f),'(x,y)']);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, rbfFunction);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, cond);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, rozdil);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, maxError);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, RMSE);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  fdisp (fid, R2);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("data%d/Interpolation_F%d(x,y)_rbf%d.jpg", i, f, rbf);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
  
  fdisp (fid, "<td>");
  name = sprintf("data%d/Interpolation_F%d(x,y)_rbf%d_contours.jpg", i, f, rbf);
  name2 = fprintf (fid, "<a href=\%s><img src=\"%s\" width=\"200\" height=\"150\" /></a>", name, name);
  fdisp (fid, "</td>");
    
    fdisp (fid, "</tr>");
endfunction
