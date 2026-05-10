
%
%    The filter size must be not larger than the padded image, i.e.
%
%      1 <= FH <= H + 2*(PADTOP+PADBOTTOM),
%      1 <= FW <= W + 2*(PADLEFT+PADRIGHT).
%
%    The output a is a SINGLE array of dimension YH x YW x K x N of
%    N images with K challens and size:
%
%      YH = floor((H + (PADTOP+PADBOTTOM) - FH)/STRIDEY) + 1,
%      YW = floor((W + (PADLEFT+PADRIGHT) - FW)/STRIDEX) + 1.
%
%    The derivative DZDY has the same dimension of the output Y,
%    the derivative DZDX has the same dimension as the input X, and
%    the derivative DZDF has the the same dimenson as F.
