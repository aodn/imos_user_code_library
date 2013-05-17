srs_URL = 'http://thredds.aodn.org.au/thredds/dodsC/IMOS/eMII/demos/SRS/SRS-SST/L3C-01day/L3C_GHRSST-SSTskin-AVHRR19_D-1d_night/2013/20130401152000-ABOM-L3C_GHRSST-SSTskin-AVHRR19_D-1d_night-v02.0-fv01.0.nc.gz' ;
srsL3C_DATA = ncParse(srs_URL) ;
 
step = 10; % we take one point out of 'step'. Only to make it faster to plot on Matlab
% squeeze the data to get rid of the time dimension in the variable shape 
sst = squeeze(srsL3C_DATA.variables.sea_surface_temperature.data(1,1:step:end,1:step:end));
lat = squeeze(srsL3C_DATA.dimensions.lat.data(1:step:end));
% modify the longitude values which across the 180th meridian 
lon = squeeze(srsL3C_DATA.dimensions.lon.data(1:step:end));
if sum(lon<0) > 0
    lon(lon<0) =  lon(lon<0)+360;
end
 
[lon_mesh,lat_mesh] = meshgrid(lon,lat);% we create a matrix of similar size to be used afterwards with pcolor
 
figure1 = figure;
set(figure1, 'Position',  [1 500 900 500 ], 'Color',[1 1 1]);
 
surface(double(lon_mesh) , double(lat_mesh) , double(sst))
shading flat 
caxis([min(min(sst)) max(max(sst))])
cmap = colorbar;
set(get(cmap,'ylabel'),'string',[srsL3C_DATA.variables.sea_surface_temperature.long_name ' in ' srsL3C_DATA.variables.sea_surface_temperature.units ],'Fontsize',10) 
title({srsL3C_DATA.metadata.title ,...
    srsL3C_DATA.metadata.start_time })
xlabel(strrep(([srsL3C_DATA.dimensions.lon.long_name ' in ' srsL3C_DATA.dimensions.lon.units]),'_',' '))
ylabel(strrep(([srsL3C_DATA.dimensions.lat.long_name ' in ' srsL3C_DATA.dimensions.lat.units]),'_',' '))
