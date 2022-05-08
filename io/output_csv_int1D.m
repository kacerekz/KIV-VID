function output_csv_int1D(fid, index, COND, RMSE, R2, MAX_ERR, AVG_DIFF)
  
  s = sprintf("%d,%f,%f,%f,%f,%f", index, COND, RMSE, R2, MAX_ERR, AVG_DIFF);
  fdisp (fid, s);
  
endfunction