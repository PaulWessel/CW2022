%used in the shell script to find a weighted std for chain using data that is not smoothed
clear;
%import cross profiles from non-smoothed data
dat1 = importdata('chain_std/smooth_width.txt');
dat2 = importdata('chain_std/width.txt');
dat3 = importdata('final_smooth_weighted_line/weighted_line_filtered_resampled.txt'); 

%specify columns
zc = dat1(:,6); %smooth data
%zc = dat2(:,6); %non-smooth data
zc(isnan(zc))=0;

%linear weight function
zc_bar = mean(zc);%mean max height
w_mh = zc./zc_bar;%zc values less than mean max height given weight between 0 and 1 
w_mh(w_mh>=1) = 1;%final weights for the mean grid height boundaries, zc values > 1 are assigned 
%weight of 1 with values less than the mean zc remain between 0 and 1
w_max = 1 - w_mh;% weight for the max width, zero when zc > z_bar and
%between 0 to 1 when < zc_bar

% %cosine ramp function
% zc_bar = mean(zc);%mean max height
% w_mh = 0.5.*(1-cos((zc.*pi)./zc_bar));%function
% w_mh(zc./zc_bar>=1) = 1;
% w_max = 1 - w_mh;

% %shifted cosine ramp
% z_25 = quantile(zc_smooth,0.25);%min value
% z_75 = quantile(zc_smooth,0.75);%max value
% 
% w_mh = 0.5.*(1-cos(((zc-z_25)./z_75).*pi));%function
% w_shifted_smooth(zc./z_25<=1) = 0;
% w_shifted_smooth((zc-z_25)./z_75>=1) = 1;
% w_max = 1 - w_mh;

width = dat2(:,13);
dist = dat2(:,1);

one = ones(1,length(width))';
width_99 = importdata('1sigma/99_right.txt')*2.*one;%multiply by 2 to convert from sigma to width

width(isnan(width))=0;

weighted_width = w_mh.*width + w_max.*width_99;
% define columns for table
lon = dat3.data(:,1);
lat = dat3.data(:,2);
azim = dat3.data(:,4);

%export data
A = table(lon,lat,azim,dist,weighted_width);
writetable(A,'chain_std/weighted_width.txt','Delimiter','\t','WriteVariableNames',false);

B = table(dist,w_mh);
writetable(B,'chain_std/raw_weights.txt','Delimiter','\t','WriteVariableNames',false);
exit;