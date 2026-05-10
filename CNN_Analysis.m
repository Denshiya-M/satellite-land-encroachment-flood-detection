function Z = imabsdiff(varargin)
 

narginchk(2,2);

X = varargin{1};
Y = varargin{2};
validateattributes(X, {'numeric','logical'}, {'real'}, mfilename, 'X', 1);
validateattributes(Y, {'numeric','logical'}, {'real'}, mfilename, 'Y', 2);

checkForSameSizeAndClass(X, Y, mfilename);

if isempty(X)
    if islogical(X)
        Z = false(size(X));
    else
        Z = zeros(size(X), class(X));
    end
else
    Z = images.internal.builtins.imabsdiff(X,Y, iptgetpref('UseIPPL'));
end


