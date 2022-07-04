
% Script fro extracting Precipitaion data for British Columbia
% Data source : PCR Globwb from Inge
% Data storage location: C:\Users\chm594\Nextcloud\EF-GW, Global Project\Data-Inge\Data-Inge-19May2022\natural
% Data spec:
% All data comes from the model PCR-GLOBWB coupled to MODFLOW, as published in de Graaf et al 2019.
% -	Coupled groundwater-surface water- and water demand model
% -	Run at 5 arcminutes resolution globally (latlon, approx. 10x10km)
% - annual time step; 1960 - 2010
% -	Projection is in acrdegree (0.08333…) and WGS84.
% - unit m/y
% - data format netcdf
% - natural run

clc
close all
clear all

cd('C:\Users\chm594\Nextcloud\EF-GW, Global Project\Data-Inge\Data-Inge-19May2022\natural')
ncdisp('precip_annuaTot_output_1960to2010B.nc')
file='precip_annuaTot_output_1960to2010B.nc';
lon=ncread(file,'longitude');
lat=ncread(file,'latitude');
Pre=ncread(file,'precipitation');
time = ncread(file,'time');

% BC boundary shapefile
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\province')
Province = shaperead('PROVINCE.SHP','UseGeoCoords',true);
BC_pro=Province(12,:);

lat1=90.0:-0.0833:-90.0; lat1(1)=[];
lat1=lat1';
for i=1:51 % monthly iteration (1960-2010)
    
    
    cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script\maskregion.m');
    % %      masking data
    [data_cropped]=maskregion(lon,lat1,Pre(:,:,i),BC_pro);% masking all region except BC
    
    % % clipping data
    lat1=lat1;
    lon1=lon;
    latN=max(BC_pro.Lat,[],'omitnan')+2;
    latS=min(BC_pro.Lat,[],'omitnan')-2;
    lonE=max(BC_pro.Lon,[],'omitnan')+2;
    lonW=min(BC_pro.Lon,[],'omitnan')-2;
    
    [data_clipped,lon_clip,lat_clip]=Clip_code(data_cropped,lat1,lon1,latN,latS,lonW,lonE);
    
    Pre_myr_annual_BC(:,:,i)=data_clipped;
    clear data_cropped
    clear data_clipped
end

% % % plot
% % figure()
% %     pcolor(lon_clip,lat_clip,Pre_myr_annual_BC(:,:,1)') ;shading interp ;
% %     hold on
% %     plot(BC_pro.Lon,BC_pro.Lat,'r') % workied in plotting BC boundary
% %
cd ('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Precipitaion_Data_Inge');
save('Pre_myr_annual_BC.mat','Pre_myr_annual_BC');



