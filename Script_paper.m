% Script for plotting the figures for paper

% inputs - E1_routed and E2_with not 12 multiplecation


clc
clear all
close all

% -- data obtained from Inge and extracted for BC --
% cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script')
% << Check Script_PCR_MODFLOW_extractBC for data extraction details>>

% -- Script for calculating E1 and E2
% cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')
% << check Script_E1_E2_calculation>>

% -- Routing of E1 ---
% the E1 was routed using ArcGIS and R studio
% check C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Routed_ARCGIS

% BC boundary
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\province')

% % mac
% cd('/Users/chinchumohan/OneDrive - University of Saskatchewan/GW_EF/province')


Province = shaperead('PROVINCE.SHP','UseGeoCoords',true);
BC_pro=Province(12,:);

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script') % lat and lot for data clipped for BC

% cd('/Users/chinchumohan/OneDrive - University of Saskatchewan/GW_EF/extraction script') % lat and lot for data clipped for BC

load lat_clip
load lon_clip

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
load BGC_Zones_resize % biogeoclimatic zones
% Reading BGCZ (or WHSE) ascii data - 
% Data source: https://www.for.gov.bc.ca/hre/becweb/resources/maps/GISdataDownload.html
% Download: https://catalogue.data.gov.bc.ca/dataset/bec-map
% Processed using ArcGIS
% for data pre processing see Script_Ecoregions.m
% BGCZ
    % 1	Coastal Mountain-heather Alpine	CM
    % 2	Interior Mountain-heather Alpine	IM
    % 3	Mountain Hemlock	MH
    % 4	Sub-Boreal Spruce	SBS
    % 5	Montane Spruce	MS
    % 6	Engelmann Spruce -- Subalpine Fir	ES
    % 7	Interior Douglas-fir	ID
    % 8	Coastal Western Hemlock	CWH
    % 9	Boreal Altai Fescue Alpine	BAFA
    % 10	Interior Cedar -- Hemlock	ICH
    % 11	Ponderosa Pine	PP
    % 12	Sub-Boreal Pine -- Spruce	SBP
    % 13	Bunchgrass	BG
    % 14	Spruce -- Willow -- Birch	SWB
    % 15	Boreal White and Black Spruce	BWBS
    % 16	Coastal Douglas-fir	CD

load Hydro_Zones_resize
% Reading hydrozones ascii data - 
% Data source: https://catalogue.data.gov.bc.ca/dataset/hydrology-hydrologic-zone-boundaries-of-british-columbia
% Download: https://catalogue.data.gov.bc.ca/dataset/hydrology-hydrologic-zone-boundaries-of-british-columbia
% Processed using ArcGIS
% for data pre processing see Script_Ecoregions.m

% Hydrozones
    % 1	Costal Mountains	
    % 2	georgia basin	
    % 3	North interior	
    % 4	North east plains	
    % 5	Haida Gwaii	
    % 6	South interior	
    % 7	South east mountains	
    % 8	Vancouver island	
 
 
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')

% % load E1_PCR_m3yr_recalc
% % E1_m3yr_rout=E1_m3yr;
% % load E1_PCR_m3yr
% % load E2_PCR_m3yr_no12


% alternative for plotting
% cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Data_Xander\MeanData')

% % E1_routed_myr_plot= imread('E1_myr_mean_routed1.tif', 'tif');
% % E2_myr_plot= imread('E2_myr_mean1.tif', 'tif');

% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Data_Xander')
% % % load E1_PCR_m3yr_routed
% % % E1_m3yr_rout=E1_routed_m3yr;
% % % load E2_PCR_m3yr

% revised E1 and E2 - Jun 1, 2022 Script_E1_E2_calculation
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')
load E1_E2_new


% mean value from ARCGIS

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper\data_ArcGIS');
% % % load E1_E2_mean_ArcGIS
% original tif file location
% cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Data_Xander\MeanData')

% % % load pre_mmyr % see C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Precipitation data\Script_extract.m
load discharge_mmyr


% see 'C:\Users\chm594\OneDrive - University of
% Saskatchewan\GW_EF\Analysis\Script_Analysis 

% Precip data from Inge - PCR_Globwb
cd ('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Precipitaion_Data_Inge');
load Pre_myr_annual_BC.mat

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
load Dominance_low
% Area categorised to Rain dominant and nuvial zones based on low flow months ;
% see Script_LowMonths for details
% 1-> snow dominant; 2-> rain dominant

% Eg routed BF from Inge 
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')
% % load BF_mm_mon_eg_BC.mat; %(average per year)
 load BF_rout_m_mon_BC % routed by Inge 
 % see C:\Users\chm594\OneDrive - University of
 % Saskatchewan\GW_EF\Analysis\BF_Routed_Inge_31May22\Script_BF_rout_Inge 
 % for more details on extraction
%% Data Preperation
cellArea=5478.563709423661*5478.563709423661; % 53.7 deg lat in m2

E1_myr_rout=E1_rout_myr;
E1_myr_rout_mean=(nanmean(E1_myr_rout,3));
 
E2_myr_mean=nanmean(E2_myr,3);
% 
% mean_discharge_myr=nanmean(discharge_mmyr,3).*0.01;

Pre_myr_mean_BC=nanmean(Pre_myr_annual_BC,3);

%% -------------------------------------NOT NEEDED BEGIN--------------------------
% % % % % % Pre
% % % % % A1=mean_pre_mmyr;
% % % % % A1(A1==A1(1,1))=NaN;
% % % % % A1(all(isnan(A1),2),:) = [];    % remove rows that are all nan
% % % % % A1(:, all(isnan(A1),1)) = []; % remove col that are all nan
% % % % % 
% % % % % Data_alter_90flip1 = flip(A1,2);
% % % % % Data_alter_90flip_re1 = resizem(Data_alter_90flip1,[297,140]);
% % % % % 
% % % % % Pre_mmyr_resize(1:347,1:189)=NaN;
% % % % % Pre_mmyr_resize(27:323,26:165)=Data_alter_90flip_re1;
% % % % % 
% % % % % % % Pre_myr_resize(1:347,1:189)=NaN;
% % % % % % % Pre_myr_resize(27:323,26:165)=Data_alter_90;
% % % % % % %  Pre_myr_resize1=Pre_myr_resize./365;
% % % % % 
% % % % % % E1_routed
% % % % % A=E1_myr_mean_routed1;
% % % % % 
% % % % % A(A==A(1,1))=NaN;
% % % % % A(all(isnan(A),2),:) = [];    % remove rows that are all nan
% % % % % A(:, all(isnan(A),1)) = []; % remove col that are all nan
% % % % % 
% % % % % Data_alter_90=rot90(A,1);
% % % % % Data_alter_90flip = flip(Data_alter_90,1);
% % % % % Data_alter_90flip_re = resizem(Data_alter_90flip,[297,140]);
% % % % % 
% % % % % E1_myr_routed_resize(1:347,1:189)=NaN;
% % % % % E1_myr_routed_resize(27:323,26:165)=Data_alter_90flip_re;
% % % % % 
% % % % % % for plotting only
% % % % % A=E1_routed_myr_plot;
% % % % % 
% % % % % A(A==A(1,1))=NaN;
% % % % % A(all(isnan(A),2),:) = [];    % remove rows that are all nan
% % % % % A(:, all(isnan(A),1)) = []; % remove col that are all nan
% % % % % 
% % % % % Data_alter_90=rot90(A,1);
% % % % % Data_alter_90flip = flip(Data_alter_90,1);
% % % % % Data_alter_90flip_re = resizem(Data_alter_90flip,[297,140]);
% % % % % 
% % % % % E1_myr_routed_plot_resize(1:347,1:189)=NaN;
% % % % % E1_myr_routed_plot_resize(27:323,26:165)=Data_alter_90flip_re;
% % % % % 
% % % % % 
% % % % % % E2
% % % % % A=E2_myr_mean1;
% % % % % A(A==A(1,1))=NaN;
% % % % % A(all(isnan(A),2),:) = [];    % remove rows that are all nan
% % % % % A(:, all(isnan(A),1)) = []; % remove col that are all nan
% % % % % 
% % % % % Data_alter_90=rot90(A,1);
% % % % % Data_alter_90flip = flip(Data_alter_90,1);
% % % % % Data_alter_90flip_re = resizem(Data_alter_90flip,[297,140]);
% % % % % 
% % % % % E2_myr_resize(1:347,1:189)=NaN;
% % % % % E2_myr_resize(27:323,26:165)=Data_alter_90flip_re;
% % % % % 
% % % % % % for plotting
% % % % % A=E2_myr_plot;
% % % % % A(A==A(1,1))=NaN;
% % % % % A(all(isnan(A),2),:) = [];    % remove rows that are all nan
% % % % % A(:, all(isnan(A),1)) = []; % remove col that are all nan
% % % % % 
% % % % % Data_alter_90=rot90(A,1);
% % % % % Data_alter_90flip = flip(Data_alter_90,1);
% % % % % Data_alter_90flip_re = resizem(Data_alter_90flip,[297,140]);
% % % % % 
% % % % % E2_myr_plot_resize(1:347,1:189)=NaN;
% % % % % E2_myr_plot_resize(27:323,26:165)=Data_alter_90flip_re;

%-------------------------------------NOT NEEDED END--------------------------

%% percentage of precipi
% % %  Pre_myr_resize=Pre_mmyr_resize.*0.001;
E1_perc_precip=((E1_myr_rout_mean)./Pre_myr_mean_BC)*100;
E1_perc_precip(E1_perc_precip>=120)=120;
E2_perc_precip=((E2_myr_mean)./Pre_myr_mean_BC)*100;
E2_perc_precip(E2_perc_precip>=120)=120;

discharge_myr_mean=nanmean((discharge_mmyr.*0.01),3);

% % discharge_myr_mean(discharge_myr_mean<=1e-3)=0;

dis_perc_precip=((discharge_myr_mean)./Pre_myr_mean_BC)*100;

% as percentage of discharge
E1_perc_disc=((E1_myr_rout_mean)./discharge_myr_mean)*100; %<wrong>
E1_perc_disc(E1_perc_disc>=100)=100;

E2_perc_disc=((E2_myr_mean)./discharge_myr_mean)*100;



%% pecentage plots
E1_perc_precip(isinf(E1_perc_precip))=NaN;
E2_perc_precip(isinf(E2_perc_precip))=NaN;
Pre_myr_mean_BC(isinf(Pre_myr_mean_BC))=NaN;

E1_perc_disc(isinf(E1_perc_disc))=NaN;
E2_perc_disc(isinf(E2_perc_disc))=NaN;

mean_perc(1,1)=nanmean(E1_perc_precip,'all');
mean_perc(2,1)=nanmean(E2_perc_precip,'all');
mean_perc(3,1)=nanmean(dis_perc_precip,'all');
mean_perc(4,1)=nanmean(Pre_myr_mean_BC,'all');

mean_disc(1,1)=nanmean(E1_perc_disc,'all');
mean_disc(2,1)=nanmean(E2_perc_disc,'all');
mean_disc(3,1)=nanmean(discharge_myr_mean,'all');

%-------------------------------------------------------------------------
% Pre percentage plots
figure()
    pcolor(lon_clip,lat_clip,E1_perc_precip') ;shading interp ;
    hold on
    plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
set(gca,'AmbientLightColor',[0 0 0],...
   'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
    'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
    [45 50 55 60 65],'YTickLabel',...
    {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
set(gca,'CLim',[0 120]);
colorbar(gca)
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
crameri -devon


colorbar(gca);
 box on
% Create title
title({'E_G_W as percentage of total precipitaion'});
xlabel('Longitude'); ylabel('Latitude');
 set(gca,'FontSize', 14, 'FontWeight','bold');      


figure()
    pcolor(lon_clip,lat_clip,E2_perc_precip') ;shading interp ;
    hold on
    plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
set(gca,'AmbientLightColor',[0 0 0],...
   'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
    'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
    [45 50 55 60 65],'YTickLabel',...
    {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
set(gca,'CLim',[0 150]);
colorbar(gca)
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
crameri -devon

colorbar(gca);
 box on
% Create title
title({'E_S_W as percentage of total precipitaion'});
xlabel('Longitude'); ylabel('Latitude');
 set(gca,'FontSize', 14, 'FontWeight','bold');   

figure()
    pcolor(lon_clip,lat_clip,Pre_myr_mean_BC') ;shading interp ;
    hold on
    plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
set(gca,'AmbientLightColor',[0 0 0],...
   'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','on','XTick',[-140 -130 -120 -110],...
    'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','on','YTick',...
    [45 50 55 60 65],'YTickLabel',...
    {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
set(gca,'CLim',[0 10]);
colorbar(gca)
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
crameri -imola

colorbar(gca);
 box on
% Create title
title({'Total precipitaion (m/yr)'});
xlabel('Longitude'); ylabel('Latitude');
 set(gca,'FontSize', 14, 'FontWeight','bold'); 

 %----------------------------------
 % Dis percentage plots

% % % % % % % figure()
% % % % % % %     pcolor(lon_clip,lat_clip,E1_perc_disc') ;shading interp ;
% % % % % % %     hold on
% % % % % % %     plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
% % % % % % % set(gca,'AmbientLightColor',[0 0 0],...
% % % % % % %    'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
% % % % % % %     'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
% % % % % % %     [45 50 55 60 65],'YTickLabel',...
% % % % % % %     {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
% % % % % % % set(gca,'CLim',[0 20]);
% % % % % % % colorbar(gca)
% % % % % % % cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
% % % % % % % crameri -devon
% % % % % % % 
% % % % % % % colorbar(gca);
% % % % % % %  box on
% % % % % % % % Create title
% % % % % % % title({'E_G_W as percentage of streamflow'});
% % % % % % % xlabel('Longitude'); ylabel('Latitude');
% % % % % % %  set(gca,'FontSize', 14, 'FontWeight','bold');      
% % % % % % % 
% % % % % % % 
% % % % % % % figure()
% % % % % % %     pcolor(lon_clip,lat_clip,E2_perc_disc') ;shading interp ;
% % % % % % %     hold on
% % % % % % %     plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
% % % % % % % set(gca,'AmbientLightColor',[0 0 0],...
% % % % % % %    'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
% % % % % % %     'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
% % % % % % %     [45 50 55 60 65],'YTickLabel',...
% % % % % % %     {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
% % % % % % % set(gca,'CLim',[0 20]);
% % % % % % % colorbar(gca)
% % % % % % % cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
% % % % % % % crameri -devon
% % % % % % % 
% % % % % % % colorbar(gca);
% % % % % % %  box on
% % % % % % % % Create title
% % % % % % % title({'E_S_W as percentage of streamflow'});
% % % % % % % xlabel('Longitude'); ylabel('Latitude');
% % % % % % %  set(gca,'FontSize', 14, 'FontWeight','bold'); 
% % % % % % %  
% % % % % % %  figure()
% % % % % % %     pcolor(lon_clip,lat_clip,discharge_myr_mean') ;shading interp ;
% % % % % % %     hold on
% % % % % % %     plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
% % % % % % % set(gca,'AmbientLightColor',[0 0 0],...
% % % % % % %    'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
% % % % % % %     'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
% % % % % % %     [45 50 55 60 65],'YTickLabel',...
% % % % % % %     {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
% % % % % % % % set(gca,'CLim',[0 20]);
% % % % % % % colorbar(gca)
% % % % % % % cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
% % % % % % % crameri -devon
% % % % % % % 
% % % % % % % colorbar(gca);
% % % % % % %  box on
% % % % % % % % Create title
% % % % % % % title({'E_S_W as percentage of streamflow'});
% % % % % % % xlabel('Longitude'); ylabel('Latitude');
% % % % % % %  set(gca,'FontSize', 14, 'FontWeight','bold'); 

%% 
% % % % % % % % yearly average
% % % % % % % 
% % % % % % % % test figure
% % % % % % % 
% % % % % % % E1_myr_rout=E1_m3yr_rout./cellArea;
% % % % % % % E2_myr=E2_m3yr./cellArea;
% % % % % % % 
% % % % % % % for uu=1:51
% % % % % % %     E1_mean(uu,1)=nanmean(nanmean(E1_myr_rout(:,:,uu)));
% % % % % % %     E2_mean(uu,1)=nanmean(nanmean(E2_myr(:,:,uu)));
% % % % % % %     discharge_mean(uu,1)=nanmean(nanmean(discharge_myr(:,:,uu)));
% % % % % % %     Pre_myr_mean(uu,1)=nanmean(nanmean(Pre_myr_annual_BC(:,:,uu)));
% % % % % % % end
% % % % % % % 
% % % % % % % percE1new=E1_mean./Pre_myr_mean*100;
% % % % % % % percE2new=E2_mean./Pre_myr_mean*100;
% % % % % % % 
% % % % % % % % % nanmean(percE2new)
% % % % % % % 
% % % % % % % figure()
% % % % % % % plot(E1_mean);
% % % % % % % hold on
% % % % % % % plot(E2_mean)
% % % % % % % hold on
% % % % % % % plot(Pre_myr_mean)
% % % % % % % % % % hold on
% % % % % % % % % % plot(discharge_mean)



% % % % % % % %%
% % % % % % % % as per of streamflow
% % % % % % % E1_perc_discharge=(E1_myr_routed_resize./mean_discharge_myr)*100;
% % % % % % % % as per of streamflow
% % % % % % % E2_perc_discharge=(E2_myr_resize./mean_discharge_myr)*100;
% % % % % % % 
% % % % % % % % meanvalue
% % % % % % % % removing inf
% % % % % % % E1_perc_precip(isinf(E1_perc_precip))=NaN;
% % % % % % % E2_perc_precip(isinf(E2_perc_precip))=NaN;
% % % % % % % % % E1_perc_discharge(isinf(E1_perc_discharge))=NaN;
% % % % % % % % % E2_perc_discharge(isinf(E2_perc_discharge))=NaN;
% % % % % % % 
% % % % % % % 
% % % % % % % mean_perc(1,1)=nanmean(E1_perc_precip,'all');
% % % % % % % mean_perc(2,1)=nanmean(E2_perc_precip,'all');
% % % % % % % mean_perc(3,1)=nanmean(E1_perc_discharge,'all');
% % % % % % % mean_perc(4,1)=nanmean(E2_perc_discharge,'all');
% % % % % % % 
% % % % % % % 
% % % % % % % 
% % % % % % % 
% % % % % % % % test figure
% % % % % % % 
% % % % % % % E1_myr_rout=E1_m3yr_rout./cellArea;
% % % % % % % E2_myr=E2_m3yr./cellArea;
% % % % % % % 
% % % % % % % for uu=1:51
% % % % % % %     E1_mean(uu,1)=nanmean(nanmean(E1_myr_rout(:,:,uu)));
% % % % % % %     E2_mean(uu,1)=nanmean(nanmean(E2_myr(:,:,uu)));
% % % % % % %     discharge_mean(uu,1)=nanmean(nanmean(discharge_myr(:,:,uu)));
% % % % % % %     pre_mmyr_mean(uu,1)=nanmean(nanmean(pre_mmyr(:,:,uu)));
% % % % % % % end
% % % % % % % pre_myr_mean=pre_mmyr_mean.*0.001;
% % % % % % % 
% % % % % % % figure()
% % % % % % % plot(E1_mean);
% % % % % % % hold on
% % % % % % % plot(E2_mean)
% % % % % % % hold on
% % % % % % % plot(pre_myr_mean)
% % % % % % % hold on
% % % % % % % plot(discharge_mean)


%% Figure 1 - Spatial map of mean groundwater contribution % use ARCMAP fig

E1_rou_myr_mean_all=nanmean(E1_myr_rout_mean,'all');
E2_myr_mean_all=nanmean(E2_myr_mean,'all');

E1_rou_myr_std=nanmean(std((E1_myr_rout_mean),'omitnan'));
E2_myr_std=nanmean(std(E2_myr_mean,'omitnan'));

% max - min
E1_rou_myr_max=(max(abs(E1_myr_rout_mean),[],'all','omitnan'));
E2_myr_max=(max(E2_myr_mean,[],'all','omitnan'));

    E1_rou_myr_min=(min(abs(E1_myr_rout_mean),[],'all','omitnan'));
    E2_myr_min=(min(E2_myr_mean,[],'all','omitnan'));

A=E1_myr_rout_mean;
figure()
pcolor(lon_clip,lat_clip,A') ;shading interp ;
    hold on
    plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
set(gca,'AmbientLightColor',[0 0 0],...
   'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
    'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
    [45 50 55 60 65],'YTickLabel',...
    {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
 set(gca,'CLim',[0 50]);
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
crameri lajolla

colorbar(gca);
 box on
% Create title
title({'E_G_W (m/yr)'});
xlabel('Longitude'); ylabel('Latitude');
 set(gca,'FontSize', 14, 'FontWeight','bold');      
 
 A=E2_myr_mean;
 figure()
    pcolor(lon_clip,lat_clip,A') ;shading interp ;
    hold on
plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
set(gca,'AmbientLightColor',[0 0 0],...
   'FontSize',14,'FontWeight','bold','GridLineStyle',':','XGrid','off','XTick',[-140 -130 -120 -110],...
    'XTickLabel',{'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
    [45 50 55 60 65],'YTickLabel',...
    {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});
 set(gca,'CLim',[0 50]);
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
crameri lajolla
% Create colorbar
colorbar(gca);
 box on
% Create title
title({'E_S_W (m/yr)'});
xlabel('Longitude'); ylabel('Latitude');
 set(gca,'FontSize', 14, 'FontWeight','bold');     

 
%% Area distribution within BC
% Total cells
E1_myr_routed_plot_resize=E1_myr_rout_mean;
E1_myr_routed_plot_resize(E1_myr_routed_plot_resize<0)=0;

E2_myr_plot_resize=E2_myr_mean;
E2_myr_plot_resize(E2_myr_plot_resize<0)=0;

Tot_area=nnz(~isnan(E2_myr_plot_resize));

[Count_E1,E1_val] = histcounts(E1_myr_routed_plot_resize);
Count_E1=Count_E1'; E1_val = E1_val';

Count_E1_new=Count_E1(2:end,:);
Count_E1_new=Count_E1(1:end,:);
E1_val_new=E1_val(3:end,:);
E1_val_new=E1_val(1:end-1,:);
Percent_count_E1=(Count_E1_new/Tot_area)*100;

yi = smooth(Percent_count_E1) ;
figure()
area(E1_val_new,yi,'FaceColor',[0.8 0.8 0.8],'LineWidth',1.5);
xlim([0 0.15])
% Create ylabel
ylabel('% area in BC','FontSize',18);
% Create xlabel
xlabel('E_G_W (m/yr)','FontSize',18);
box(gca,'on');
hold(gca,'off');
% Set the remaining axes properties
set(gca,'FontSize',18,'FontWeight','bold');
hold on    

% E2
[Count_E2,E2_val] = histcounts(E2_myr_plot_resize);
Count_E2=Count_E2'; E2_val = E2_val';

Count_E2_new=Count_E2(1:end,:);
E2_val_new=E2_val(1:end-1,:);
Percent_count_E2=(Count_E2_new/Tot_area)*100;

yi = smooth(Percent_count_E2) ;

area(E2_val_new,yi,'FaceColor',[0.8 0.8 0.8],'LineWidth',1.5);
xlim([0 0.1])
% Create ylabel
ylabel('% area in BC','FontSize',18);
% Create xlabel
xlabel('E_S_W (m/yr)','FontSize',18);
box(gca,'on');
hold(gca,'off');

% % % % Create multiple lines using matrix input to area
% % % area1 = area(X1,ymatrix1,'FaceAlpha',0.5,'LineWidth',1.5);
% % % set(area1(2),...
% % %     'FaceColor',[0.941176470588235 0.882352941176471 0.882352941176471],...
% % %     'EdgeColor',[0.458823529411765 0 0]);
% % % set(area1(1),...
% % %     'FaceColor',[0.709803921568627 0.717647058823529 0.92156862745098],...
% % %     'EdgeColor',[0.305882352941176 0.2 0.909803921568627]);

% Set the remaining axes properties
set(gca,'FontSize',18,'FontWeight','bold');
    
%% Fig 5
% Re organising BGCZ values to  represent drt to wet transsition

% negative value to prevent double counting
BGC_Zones_resize(BGC_Zones_resize==1 | BGC_Zones_resize==3)=-11;
BGC_Zones_resize(BGC_Zones_resize==2)=NaN;
BGC_Zones_resize(BGC_Zones_resize==4)=-5;
BGC_Zones_resize(BGC_Zones_resize==5)=-6;
BGC_Zones_resize(BGC_Zones_resize==6)=-10;
BGC_Zones_resize(BGC_Zones_resize==7)=-3;
BGC_Zones_resize(BGC_Zones_resize==8)=-12;
BGC_Zones_resize(BGC_Zones_resize==9)=NaN;
BGC_Zones_resize(BGC_Zones_resize==10)=-8;
BGC_Zones_resize(BGC_Zones_resize==11)=-2;
BGC_Zones_resize(BGC_Zones_resize==12)=-4;
BGC_Zones_resize(BGC_Zones_resize==13)=-1;
BGC_Zones_resize(BGC_Zones_resize==14)=NaN;
BGC_Zones_resize(BGC_Zones_resize==15)=-7;
BGC_Zones_resize(BGC_Zones_resize==16)=-9;

BGC_Zones_resize=abs(BGC_Zones_resize);

E1_myr_routed_plot_resize=E1_myr_rout_mean;
E2_myr_plot_resize=E2_myr_mean;

E1_myr_perc_precip=E1_perc_precip;
E2_myr_perc_precip=E2_perc_precip;

z=1;
E1_myr_routed_plot_resize(E1_myr_routed_plot_resize<=0)=NaN;
E2_myr_plot_resize(E2_myr_plot_resize<=0)=NaN;

E2_myr_plot_resize(E2_myr_plot_resize>20)=NaN;


for i=1:size(E2_myr_plot_resize,1)

    for j= 1:size(E2_myr_plot_resize,2)
    
        % BGCZ
        E_myr_bgcz(z,1)=(E1_myr_routed_plot_resize(i,j)); %E1
         E_myr_bgcz(z,2)=(E2_myr_plot_resize(i,j));% E2
         E_myr_bgcz(z,3)=E1_myr_perc_precip(i,j); % precip% E1
           E_myr_bgcz(z,4)=E2_myr_perc_precip(i,j); % precip% E2 
         
         E_myr_bgcz(z,5)=BGC_Zones_resize(i,j); % BGCZ
         


         % Hydrozones
          E_myr_hydro(z,1)=E1_myr_routed_plot_resize(i,j); %E1
         E_myr_hydro(z,2)=E2_myr_plot_resize(i,j);% E2\
          E_myr_hydro(z,3)=E1_myr_perc_precip(i,j); % precip% E1
           E_myr_hydro(z,4)=E2_myr_perc_precip(i,j); % precip% E2
         
          E_myr_hydro(z,5)=Hydro_Zones_resize(i,j); % Hydrozones
          
         z=z+1;
         
    end
end
     
% remove all row with nan values
E_myr_bgcz(any(isnan(E_myr_bgcz),2),:) = []; 
E_myr_hydro(any(isnan(E_myr_hydro),2),:) = []; 

% median in each group of BGCZ
for i=1:12
    
    filter_bgcz=E_myr_bgcz(:,5)==i;
    
    % E1
      % mean
       E_med_bgcz(i,1)=nanmean(E_myr_bgcz(filter_bgcz,1),'all');
      % median
    E_med_bgcz(i,2)=median(E_myr_bgcz(filter_bgcz,1),'all', 'omitnan');
   
    % max
    E_med_bgcz(i,3)=max(E_myr_bgcz(filter_bgcz,1),[],'all', 'omitnan');
    % min
    E_med_bgcz(i,4)=min(E_myr_bgcz(filter_bgcz,1),[],'all', 'omitnan');
      
    % E2
      % mean
       E_med_bgcz(i,5)=nanmean(E_myr_bgcz(filter_bgcz,2),'all');
      % median
    E_med_bgcz(i,6)=median(E_myr_bgcz(filter_bgcz,2),'all', 'omitnan');
   
    % max
    E_med_bgcz(i,7)=max(E_myr_bgcz(filter_bgcz,2),[],'all', 'omitnan');
    % min
    E_med_bgcz(i,8)=min(E_myr_bgcz(filter_bgcz,2),[],'all', 'omitnan');   
  
end


% hydro zones

% median in each group of hydrozones
for i=1:7
    
    filter_hydro=E_myr_hydro(:,5)==i;
    
    if nansum(filter_hydro)>=1
    
    % E1
      % mean
       E_med_hydro(i,1)=nanmean(E_myr_hydro(filter_hydro,1),'all');
      % median
    E_med_hydro(i,2)=median(E_myr_hydro(filter_hydro,1),'all', 'omitnan');
   
    % max
    E_med_hydro(i,3)=max(E_myr_hydro(filter_hydro,1),[],'all', 'omitnan');
    % min
    E_med_hydro(i,4)=min(E_myr_hydro(filter_hydro,1),[],'all', 'omitnan');
      
    % E2
      % mean
       E_med_hydro(i,5)=nanmean(E_myr_hydro(filter_hydro,2),'all');
      % median
    E_med_hydro(i,6)=median(E_myr_hydro(filter_hydro,2),'all', 'omitnan');
   
    % max
    E_med_hydro(i,7)=max(E_myr_hydro(filter_hydro,2),[],'all', 'omitnan');
    % min
    E_med_hydro(i,8)=min(E_myr_hydro(filter_hydro,2),[],'all', 'omitnan'); 
    
    else 
        
  E_med_hydro(i,1:8)=0;
    end
end

% E_med_bgcz_diff=log(E_med_bgcz(:,1))-log(E_med_bgcz(:,2));
xlab={'BG','PP','ID','SBP','SBS','MS','BWBS','ICH','CD','ES','CM','CWH'};% x label



% % E1 and E2 together
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\multiple_boxplot'
% % col=[102,255,255, 200;
% % 0, 0, 255, 200]; % box color
col=[0, 0, 255, 200;
52, 100, 10 200]; % box color
col=col/255;
Mlab={'E_G_W', 'E_S_W'}; % legend
xlab={'BG','PP','ID','SBP','SBS','MS','BWBS','ICH','CD','ES','CM','CWH'};% x label

% E1 and E2
% prepare data
data_bgcz=cell(2,size(xlab,2));

for ii=1:12
Ac{ii}=(E_myr_bgcz(E_myr_bgcz(:,5)==ii,1));
Bc{ii}=(E_myr_bgcz(E_myr_bgcz(:,5)==ii,2));
end
data_bgcz=(vertcat(Ac,Bc));

figure()
multiple_boxplot(data_bgcz',xlab,Mlab,col')
 set(findobj(gca,'type','line'),'linew',1.5)
set(gca,'GridLineStyle',':','XGrid','on','YGrid','on');
 ylabel('GW contribution to EF (m/yr)');
 title('BGCZ');
set(gca,'GridLineStyle',':','XGrid','on','YLim',[-0.01,6],...
    'YGrid','on');
 set(gca,'TickLabelInterpreter', 'tex');
 set(gca,'FontSize', 22, 'FontWeight','bold'); 
 % changing size of outliers
 h = findobj(gcf,'tag','Outliers');
set(h,'MarkerSize',1)
% changing color of median line
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');

%--------------------------------------------------------------------------
% E1 and E2 as percentange of precipitaion

% prepare data
data_bgcz=cell(2,size(xlab,2));


for ii=1:12
Ac{ii}=(E_myr_bgcz(E_myr_bgcz(:,5)==ii,3));
Bc{ii}=(E_myr_bgcz(E_myr_bgcz(:,5)==ii,4));
end


data_bgcz=(vertcat(Ac,Bc));
figure()
multiple_boxplot(data_bgcz',xlab,Mlab,col')
 set(findobj(gca,'type','line'),'linew',1.5)
set(gca,'GridLineStyle',':','XGrid','on','YGrid','on');
 ylabel('Percentage of precipitation');
 title('BGCZ');
set(gca,'GridLineStyle',':','XGrid','on','YLim',[-0.01,120],...
    'YGrid','on');
 set(gca,'TickLabelInterpreter', 'tex');
 set(gca,'FontSize', 22, 'FontWeight','bold'); 
 % changing size of outliers
 h = findobj(gcf,'tag','Outliers');
set(h,'MarkerSize',1)
% changing color of median line
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');

% -------------------------------------------------------------------------

% E1 and E2 together
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\multiple_boxplot'
% % col=[102,255,255, 200;
% % 0, 0, 255, 200]; % box color
col=[0, 0, 255, 200;
52, 100, 10 200]; % box color
col=col/255;
Mlab1={'E_G_W', 'E_S_W'}; % legend
xlab1={'Coastal Mountains','N.interior','N.E.plains','Haida Gwaii',...
    'S.interior','S.E. mountains','Vancouver island'};% x label

% prepare data
data_hydro=cell(2,size(xlab1,2));

for ii=1:8
Ac1{ii}=(E_myr_hydro(E_myr_hydro(:,5)==ii,1));
Bc1{ii}=(E_myr_hydro(E_myr_hydro(:,5)==ii,2));
end
data_hydro=vertcat(Ac1,Bc1);
data_hydro(:,2)=[]; % removing an empty col

figure()
multiple_boxplot(data_hydro',xlab1,Mlab1,col')
set(findobj(gca,'type','line'),'linew',1.5);
 ylabel('GW contribution to EF (m/yr)');
 title('Hydrozones');
 set(gca,'GridLineStyle',':','XGrid','on','YLim',[-0.001,1.5],...
    'YGrid','on');
 set(gca,'TickLabelInterpreter', 'tex');
 set(gca,'FontSize', 22, 'FontWeight','bold'); 
% changing size of outliers
 h = findobj(gcf,'tag','Outliers');
set(h,'MarkerSize',1)
% changing color of median line
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');

% ---------------------------------------------------------------------------
% prepare data
data_hydro=cell(2,size(xlab1,2));

for ii=1:8
Ac1{ii}=(E_myr_hydro(E_myr_hydro(:,5)==ii,3));
Bc1{ii}=(E_myr_hydro(E_myr_hydro(:,5)==ii,4));
end

data_hydro=vertcat(Ac1,Bc1);
data_hydro(:,2)=[]; % removing an empty col

figure()
multiple_boxplot(data_hydro',xlab1,Mlab1,col')
set(findobj(gca,'type','line'),'linew',1.5);
 ylabel('Percentage of precipitation');
 title('Hydrozones');
 set(gca,'GridLineStyle',':','XGrid','on','YLim',[-0.001,120],...
    'YGrid','on');
 set(gca,'TickLabelInterpreter', 'tex');
 set(gca,'FontSize', 22, 'FontWeight','bold'); 
% changing size of outliers
 h = findobj(gcf,'tag','Outliers');
set(h,'MarkerSize',1)
% changing color of median line
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');

%% Fig 6

% calculating Differance between E1 and E2
Diff_E1_E2_myr=(E1_myr_rout_mean)-(E2_myr_mean);
MeanDiff=nanmean(Diff_E1_E2_myr,'all');


z=1;
Diff_E1_E2_myr(isnan(Diff_E1_E2_myr))=0;

for i=1:size(Diff_E1_E2_myr,1)

    for j= 1:size(Diff_E1_E2_myr,2)
    
        % BGCZ
        Diff_myr_bgcz(z,1)=Diff_E1_E2_myr(i,j); %E1-E2
         Diff_myr_bgcz(z,2)=BGC_Zones_resize(i,j); % BGCZ
         
         % Hydrozones
        Diff_myr_hydro(z,1)=Diff_E1_E2_myr(i,j); %E1-E2
         Diff_myr_hydro(z,2)=Hydro_Zones_resize(i,j); % Hydrozone
         z=z+1;
         
    end
end

% remove all row with nan values
Diff_myr_bgcz(any(isnan(Diff_myr_bgcz),2),:) = []; 
Diff_myr_hydro(any(isnan(Diff_myr_hydro),2),:) = []; 

% % % removing all values >10e9
% % Diff_myr_bgcz(Diff_myr_bgcz(:,2) <= 10^-9, :) = [];
% % Diff_myr_hydro(Diff_myr_hydro(:,2) <= 10^-9, :) = [];

% ----------------------------------------------------------------------------
xlab={'BG','PP','ID','SBP','SBS','MS','BWBS','ICH','CD','ES','CM','CWH'};% x label

figure()
boxplot((Diff_myr_bgcz(:,1)),(Diff_myr_bgcz(:,2)))
set(findobj(gca,'type','line'),'linew',1.5)

 ylabel('E_G_W - E_S_W (m/yr)');
 set(gca,'GridLineStyle',':','XGrid','off','XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],...
    'XTickLabel',{'BG','PP','ID','SBP','SBS','MS','BWBS','ICH','CD','ES','CM','CWH'},...
    'YLim',[-0.1,3],'YGrid','off');
%<DELETE>
% %  set(gca,'GridLineStyle',':','XGrid','on','XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],...
% %     'XTickLabel',{'BG','PP','ID','SBP','SBS','MS','BWBS','ICH','CD','ES','CM','CWH'},...
% %     'YLim',[-2.5*10^8,2*10^8],'YGrid','on');

 set(gca,'TickLabelInterpreter', 'tex');
 set(gca,'FontSize', 14, 'FontWeight','bold'); 
% changing size of outliers
 h = findobj(gcf,'tag','Outliers');
set(h,'MarkerSize',1)

%--------------------------------------------------------------------------

figure()
boxplot((Diff_myr_hydro(:,1)),(Diff_myr_hydro(:,2)))
set(findobj(gca,'type','line'),'linew',1.5)

 ylabel('E_G_W - E_S_W (m/yr)');
 set(gca,'GridLineStyle',':','XGrid','off','XTick',[1 2 3 4 5 6 7],...
    'XTickLabel',{'Coastal Mountains','N.interior','N.E.plains','Haida Gwaii',...
    'S.interior','S.E. mountains','Vancouver island'},...
    'YLim',[-0.4,0.65],'YGrid','off');

%<DEL>
% %  set(gca,'GridLineStyle',':','XGrid','on','XTick',[1 2 3 4 5 6 7],...
% %     'XTickLabel',{'Costal Mountains','N.interior','N.E.plains','Queen Charlottes',...
% %     'S.interior','S.E. mountains','Vancouver island'},...
% %     'YLim',[-1*10^8,3*10^8],'YGrid','on');
 set(gca,'TickLabelInterpreter', 'tex');
 set(gca,'FontSize', 14, 'FontWeight','bold'); 
   % changing size of outliers
 h = findobj(gcf,'tag','Outliers');
set(h,'MarkerSize',1)

% -----------------------------------------------------------
% map
figure()
 imagesc(lon_clip,lat_clip,Diff_E1_E2_myr') ;%shading interp ;
      
    hold on
    plot(BC_pro.Lon,BC_pro.Lat,'k') % workied in plotting BC boundary
    view(gca,[-0 -90]);
    % formating
% Set the remaining axes properties
cd 'C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\crameri_v1.08\crameri'
crameri('bam','pivot',0) 

set(gca,'AmbientLightColor',[0 0 0],'BoxStyle','full','CLim',[-1 1],...
    'Color',[0 0 0],'Colormap',...
    [0.74454204511614 0.372533957269523 0.649050857292482;0.746522339340046 0.377398035120147 0.651771393282463;0.748502633563952 0.382262112970771 0.654491929272443;0.750482927787858 0.387126190821395 0.657212465262424;0.752463222011764 0.391990268672018 0.659933001252405;0.754443516235669 0.396854346522642 0.662653537242386;0.756423810459575 0.401718424373266 0.665374073232367;0.758404104683481 0.40658250222389 0.668094609222347;0.760384398907387 0.411446580074514 0.670815145212328;0.762364693131293 0.416310657925138 0.673535681202309;0.764344987355199 0.421174735775762 0.67625621719229;0.766325281579105 0.426038813626385 0.67897675318227;0.768305575803011 0.430902891477009 0.681697289172251;0.770285870026917 0.435766969327633 0.684417825162232;0.772266164250823 0.440631047178257 0.687138361152213;0.774246458474728 0.445495125028881 0.689858897142193;0.776226752698634 0.450359202879505 0.692579433132174;0.77820704692254 0.455223280730129 0.695299969122155;0.780187341146446 0.460087358580752 0.698020505112136;0.782167635370352 0.464951436431376 0.700741041102116;0.784147929594258 0.469815514282 0.703461577092097;0.786128223818164 0.474679592132624 0.706182113082078;0.78810851804207 0.479543669983248 0.708902649072059;0.790088812265975 0.484407747833872 0.711623185062039;0.792069106489881 0.489271825684495 0.71434372105202;0.794049400713787 0.494135903535119 0.717064257042001;0.796029694937693 0.498999981385743 0.719784793031982;0.798009989161599 0.503864059236367 0.722505329021963;0.799990283385505 0.508728137086991 0.725225865011943;0.801970577609411 0.513592214937615 0.727946401001924;0.803950871833317 0.518456292788239 0.730666936991905;0.805931166057223 0.523320370638862 0.733387472981886;0.807911460281128 0.528184448489486 0.736108008971866;0.809891754505034 0.53304852634011 0.738828544961847;0.81187204872894 0.537912604190734 0.741549080951828;0.813852342952846 0.542776682041358 0.744269616941809;0.815832637176752 0.547640759891982 0.746990152931789;0.817812931400658 0.552504837742606 0.74971068892177;0.819793225624564 0.557368915593229 0.752431224911751;0.82177351984847 0.562232993443853 0.755151760901732;0.823753814072376 0.567097071294477 0.757872296891712;0.825734108296282 0.571961149145101 0.760592832881693;0.827714402520187 0.576825226995725 0.763313368871674;0.829694696744093 0.581689304846349 0.766033904861655;0.831674990967999 0.586553382696973 0.768754440851635;0.833655285191905 0.591417460547596 0.771474976841616;0.835635579415811 0.59628153839822 0.774195512831597;0.837615873639717 0.601145616248844 0.776916048821578;0.839596167863623 0.606009694099468 0.779636584811559;0.841576462087529 0.610873771950092 0.782357120801539;0.843556756311435 0.615737849800716 0.78507765679152;0.84553705053534 0.620601927651339 0.787798192781501;0.847517344759246 0.625466005501963 0.790518728771482;0.849497638983152 0.630330083352587 0.793239264761462;0.851477933207058 0.635194161203211 0.795959800751443;0.853458227430964 0.640058239053835 0.798680336741424;0.85543852165487 0.644922316904459 0.801400872731405;0.857418815878776 0.649786394755083 0.804121408721385;0.859399110102682 0.654650472605707 0.806841944711366;0.861379404326588 0.65951455045633 0.809562480701347;0.863359698550493 0.664378628306954 0.812283016691328;0.865339992774399 0.669242706157578 0.815003552681308;0.867320286998305 0.674106784008202 0.817724088671289;0.869300581222211 0.678970861858826 0.82044462466127;0.871280875446117 0.68383493970945 0.823165160651251;0.873261169670023 0.688699017560073 0.825885696641231;0.875241463893929 0.693563095410697 0.828606232631212;0.877221758117835 0.698427173261321 0.831326768621193;0.879202052341741 0.703291251111945 0.834047304611174;0.881182346565647 0.708155328962569 0.836767840601154;0.883162640789552 0.713019406813193 0.839488376591135;0.885142935013458 0.717883484663816 0.842208912581116;0.887123229237364 0.72274756251444 0.844929448571097;0.88910352346127 0.727611640365064 0.847649984561077;0.891083817685176 0.732475718215688 0.850370520551058;0.893064111909082 0.737339796066312 0.853091056541039;0.895044406132988 0.742203873916936 0.85581159253102;0.897024700356894 0.74706795176756 0.858532128521;0.8990049945808 0.751932029618184 0.861252664510981;0.900985288804705 0.756796107468807 0.863973200500962;0.902965583028611 0.761660185319431 0.866693736490943;0.904945877252517 0.766524263170055 0.869414272480924;0.906926171476423 0.771388341020679 0.872134808470904;0.908906465700329 0.776252418871303 0.874855344460885;0.910886759924235 0.781116496721927 0.877575880450866;0.912867054148141 0.78598057457255 0.880296416440847;0.914847348372047 0.790844652423174 0.883016952430827;0.916827642595953 0.795708730273798 0.885737488420808;0.918807936819859 0.800572808124422 0.888458024410789;0.920788231043764 0.805436885975046 0.89117856040077;0.92276852526767 0.81030096382567 0.89389909639075;0.924748819491576 0.815165041676294 0.896619632380731;0.926729113715482 0.820029119526917 0.899340168370712;0.928709407939388 0.824893197377541 0.902060704360693;0.930689702163294 0.829757275228165 0.904781240350673;0.9326699963872 0.834621353078789 0.907501776340654;0.934650290611106 0.839485430929413 0.910222312330635;0.936630584835011 0.844349508780037 0.912942848320616;0.938610879058917 0.849213586630661 0.915663384310596;0.940591173282823 0.854077664481284 0.918383920300577;0.942571467506729 0.858941742331908 0.921104456290558;0.944551761730635 0.863805820182532 0.923824992280539;0.946532055954541 0.868669898033156 0.92654552827052;0.948512350178447 0.87353397588378 0.9292660642605;0.950492644402353 0.878398053734404 0.931986600250481;0.952472938626259 0.883262131585028 0.934707136240462;0.954453232850164 0.888126209435651 0.937427672230443;0.95643352707407 0.892990287286275 0.940148208220423;0.958413821297976 0.897854365136899 0.942868744210404;0.960394115521882 0.902718442987523 0.945589280200385;0.962374409745788 0.907582520838147 0.948309816190366;0.964354703969694 0.912446598688771 0.951030352180346;0.9663349981936 0.917310676539394 0.953750888170327;0.968315292417506 0.922174754390018 0.956471424160308;0.970295586641412 0.927038832240642 0.959191960150289;0.972275880865318 0.931902910091266 0.961912496140269;0.974256175089223 0.93676698794189 0.96463303213025;0.976236469313129 0.941631065792514 0.967353568120231;0.978216763537035 0.946495143643138 0.970074104110212;0.980197057760941 0.951359221493762 0.972794640100192;0.982177351984847 0.956223299344385 0.975515176090173;0.984157646208753 0.961087377195009 0.978235712080154;0.986137940432659 0.965951455045633 0.980956248070135;0.988118234656565 0.970815532896257 0.983676784060115;0.990098528880471 0.975679610746881 0.986397320050096;0.992078823104376 0.980543688597505 0.989117856040077;0.994059117328282 0.985407766448128 0.991838392030058;0.996039411552188 0.990271844298752 0.994558928020038;0.998019705776094 0.995135922149376 0.997279464010019;1 1 1;0.992453156284045 0.994417960179364 0.992063492063492;0.98490631256809 0.988835920358729 0.984126984126984;0.977359468852135 0.983253880538093 0.976190476190476;0.96981262513618 0.977671840717457 0.968253968253968;0.962265781420225 0.972089800896822 0.96031746031746;0.954718937704271 0.966507761076186 0.952380952380952;0.947172093988316 0.96092572125555 0.944444444444444;0.939625250272361 0.955343681434914 0.936507936507937;0.932078406556406 0.949761641614279 0.928571428571429;0.924531562840451 0.944179601793643 0.920634920634921;0.916984719124496 0.938597561973007 0.912698412698413;0.909437875408541 0.933015522152372 0.904761904761905;0.901891031692586 0.927433482331736 0.896825396825397;0.894344187976631 0.9218514425111 0.888888888888889;0.886797344260676 0.916269402690465 0.880952380952381;0.879250500544721 0.910687362869829 0.873015873015873;0.871703656828766 0.905105323049193 0.865079365079365;0.864156813112811 0.899523283228557 0.857142857142857;0.856609969396857 0.893941243407922 0.849206349206349;0.849063125680902 0.888359203587286 0.841269841269841;0.841516281964947 0.88277716376665 0.833333333333333;0.833969438248992 0.877195123946015 0.825396825396825;0.826422594533037 0.871613084125379 0.817460317460317;0.818875750817082 0.866031044304743 0.80952380952381;0.811328907101127 0.860449004484108 0.801587301587302;0.803782063385172 0.854866964663472 0.793650793650794;0.796235219669217 0.849284924842836 0.785714285714286;0.788688375953262 0.8437028850222 0.777777777777778;0.781141532237307 0.838120845201565 0.76984126984127;0.773594688521352 0.832538805380929 0.761904761904762;0.766047844805398 0.826956765560293 0.753968253968254;0.758501001089443 0.821374725739658 0.746031746031746;0.750954157373488 0.815792685919022 0.738095238095238;0.743407313657533 0.810210646098386 0.73015873015873;0.735860469941578 0.804628606277751 0.722222222222222;0.728313626225623 0.799046566457115 0.714285714285714;0.720766782509668 0.793464526636479 0.706349206349206;0.713219938793713 0.787882486815843 0.698412698412698;0.705673095077758 0.782300446995208 0.69047619047619;0.698126251361803 0.776718407174572 0.682539682539683;0.690579407645848 0.771136367353936 0.674603174603175;0.683032563929894 0.765554327533301 0.666666666666667;0.675485720213939 0.759972287712665 0.658730158730159;0.667938876497984 0.754390247892029 0.650793650793651;0.660392032782029 0.748808208071394 0.642857142857143;0.652845189066074 0.743226168250758 0.634920634920635;0.645298345350119 0.737644128430122 0.626984126984127;0.637751501634164 0.732062088609486 0.619047619047619;0.630204657918209 0.726480048788851 0.611111111111111;0.622657814202254 0.720898008968215 0.603174603174603;0.615110970486299 0.715315969147579 0.595238095238095;0.607564126770344 0.709733929326944 0.587301587301587;0.600017283054389 0.704151889506308 0.579365079365079;0.592470439338434 0.698569849685672 0.571428571428571;0.58492359562248 0.692987809865037 0.563492063492063;0.577376751906525 0.687405770044401 0.555555555555556;0.56982990819057 0.681823730223765 0.547619047619048;0.562283064474615 0.676241690403129 0.53968253968254;0.55473622075866 0.670659650582494 0.531746031746032;0.547189377042705 0.665077610761858 0.523809523809524;0.53964253332675 0.659495570941222 0.515873015873016;0.532095689610795 0.653913531120587 0.507936507936508;0.52454884589484 0.648331491299951 0.5;0.517002002178885 0.642749451479315 0.492063492063492;0.50945515846293 0.63716741165868 0.484126984126984;0.501908314746975 0.631585371838044 0.476190476190476;0.494361471031021 0.626003332017408 0.468253968253968;0.486814627315066 0.620421292196772 0.46031746031746;0.479267783599111 0.614839252376137 0.452380952380952;0.471720939883156 0.609257212555501 0.444444444444444;0.464174096167201 0.603675172734865 0.436507936507937;0.456627252451246 0.59809313291423 0.428571428571429;0.449080408735291 0.592511093093594 0.420634920634921;0.441533565019336 0.586929053272958 0.412698412698413;0.433986721303381 0.581347013452323 0.404761904761905;0.426439877587426 0.575764973631687 0.396825396825397;0.418893033871471 0.570182933811051 0.388888888888889;0.411346190155516 0.564600893990415 0.380952380952381;0.403799346439562 0.55901885416978 0.373015873015873;0.396252502723607 0.553436814349144 0.365079365079365;0.388705659007652 0.547854774528508 0.357142857142857;0.381158815291697 0.542272734707873 0.349206349206349;0.373611971575742 0.536690694887237 0.341269841269841;0.366065127859787 0.531108655066601 0.333333333333333;0.358518284143832 0.525526615245966 0.325396825396825;0.350971440427877 0.51994457542533 0.317460317460317;0.343424596711922 0.514362535604694 0.30952380952381;0.335877752995967 0.508780495784058 0.301587301587302;0.328330909280012 0.503198455963423 0.293650793650794;0.320784065564057 0.497616416142787 0.285714285714286;0.313237221848103 0.492034376322151 0.277777777777778;0.305690378132148 0.486452336501516 0.26984126984127;0.298143534416193 0.48087029668088 0.261904761904762;0.290596690700238 0.475288256860244 0.253968253968254;0.283049846984283 0.469706217039609 0.246031746031746;0.275503003268328 0.464124177218973 0.238095238095238;0.267956159552373 0.458542137398337 0.23015873015873;0.260409315836418 0.452960097577702 0.222222222222222;0.252862472120463 0.447378057757066 0.214285714285714;0.245315628404508 0.44179601793643 0.206349206349206;0.237768784688553 0.436213978115794 0.198412698412698;0.230221940972598 0.430631938295159 0.19047619047619;0.222675097256643 0.425049898474523 0.182539682539683;0.215128253540689 0.419467858653887 0.174603174603175;0.207581409824734 0.413885818833252 0.166666666666667;0.200034566108779 0.408303779012616 0.158730158730159;0.192487722392824 0.40272173919198 0.150793650793651;0.184940878676869 0.397139699371345 0.142857142857143;0.177394034960914 0.391557659550709 0.134920634920635;0.169847191244959 0.385975619730073 0.126984126984127;0.162300347529004 0.380393579909437 0.119047619047619;0.154753503813049 0.374811540088802 0.111111111111111;0.147206660097094 0.369229500268166 0.103174603174603;0.139659816381139 0.36364746044753 0.0952380952380952;0.132112972665185 0.358065420626895 0.0873015873015873;0.12456612894923 0.352483380806259 0.0793650793650794;0.117019285233275 0.346901340985623 0.0714285714285714;0.10947244151732 0.341319301164988 0.0634920634920635;0.101925597801365 0.335737261344352 0.0555555555555556;0.09437875408541 0.330155221523716 0.0476190476190477;0.0868319103694549 0.32457318170308 0.0396825396825397;0.0792850666535 0.318991141882445 0.0317460317460317;0.0717382229375452 0.313409102061809 0.0238095238095238;0.0641913792215902 0.307827062241173 0.0158730158730159;0.0566445355056353 0.302245022420538 0.00793650793650791;0.0490976917896804 0.296662982599902 0],...
    'FontSize',14,'FontWeight','bold','Layer','top','XTick',...
    [-140 -130 -120 -110],'XTickLabel',...
    {'140^0 W','130^0 W','120^0 W','110^0 W'},'YGrid','off','YTick',...
    [45 50 55 60 65],'YTickLabel',...
    {'45^0 N','50^0 N','55^0 N','60^0 N','65^0 N'});

box on
% Create title
% % % Create colorbar
colorbar(gca);

title({'Difference [E_G_W - E_S_W] (m/yr)'});
xlabel('Longitude'); ylabel('Latitude');
 set(gca,'FontSize', 14, 'FontWeight','bold');
 
%% Snow/rain dominance
% Fig 7 - plotting yearly values for rain dominant and snow domnant zomes saperately

% for snow fall dominant area
filter_snow=Dominance_low==1;
filter_rain=Dominance_low==2;


% annual mean
for i=1:51
    temp=E1_myr_rout(:,:,i);
E1_myr_BC_snow(i,1)=nanmean(nanmean(temp(filter_snow)));
E1_myr_BC_rain(i,1)=nanmean(nanmean(temp(filter_rain)));

    temp=E2_myr(:,:,i);
E2_myr_BC_snow(i,1)=nanmean(nanmean(temp(filter_snow)));
E2_myr_BC_rain(i,1)=nanmean(nanmean(temp(filter_rain)));

E1_myr_BC(i,1)=nanmean(nanmean(E1_myr_rout(:,:,i)));
E2_myr_BC(i,1)=nanmean(nanmean(E2_myr(:,:,i)));
end
cc=size(E1_myr_rout(:),1);
Diff(1:cc,1:3)=NaN;
% Difference Grouping

E1_myr_rout_mean11=nanmean(E1_myr_rout,3);
E2_myr_mean11=nanmean(E2_myr,3);

% % E1_myr_mean=E1_myr_routed_resize;
% % E2_myr_mean=E2_myr_routed_resize;

Diff_E1_E2_mean=E1_myr_rout_mean11-E2_myr_mean11;

% full BC
Differ(:,1)=E1_myr_rout_mean11(:)-E2_myr_mean11(:);
temp=E1_myr_rout_mean11(filter_snow)-E2_myr_mean11(filter_snow);
Differ(1:size(temp,1),2)=temp; % snow domi
temp=E1_myr_rout_mean11(filter_rain)-E2_myr_mean11(filter_rain);
Differ(1:size(temp,1),3)=temp; % rain domin

Differ(Differ==0)=NaN;

% difference between snow and rain areas

E1_snow_rain_mean=nanmean(E1_myr_BC_snow'/E1_myr_BC_rain');
E2_snow_rain_mean=nanmean(E2_myr_BC_snow'/E2_myr_BC_rain');

%_________________________________________________________________________
x=1960:2010;
figure()
plot(x',(E1_myr_BC_snow),'r')
hold on
plot(x',(E2_myr_BC_snow),'b')
set(findobj(gca,'type','line'),'linew',1.5)
 box on
% Create title
set(gca,'GridLineStyle',':','XGrid','off','YGrid','off','YLim',[0,4]);
xlabel('Year'); ylabel('GW contribution to EF (m/yr)');
% legend('E_G_W','E_S_W');
title('Snow dominant area')
 set(gca,'FontSize', 14, 'FontWeight','bold');  

 %figure()
plot(x',(E1_myr_BC_rain),'r--')
hold on
plot(x',(E2_myr_BC_rain),'b--')
set(findobj(gca,'type','line'),'linew',1.5)
 box on
% Create title
set(gca,'GridLineStyle',':','XGrid','off','YGrid','off','YLim',[0,4]);
xlabel('Year'); ylabel('GW contribution to EF (m/yr)');
legend('E_G_W-snow','E_S_W-snow','E_G_W-rain','E_S_W-rain');
title('Rain dominant area')
 set(gca,'FontSize', 14, 'FontWeight','bold');  

 %optional
 figure()

plot(x',(E1_myr_BC),'r:')
hold on
plot(x',(E2_myr_BC),'b:')
set(findobj(gca,'type','line'),'linew',1.5)
 box on
% Create title
set(gca,'GridLineStyle',':','XGrid','off','YGrid','off','YLim',[0,4]);
xlabel('Year'); ylabel('GW contribution to EF (m/yr)');
legend('E_G_W','E_S_W');
title('Full BC')
 set(gca,'FontSize', 14, 'FontWeight','bold');  

%% Saving Map data for ARCGIS <OPEN if NEEDED>

% % % Z=E1_myr_rout_mean'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\E1_rout_myr_mean.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % 
% % % %--------------------------------------------------------------------------
% % % Z=E2_myr_mean'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\E2_myr_mean.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % 
% % % % % %--------------------------------------------------------------------------
% % % Z=E1_perc_precip'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\E1_perc_precip_100.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % 
% % % % % %--------------------------------------------------------------------------
% % % % % 
% % % Z=E2_perc_precip'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\E2_perc_precip_100.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % % % 
% % % %--------------------------------------------------------------------------
% % % 
% % % Z=Diff_E1_E2_mean'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\Diff_E1_E2_mean.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % 
% % % %--------------------------------------------------------------------------
% % % Z=BGC_Zones_resize'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\BGCZ.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % 
% % % %--------------------------------------------------------------------------
% % % Z=Hydro_Zones_resize'; %data in lat (rows) and lon (col)
% % % lat=lat_clip';
% % % lon=lon_clip;
% % % % <change file name before saving a new variable>
% % % fileName='C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps\Hydro_Zones_resize.tif';
% % % 
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')
% % % arcgridwrite(fileName,lon,lat,Z);
% % % 
% % % %--------------------------------------------------------------------------
% % % cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\ArcGIS\Paper Maps')
