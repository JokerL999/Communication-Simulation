% ÑİÊ¾¾í»ıÂë±àÂëºÍÒëÂë
% clc

k=1;

g=[1 1 1;
   1 0 1];

msg=[1 0 0 1 1 1 0 0 1 1 0 0 0 0 1 1]

rx_sig=ConvolutionEncoder(g,k,msg);
decoder_output=ConvolutionDecoder(g,k,rx_sig)


