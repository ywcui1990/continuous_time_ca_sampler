function [M,fig] = plot_marginals(SAMPLES,T,truespikes,int_show)

if nargin < 4
    int_show = 1:T;
end
nT = length(int_show);

if nargin == 2
    truespikes = -0.5*ones(1,nT);
end

if length(truespikes) == T
    truespikes = truespikes(int_show);
end

Mat = samples_cell2mat(SAMPLES.ss,T);
Mat = Mat(:,int_show);
mS = min(max([Mat(:);truespikes(:)])+1,6)
M = zeros(mS,nT);
for i = 1:nT
    M(:,i) = hist(Mat(:,i),0:mS-1)/size(Mat,1);
end

cmap = bone(100);
cmap(2:26,:) = [];
fig = imagesc(M); axis xy; 
set(gca,'Ytick',[0.5:(mS-.5)],'Yticklabel',[-1:(mS-1)]); colormap(cmap); %hold all; plot(traceData.spikeFrames+1); set(gca,'YLim',[1,5])
set(gca,'YLim',[1.5,mS]);
hold all; scatter(1:nT,truespikes+1,[],'m');
set(gca,'YLim',[1.5,mS-1.5]);
pos = get(gca,'Position');
set(gca,'Ytick',[-0.5:mS-1.5],'Yticklabel',[-1+(0:mS)]);
ylabel('# of Spikes ','fontweight','bold','fontsize',16);
%xlabel('Timestep ','fontweight','bold','fontsize',16);
title('Spike Histogram (MCMC) ','fontweight','bold','fontsize',16);
cbar = colorbar('Location','East');
cpos = get(cbar,'Position');
set(cbar,'Position',[(pos(1)+1.05*pos(3)),cpos(2:4)]);
set(gca,'Xtick',[])