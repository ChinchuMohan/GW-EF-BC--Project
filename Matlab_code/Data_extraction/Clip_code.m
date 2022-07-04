function [data_clipped,lon_clip,lat_clip]=Clip_code(data,lat1,lon1,latN,latS,lonW,lonE)

% Funtion written by Chinchu Mohan (21/09/2018)
% for extrating values with in lat-lot bounds
% latitude --> grace.lain decimal degree


[lat,lon] = meshgrid(lat1,lon1);% longitude and latitude matrix 
ri = find(abs(diff(lon(1,:)))==max(abs(diff(lon(1,:)))));
% % lon = horzcat(lon(:,ri+1:end),lon(:,1:ri));   % Connect matrices to remove discontinuity
% % lat = horzcat(lat(:,ri+1:end),lat(:,1:ri));
n=size(data,3);
% % % for i=1:n
% % %     x=data(:,:,i);
% % %     d_resize(:,:,i)=resizem(x,[360 180]);
% % % end
d_resize=data;

% extracting  bounds
% % rid= (lat<=lonE&lon>=lonW&lon<=latN&lat>=latS); % use only data specified by user
rid= (lon<=lonE&lon>=lonW&lat<=latN&lat>=latS); % use only data specified by user

   
    x=data;
    x(~rid)=-999;
    Z=x;
    lon_mask=lon;
    lat_mask=lat;
    lon_mask(~rid)=NaN;
    lat_mask(~rid)=NaN;
    
      Z( all( ( Z==-999 ), 2 ), : ) = []; % removes all rows with all nans
 Z( :, all( ( Z==-999 ), 1 ) ) = []; % and columns
% %   Z( all( isnan( Z ), 2 ), : ) = []; % removes all rows with all nans
% %  Z( :, all( isnan( Z ), 1 ) ) = []; % and columns
 
   lon_mask( all( isnan( lon_mask ), 2 ), : ) = []; % removes all rows with all nans
 lon_mask( :, all( isnan( lon_mask ), 1 ) ) = []; % and columns
 
   lat_mask( all( isnan( lat_mask ), 2 ), : ) = []; % removes all rows with all nans
 lat_mask( :, all( isnan( lat_mask ), 1 ) ) = []; % and columns
 
 data_clipped=Z;
lon_clip= lon_mask(:,1)';
lat_clip=lat_mask(1,:);
 
% %     % resizing
% %     lonNew=lonW:0.0833:lonE;
% %     latNew=latN:-0.0833:latS;
% %     
% %     figure()
% %     pcolor(lon_mask(:,1)',lat_mask(1,:),Z'); shading interp ;
% %     hold on
% %     plot(BC_pro.Lon,BC_pro.Lat,'r') % workied in plotting BC boundary
    
    
    
end
