
function [kefn, MMF_low, MMF_mod, MMF_high, flow_cond] = flowCondition(MAD,MMF)

if (MMF<0.1*MAD)
    kefn=0.95;
    flow_cond=1; % low flow
    MMF_low=MMF;
    MMF_mod=NaN;
    MMF_high=NaN;
    
elseif (MMF>=0.1*MAD& MMF<= 0.2*MAD)
    
    kefn=0.9;
    flow_cond=2; % moderate flow
    MMF_low=NaN;
    MMF_mod=MMF;
    MMF_high=NaN;
    
    elseif (MMF> 0.2*MAD)
    
    kefn=0.85;
    flow_cond=3; % high flow
    MMF_low=NaN;
    MMF_mod=NaN;
    MMF_high=MMF;
    
else
     kefn=NaN;
    flow_cond=NaN; % no data
    MMF_low=NaN;
    MMF_mod=NaN;
    MMF_high=NaN;
end