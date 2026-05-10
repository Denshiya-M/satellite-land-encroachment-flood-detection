function Y = vl_nnsoftmax(X,dzdY)


E = exp(bsxfun(@minus, X, max(X,[],3))) ;
L = sum(E,3) ;
Y = bsxfun(@rdivide, E, L) ;

if nargin <= 1, return ; end

% backward
Y = Y .* bsxfun(@minus, dzdY, sum(dzdY .* Y, 3)) ;
