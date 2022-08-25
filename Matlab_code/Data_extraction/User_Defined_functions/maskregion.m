function varout=maskregion(filelon,filelat,filevar,W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%maskregion is a part of Atmospheric Science ToolBox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Created by Ankur Kumar                        Wednesday; June 09, 2019
%                                              Version: 1.0
%
% PURDUE UNIVERISTY
% West Lafayette, IN 47907
% Department of Earth, Atmospheric, and Planetary Sciences
% Email: ankurk017@gmail.com
%        kumar409@purdue.edu
%
%
% Function:
%           maskregion mask out the data in the nc file as per the shape
%           file provided as the fourth argument
% Syntax:
%           [data_masked]=maskregion(lon,lat,data,shapefile_var);
% 
% Inputs:
%           It takes first three arguments as the latitude, longitude and
%           data respectively. shapefile argument should be the shapefile,
%           which contains X and Y coordinates of the region(s) you wish
%           to crop.
% 
% 
% Example:
% 
%            W=shaperead('us_states.shp');
%           [data_masked]=maskregion(lon,lat,data,shapefile_var);
% 
% 
% Please send your suggestions to the email id: ankurk017@gmail.com or
%                                               416AS2025@nitrkl.ac.in
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ncdispread is a part of Atmospheric Science ToolBox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xx,yy]=meshgrid(filelon,filelat);
index=zeros(size(filevar,2),size(filevar,1));
for kk=1:length(W)

     out=[W(kk).Lon ;W(kk).Lat]';
    aa=inpolygon(xx,yy,out(:,1),out(:,2)) +0;
    try
        index=index+aa;
    catch
        index=index+aa';
    end
end
index(index==0)=nan;
for kk=1:size(filevar,3)
    varout(:,:,kk)=filevar(:,:,kk).*index';
end
end
