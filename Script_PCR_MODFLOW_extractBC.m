% Script for extracting monthly PCR-ModFlow output for Only BC
% Variables:
% 1)  Flow from the aquifer to large rivers (Qriv )
% 2)  Flow from the aquifer to small rivers (Qdrn)
% 3) Monthly streamflow
%
% 1 and 2 are combined in:
% monthy_baseflow_1960to2010_human.nc: monthly groundwater discharge to the
%   stream (leaving the aquifer, positive value) or to the groundwater
%   (infiltrating from the stream to the groundwater, negative value) in
%   m/month. Both for larger and smaller streams.
% Discharge_monthAvg_1960to2010_human.nc: monthly river discharge in m3/s.
%   This is routed discharge and the sum of overland flow, sub-surface flow
%   and groundwater discharge/river infiltration.
% The resolution of these maps is 5-arcminutes (approximately 10x10km).

% <OPEN each section saperately for reading data. Run time is very high> %
clc
clear all
close all
tic
% BC boundary shapefile
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\province')% change the file path accordingly
Province = shaperead('PROVINCE.SHP','UseGeoCoords',true);
BC_pro=Province(12,:);

%% Baseflow data
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF');% change the file path accordingly
file = 'monthly_baseflow.nc' ;
time = ncread(file,'time');

ncdisp('monthly_baseflow.nc')
lon = ncread(file,'lon') ;
% %     lat = ncread(file,'lat') ;
% new lat in orger to make 90:-90 format
lat1=90.0:-0.0833:-90.0; lat1(1)=[];
lat1=lat1';
for i=1:612 % monthly iteration (1960-2010)
    cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF'); % Change to the folder where the data is
    monthly_baseflow1 = ncread(file,'monthly_baseflow',[1 1 i],[Inf Inf 1]); % [startrow startcol 3=3rd_layer], [Inf=all Inf 1=extraxt one layer from starting at 3]
    
    cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script\maskregion.m');
    % %      masking data
    [data_cropped]=maskregion(lon,lat1,monthly_baseflow1,BC_pro);% masking all region except BC
    
    % % clipping data
    lat1=lat1;
    lon1=lon;
    latN=max(BC_pro.Lat,[],'omitnan')+2;
    latS=min(BC_pro.Lat,[],'omitnan')-2;
    lonE=max(BC_pro.Lon,[],'omitnan')+2;
    lonW=min(BC_pro.Lon,[],'omitnan')-2;
    
    [data_clipped,lon_clip,lat_clip]=Clip_code(data_cropped,lat1,lon1,latN,latS,lonW,lonE);
    
    monthly_baseflow_BC(:,:,i)=data_clipped;
    clear monthly_baseflow1
    clear data_cropped
    clear data_clipped
end

% % % % plot
% % % figure()
% % %     pcolor(lon,lat1,data_cropped') ;shading interp ;
% % %     hold on
% % %     plot(BC_pro.Lon,BC_pro.Lat,'r') % workied in plotting BC boundary
% % %
% % %
toc
%% Streamflow Data

% % % % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF'); % Change to the folder where the data is
% % % % % file = 'discharge_monthAvg_1960to2010_human.nc' ;
% % % % % 
% % % % % % code for displaying teh netcdf information
% % % % % % % % ncdisp('discharge_monthAvg_1960to2010_human.nc' );
% % % % % % % %
% % % % % % % %     lon = ncread(file,'lon') ;
% % % % % % % % % %     lat = ncread(file,'lat') ;
% % % % % % % % % new lat
% % % % % % % % lat1=90.0:-0.0833:-90.0; lat1(1)=[];
% % % % % % % % lat1=lat1';
% % % % % for i=1:612 % monthly iteration (1960-2010)
% % % % %     cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF'); % change the file path accordingly
% % % % %     discharge1 = ncread(file,'discharge',[1 1 i],[Inf Inf 1]); % [startrow startcol 3=3rd_layer], [Inf=all Inf 1=extraxt one layer from starting at 3]
% % % % %     
% % % % %     cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script\maskregion.m');
% % % % %     % masking data
% % % % %     [data_cropped]=maskregion(lon,lat1,discharge1,BC_pro);% masking all region except BC
% % % % %     
% % % % %     % clipping data
% % % % %     lat1=lat1;
% % % % %     lon1=lon;
% % % % %     latN=max(BC_pro.Lat,[],'omitnan')+2;
% % % % %     latS=min(BC_pro.Lat,[],'omitnan')-2;
% % % % %     lonE=max(BC_pro.Lon,[],'omitnan')+2;
% % % % %     lonW=min(BC_pro.Lon,[],'omitnan')-2;
% % % % %     
% % % % %     [data_clipped,lon_clip,lat_clip]=Clip_code(data_cropped,lat1,lon1,latN,latS,lonW,lonE);
% % % % %     
% % % % %     monthly_discharge_BC(:,:,i)=data_clipped;
% % % % %     clear monthly_baseflow1
% % % % %     clear data_cropped
% % % % %     clear data_clipped
% % % % % end
% % % % % 
% % % % plot
% % % figure()
% % %     pcolor(lon_clip,lat_clip,data_clipped') ;shading interp ;
% % %     hold on
% % %     plot(BC_pro.Lon,BC_pro.Lat,'r') % workied in plotting BC boundary
% % %
% % % %
toc
