function [conf, args] = vl_argparse(conf, args)


if ~isstruct(conf), error('CONF must be a structure') ; end

remainingArgs = {} ;
names = fieldnames(conf) ;

ai = 1 ;
while ai <= length(args)
  paramName = args{ai} ;
  if isstruct(paramName)
    moreArgs = cat(2, fieldnames(args{ai}), struct2cell(args{ai}))' ;
    [conf,r] = vl_argparse(conf, moreArgs(:)) ;
    remainingArgs = cat(2, remainingArgs, r) ;
    ai = ai +1 ;
    continue ;
  end
  if ~ischar(paramName)
    error('The name of the parameter number %d is not a string nor a structure', (ai-1)/2+1) ;
  end
  if ai + 1 > length(args)
    error('Parameter-value pair expected (missing value?).') ;
  end
  value = args{ai+1} ;
  i = find(strcmpi(paramName, names)) ;
  if isempty(i)
    if nargout < 2
      error('Unknown parameter ''%s''.', paramName) ;
    else
      remainingArgs(end+1:end+2) = args(ai:ai+1) ;
    end
  else
    paramName = names{i} ;
    if isstruct(conf.(paramName))
      [conf.(paramName),r] = vl_argparse(conf.(paramName), {value}) ;
    else
      conf.(paramName) = value ;
    end
  end
  ai = ai + 2 ;
end

args = remainingArgs ;
