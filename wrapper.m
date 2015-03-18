clear;
load traceData.mat;
addpath utilities
% Y = squeeze(traceData.traces(129,7,:));   % pick a particular trace (low SNR)
Y = mean(squeeze(traceData.traces(:,7,:))); % average over ROI (high SNR)
Yr = (Y(:) - min(Y(:)))/(max(Y(:)) - min(Y(:)));   % normalize data
T = length(Yr);
P.g = 0.9375;                                   % time constant (known)
P.f = 1;       % currently P.f has to be set to 1
%%
params.marg = 0;
tic; SAMP = cont_ca_sampler(Yr,P,600,100,params); toc
plot_continuous_samples(SAMP,P,Yr);