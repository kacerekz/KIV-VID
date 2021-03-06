#
# Function that begins the html document
#
function output_write_html_begin(fid)
  fdisp (fid, "<!DOCTYPE html>");
  fdisp (fid, "<html lang=\"en\">");
  fdisp (fid, "<head>");
  fdisp (fid, "<meta charset=\"UTF-8\">");
  fdisp (fid, "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css\" integrity=\"sha384-zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq\" crossorigin=\"anonymous\">");
  fdisp (fid, "<script defer src=\"https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.js\" integrity=\"sha384-y23I5Q6l+B6vatafAwxRu/0oK/79VlbSz7Q9aiSZUvyWYIYsd+qj+o24G5ZU2zJz\" crossorigin=\"anonymous\"></script>");
  fdisp (fid, "<script defer src=\"https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/contrib/auto-render.min.js\" integrity=\"sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI\" crossorigin=\"anonymous\" onload=\"renderMathInElement(document.body);\"></script>");
  fdisp (fid, "<style>");
  fdisp (fid, "th, td { padding: 15px;}");
  fdisp (fid, "</style>");
  fdisp (fid, "</head>");
  fdisp (fid, "<body>");
endfunction
