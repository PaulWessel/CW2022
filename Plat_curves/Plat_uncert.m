clear;

dat = importdata('P_lat/pole_to_HS_uncert.txt');

lmax1 = dat(:,4);
lmin1 = dat(:,5);

lmax2 = dat(:,12);
lmin2 = dat(:,13);


pole_azi1 = dat(:,3);
GS_azi1 = dat(:,6);
HS_azi2 = dat(:,9);
GS_azi2 = dat(:,10);

theta1 = pole_azi1 - GS_azi1;
theta2 = HS_azi2 - GS_azi2;

sig_km = sqrt((lmin1^2)*(sind(theta1)^2) + (lmax1^2)*(cosd(theta1)^2) + ...
    (lmin2^2)*(sind(theta2)^2) + (lmax2^2)*(cosd(theta2)^2));

sigd = sig_km/(2*pi*6371.008771/360)