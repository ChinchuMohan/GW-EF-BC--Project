% Script for calculating groundwater contribution to environmental flow
% using groundwater centric and surface water centric method 
% Last modifed: June 1, 2022
% Written by Chinchu Mohan, USASK

% Methods used:
%   1) groundwater presumptive standard E1(E_ps),
%       E1 = 0.9 * Qbf ; Qbf = Qdrn + Qriv ; Qdrn and Qriv is obtained from
%       PCR-GLOBWB-MODFLOW (Inge)
%       Flow from the aquifer to large rivers (Qriv)
%       Flow from the aquifer to small rivers (Qdrn)

%    2) streamflow centric method E2 (E_ls)
%       E2 = k_efn * Qgw * f_local ; Qgw = 12*Qlf (where Qlf is the highest
%       flow in low flow month)
%       k_efn: Low flow -> <10% MAD -> k_efn= 95%;
%              Intermediate flow -> 10 - 20% MAD -> k_efn = 90%
%              High flow -> >20% MAD -> k_efn = 85%
%       f_local = (1-(Q_lf_upstream/Q_lf))

% Data details:
%   baseflow_routed: monthly groundwater discharge to the stream (leaving the
%             aquifer, positive value) or to the groundwater (infiltrating
%             from the stream to the groundwater, negative value)
%             Unit: m/month
%   streamflow/discharge: routed discharge and the sum of overland flow,
%                         sub-surface flow and groundwater discharge/river
%                         infiltration
%              Unit: m3/s

% Data spec: spatial  resolution: 5-arcminutes (approximately 10x10km)
%            temporal resolution: monthly
%            spatial extend: British Columbia (BC)
%            temporal extend: Jan-1960 to Dec-2010
%
% Output unit: m/yr
% ------------------------------------------------------------------------
clear all
close all
clc

% change folder
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script')% change the file path accordingly
% data obtained from Inge and extracted for BC
% << Check \Data_extraction\Script_PCR_MODFLOW_extractBC for data extraction details>>
load monthly_discharge_BC_full %m3/s monthly data
load Upstream_BC % <<See Data_extraction\Script_Upstream_Monthly for details>>
% each layer rep long term monthly mean
% unit m3/s

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')

load BF_rout_m_mon_BC % routed by Inge
% see C:\Users\chm594\OneDrive - University of
% Saskatchewan\GW_EF\Analysis\BF_Routed_Inge_31May22\Script_BF_rout_Inge
% for more details on extraction

% BC boundary- shape file
cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\province')% change the file path accordingly
Province = shaperead('PROVINCE.SHP','UseGeoCoords',true);
BC_pro=Province(12,:);

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\extraction script') % lat and lot for data clipped for BC % change the file path accordingly
load lat_clip
load lon_clip

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis') % change the file path accordingly
load BGC_Zones_resize % biogeoclimatic zones
% Reading BGC (or WHSE) ascii data -
% Data source: https://www.for.gov.bc.ca/hre/becweb/resources/maps/GISdataDownload.html
% Download: https://catalogue.data.gov.bc.ca/dataset/bec-map
% Processed using ArcGIS
% for data pre processing see Script_Ecoregions.m

% Precip data from Inge - PCR_Globwb
cd ('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Precipitaion_Data_Inge'); % change the file path accordingly
load Pre_myr_annual_BC.mat

cellArea=5478.563709423661*5478.563709423661; % 53.7 deg lat in m2 - for 5 arc minute
%% E1
% baseflow_routed -> m/month (for annual avg)
E1_rout_myr=BF_rout_m_mon_BC.*0.9.*12;

%% E2

discharge_m_s=monthly_discharge_BC./cellArea;

% converting discharge from m3/s to m3/month for easy calculation
mydates1 = (datetime(1960,1,1):calmonths(1):datetime(2010,12,1))';
Year_month_pcr = [mydates1.Month mydates1.Year];
E=eomday(Year_month_pcr(:,2),Year_month_pcr(:,1)); % no. of days in a month

for j=1:size(E)
    discharge_m_mon(:,:,j)=discharge_m_s(:,:,j).*((86400)*E(j,1))*1e-1; %m/month
end

E1=E(1:12);
for pp=1:12
    Upstream_BC_m_mon(:,:,pp)=((Upstream_BC(:,:,pp).*((86400)*E1(pp,1)))./cellArea)*1e-1;
end

% Mean annual discharge
% cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')

discharge_myr= convert_myr(discharge_m_mon); % converting to m/yr

% mean annual discharge
MAD=mean(discharge_myr,3,'omitnan');

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis')

% identify the low-intermediate-high flow months

% conditions
% Low flow (high sensitivity)-> <10% MAD -> k_efn = 95%;
% Intermediate flow (moderate sensitivity)-> 10 - 20% MAD -> k_efn = 90%;
% High flow (low sensitivity) -> >20% MAD -> k_efn = 85%
% % % monthly_discharge_BC_low1=monthly_discharge_BC;

% initialising
% % k_efn(1:size(monthly_discharge_BC,1),1:size(monthly_discharge_BC,2),1:size(monthly_discharge_BC,3))=NaN;
monthly_discharge_BC_low(1:size(discharge_m_mon,1),1:size(discharge_m_mon,2),1:size(discharge_m_mon,3))=NaN;
monthly_discharge_BC_mod(1:size(discharge_m_mon,1),1:size(discharge_m_mon,2),1:size(discharge_m_mon,3))=NaN;
monthly_discharge_BC_high(1:size(discharge_m_mon,1),1:size(discharge_m_mon,2),1:size(discharge_m_mon,3))=NaN;

for i=1:size(discharge_m_mon,3)
    for j=1:size(discharge_m_mon,2)
        for k=1:size(discharge_m_mon,1)
            if (discharge_m_mon(k,j,i)<0.1*MAD(k,j))
                Flow_condition(k,j,i)=1; % low
                monthly_discharge_BC_low(k,j,i)=0.95*discharge_m_mon(k,j,i);
                
            elseif (discharge_m_mon(k,j,i)>=0.1*MAD(k,j) &&...
                    discharge_m_mon(k,j,i)<= 0.2*MAD(k,j))
                Flow_condition(k,j,i)=2; % inter
                monthly_discharge_BC_mod(k,j,i)=0.9*discharge_m_mon(k,j,i);
                
            elseif (discharge_m_mon(k,j,i)> 0.2*MAD(k,j))
                Flow_condition(k,j,i)=3; % high
                monthly_discharge_BC_high(k,j,i)=0.85.*discharge_m_mon(k,j,i);
                
            else
                Flow_condition(k,j,i)=NaN; % no data
                
            end
        end
    end
end

% year-month from 1-1960 to 12-2010
mydates1 = (datetime(1960,1,1):calmonths(1):datetime(2010,12,1))';
Mon_Yr = [mydates1.Month mydates1.Year];

% find the highest flow in low flow month per year
y=1;

for i=1:12:(size(discharge_m_mon,3))% for calander year
    % select only the low flow months in each year and find the max flow
    
    Discharge_clip_low_yr=monthly_discharge_BC_low(:,:,i:i+11); % per water year for low flow only
    Discharge_clip_mod_yr=monthly_discharge_BC_mod(:,:,i:i+11); % per water year for mod flow only
    Discharge_clip_high_yr=monthly_discharge_BC_high(:,:,i:i+11); % per water year for high flow only
    
    Q_test=discharge_m_mon(:,:,i:i+11);
    % max of low months
    [Q_low_max I_low_max]=max(Discharge_clip_low_yr,[],3,'omitnan');%myr
    filter_low=isnan(Q_low_max);
    I_low_max(filter_low)=NaN;
    Q_low_max_test=Q_low_max./0.95;
    
    % for rep discharge
    % %       Q_low_max=
    % min of mod months
    [Q_mod_min I_mod_min]=min(Discharge_clip_mod_yr,[],3,'omitnan');%myr
    filter_mod=isnan(Q_mod_min);
    I_mod_min(filter_mod)=NaN;
    Q_mod_min_test=Q_mod_min./0.9;
    
    % min of high months
    [Q_high_min I_high_min]=min(Discharge_clip_high_yr,[],3,'omitnan');%myr
    filter_high=isnan(Q_high_min);
    I_high_min(filter_high)=NaN;
    Q_high_min_test=Q_high_min./0.85;
    
    % combining max(low), min(mod), min(high)
    Q_gw_m3p_month =arrayfun(@combQ,Q_low_max,Q_mod_min,Q_high_min);
    Q_gw_m3p_month_nokefn =arrayfun(@combQ,Q_low_max_test,Q_mod_min_test,Q_high_min_test);
    Idx_Q_gw =arrayfun(@combQ,I_low_max,I_mod_min,I_high_min); % month chosen
    
    Flow_condition_clip_yr=Flow_condition(:,:,i:i+11);
    
    
    % Groundwater contribution to streamflow per year in m3/mon
    Q_gw_m3yr(:,:,y)= Q_gw_m3p_month.*12; % to convert unit to m/yr
    % %  Q_gw_m3yr(:,:,y)= Q_gw_m3p_month;
    
    Year_clip(y,1)=Mon_Yr(i,1);
    Year_clip(y,2)=Mon_Yr(i,2);
    
    
    % Step 2: Calculating f_local : f_local = (1-(Q_lf_upstream/Q_lf))
    
    % % % % % Discharge_clip_low_yr1=Discharge_clip_low_yr; % per  year for low flow only
    % % %  Discharge_clip_low_yr1=Discharge_clip_low_yr./0.95; % per  year for low flow only (convertingback to actual discharge )
    % % %   f_lo=arrayfun(@f_local,double(Upstream_BC),Discharge_clip_low_yr1);
    
    
    
    % chosing the Upstream value corresponding to the month chosen for Q_gw
    for ro=1:size(Upstream_BC_m_mon,1)
        for co=1:size(Upstream_BC_m_mon,2)
            xx=Idx_Q_gw(ro,co);
            if isnan(xx)
                Upstream_BC_select(ro,co)=NaN;
            else
                Upstream_BC_select(ro,co)=Upstream_BC_m_mon(ro,co,xx);
            end
        end
    end
    
    f_lo=arrayfun(@f_local,double(Upstream_BC_select),Q_gw_m3p_month_nokefn);
    % %
    f_local_mean(:,:,y)=nanmean(f_lo,3);
    
    y=y+1;
end

% Step 3: Calculate E2

for jj=1:size(f_local_mean,3)
    
    E2_myr(:,:,jj)=f_local_mean(:,:,jj).*Q_gw_m3yr(:,:,jj);
    
end

% annual mean
for i=1:51
    E1_rout_myr_mean_yr(i,1)=nanmean(nanmean(E1_rout_myr(:,:,i)));
    E2_myr_mean_yr(i,1)=nanmean(nanmean(E2_myr(:,:,i)));
end

x=1960:2010;
% for visual check
% % % figure()
% % % plot(x',(E1_rout_myr_mean_yr),'r')
% % % hold on
% % % plot(x',(E2_myr_mean_yr),'b')
% % % set(findobj(gca,'type','line'),'linew',1.5)
% % %  box on
% % % % Create title
% % % set(gca,'GridLineStyle',':','XGrid','on','YGrid','on');
% % % xlabel('Year'); ylabel('GW contribution to EF (m/yr)');
% % % legend('E_G_W','E_S_W');
% % %  set(gca,'FontSize', 14, 'FontWeight','bold');

cd('C:\Users\chm594\OneDrive - University of Saskatchewan\GW_EF\Analysis\Paper')% change the file path accordingly
save('E1_E2_new.mat','E1_rout_myr','E2_myr')

