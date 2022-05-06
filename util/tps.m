function rbf = tps(r)
    rbf = zeros(size(r));
    nz = find(r~=0);
    rbf(nz) = r(nz) .^ 2 .* log(r(nz));
endfunction  