% code to calculate lon lat of weighted median line that will part of 
%shell script weighted_median_trail_line.sh
clear;
%Upload the data
center = importdata('chain_lines/center.txt');
start = importdata('chain_lines/start_line_resampled.txt');

lonc = center(:,2);%max z longitude
latc = center(:,3);%max z latitude
zc = center(:,6);%max z value

lons = start.data(:,1);%start line longitude
lats = start.data(:,2);%start line latitude
zs = start.data(:,5);%start line center value

zc_bar = mean(zc);%mean max height
wc = zc./zc_bar;%zc values less than mean height given weight between 0 and 1 
wc(wc>=1) = 1;%final weights for the new line, zc values > 1 are assigned 
%weight of 1 with values less than the mean zc remain between 0 and 1
ws = 1 - wc;% weight for the starting line, zero when zc > z_bar and
%between 0 to 1 when < zc_bar

lonw = wc.*lonc + ws.*lons; %weighted longitude
latw = wc.*latc + ws.*lats; %weighted latitude

%expoort as a text file
A = table(lonw,latw);
writetable(A,'chain_lines/weighted_line.txt','Delimiter','\t','WriteVariableNames',false);
exit;