
% Script for extracting monthly upstream contribution data for British Columbia
% Global upstream data obtained from Tara's analysis

clc
clear all
close all
tic

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\province')
Province = shaperead('PROVINCE.SHP','UseGeoCoords',true);
BC_pro=Province(12,:);

% for lat and lon
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF'); % Change to the folder where the data is
file = 'monthly_baseflow.nc' ;
lon = ncread(file,'lon') ;
% new lat
lat1=90.0:-0.0833:-90.0; lat1(1)=[];
lat1=lat1';

% clip lat lot extend
lon1=lon;
latN=max(BC_pro.Lat,[],'omitnan')+2;
latS=min(BC_pro.Lat,[],'omitnan')-2;
lonE=max(BC_pro.Lon,[],'omitnan')+2;
lonW=min(BC_pro.Lon,[],'omitnan')-2;
% loading upstream monthly raster

for i=1:12
    month=string({'jan' 'feb' 'mar', 'aprl', 'may', 'jun', 'jly' ,'aug', 'sep', 'oct', 'nov', 'dec'});
    cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\QGIS\Upstream_clip')
    file=sprintf('upstream_clip_%s.tif',month(i));
    [A,R] = readgeoraster(file); % global data
    A(A==A(1,1))=NaN;
    AA=A';
    cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script\maskregion.m');
    % clipping data
    [data_clipped,lon_clip,lat_clip]=Clip_code(AA,lat1,lon1,latN,latS,lonW,lonE);
    
    Upstream_BC(:,:,i)=data_clipped;
    
    
end
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script')
save('Upstream_BC,mat','Upstream_BC');
%..........................................................................
toc
