function vl_testsim(a,b,tau)
% VL_TESSIM  Test near-equality of arrays
%   VL_TEST(A,B,TAU) succeds if A and B have the same dimensions
%   and if their L^infinity difference is smaller than TAU.


a = gather(a) ;
b = gather(b) ;
assert(isequal(size(a),size(b))) ;
if isempty(a), return ; end
delta = a - b ;
%max(abs(a(:)-b(:)))
if nargin < 3 || isempty(tau)
  maxv = max([max(a(:)), max(b(:))]) ;
  minv = min([min(a(:)), min(b(:))]) ;
  tau = 1e-2 * (maxv - minv) + 1e-4 * max(maxv, -minv) ;
end
assert(all(abs(a(:)-b(:)) < tau)) ;
