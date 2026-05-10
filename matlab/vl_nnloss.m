function Y = vl_nnloss(X,c,dzdy)

X = X + 1e-4 ;
sz = [size(X,1) size(X,2) size(X,3) size(X,4)] ;

% index from 0
c = c - 1 ;

if numel(c) == sz(4)
  % one label per image
  c = reshape(c, [1 1 1 sz(4)]) ;
  c = repmat(c, [sz(1) sz(2)]) ;
else
  % one label per spatial location
  sz_ = size(c) ;
  assert(isequal(sz_, [sz(1) sz(2) 1 sz(4)])) ;
end

% convert to indeces
c_ = 0:numel(c)-1 ;
c_ = 1 + ...
  mod(c_, sz(1)*sz(2)) + ...
  (sz(1)*sz(2)) * c(:)' + ...
  (sz(1)*sz(2)*sz(3)) * floor(c_/(sz(1)*sz(2))) ;

n = sz(1)*sz(2) ;
if nargin <= 2
  Y = - sum(log(X(c_))) / n ;
else
  Y_ = - (1./X) * (dzdy/n) ;
  Y = Y_*0 ;
  Y(c_) = Y_(c_) ;
end
