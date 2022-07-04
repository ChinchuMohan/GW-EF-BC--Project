% Script for extracting monthly PCR-ModFlow output for Only British
% Columbia
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


% Data source : PCR Globwb from Inge
% Data storage location: C:\Users\chm594\Nextcloud\EF-GW, Global Project\Data-Inge\Data-Inge-31May2022\bf_accu
% Data spec:
% All data comes from the model PCR-GLOBWB coupled to MODFLOW, as published in de Graaf et al 2019.
% -	Coupled groundwater-surface water- and water demand model
% -	Run at 5 arcminutes resolution globally (latlon, approx. 10x10km)
% - annual time step; 1960 - 2010
% -	Projection is in acrdegree (0.08333…) and WGS84.
% - unit baseflow - m/month (averaged per year); discharge - m3/s (monthly)
% - data format .map
% - human run

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

cd('C:\Users\chm594\Nextcloud\EF-GW, Global Project\Data-Inge\Data-Inge-19May2022')
%  ncdisp('baseflowYeartotal_19602010.nc')
 file='baseflowYeartotal_19602010.nc';
 lon=ncread(file,'lon');
  lat=ncread(file,'lat');
%   BF=ncread(file,'baseflow_1960-01-31.map');
  time = ncread(file,'time');
  
% new lat in orger to make 90:-90 format
lat1=90.0:-0.0833:-90.0; lat1(1)=[];
lat1=lat1';

j=1;
for i=1960:2010
 cd('C:\Users\chm594\Nextcloud\EF-GW, Global Project\Data-Inge\Data-Inge-31May2022\bf_acc_ascii')
   
file=sprintf('bf_accu_yeartotal_%d.txt',i); % example BF routed data from Inge. Obtained from ARCGIS
% Original data was in .map format; it was conversted to ascii in ArcMap
% and then used here <THIS needs to be replaced with new data>

Data=importdata(file,delimiterIn,headerlinesIn);
BF=Data.data';

% extracting
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script\maskregion.m');
% %      masking data
[data_cropped]=maskregion(lon,lat1,BF,BC_pro);% masking all region except BC

% % clipping data
lat1=lat1;
lon1=lon;
latN=max(BC_pro.Lat,[],'omitnan')+2;
latS=min(BC_pro.Lat,[],'omitnan')-2;
lonE=max(BC_pro.Lon,[],'omitnan')+2;
lonW=min(BC_pro.Lon,[],'omitnan')-2;

[data_clipped,lon_clip,lat_clip]=Clip_code(data_cropped,lat1,lon1,latN,latS,lonW,lonE);
   
% changing -9999 values to NaN
 data_clipped(data_clipped==-9999)=NaN;
 
BF_rout_m_mon_BC(:,:,j)=data_clipped;
j=j+1;
clear data_cropped
clear data_clipped
end
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')
save('BF_rout_m_mon_BC.mat','BF_rout_m_mon_BC');

toc
%% Streamflow Data

% % % % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF'); % change the file path accordingly
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

toc
