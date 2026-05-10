function [y,mask] = vl_nndropout(x,varargin)


opts.rate = 0.5 ;
opts.mask = [] ;

backMode = numel(varargin) > 0 && ~isstr(varargin{1}) ;
if backMode
  dzdy = varargin{1} ;
  opts = vl_argparse(opts, varargin(2:end)) ;
else
  opts = vl_argparse(opts, varargin) ;
end

% determine mask
mask = opts.mask ;
scale = single(1 / (1 - opts.rate)) ;
if backMode && isempty(mask)
  warning('vl_nndropout: when using in backward mode, the mask should be specified') ;
end
if isempty(mask)
  if isa(x,'gpuArray')
    mask = scale * single(gpuArray.rand(size(x)) >= opts.rate) ;
  else
    mask = scale * single(rand(size(x)) >= opts.rate) ;
  end
end

% do job
if ~backMode
  y = mask .* x ;
else
  y = mask .* dzdy ;
end
