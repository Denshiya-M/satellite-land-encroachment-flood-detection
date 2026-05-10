function y = vl_nnnoffset(x, param, dzdy)


L = sum(x.^2,3) ;
L = max(L, single(1e-8)) ;
param = single(param) ;

if nargin <= 2
  y = bsxfun(@minus, x, param(1)*L.^param(2)) ;
else
  y = dzdy - bsxfun(@times, (2*param(1)*param(2))* x, sum(dzdy,3) .* (L.^(param(2)-1))) ;
end