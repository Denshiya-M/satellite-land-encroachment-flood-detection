function y = vl_nnrelu(x,dzdy)


if nargin <= 1 || isempty(dzdy)
  y = max(x, single(0)) ;
else
  y = dzdy .* (x > single(0)) ;
end
