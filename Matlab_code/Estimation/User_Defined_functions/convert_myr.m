% function for converting to m/y

function [xx_myr] = convert_myr(xx)

% year-month from 1-1960 to 12-2010


% converting to m/yr
% Water year is used (Oct to Sep)
% start from Oct 1960 and end at Sep 2010
y=1;

    for i=1:12:(size(xx,3)) % calander year year
    
   xx_annual= xx(:,:,i:i+11);
  C=nansum(xx_annual,3); % per water year % change to sum
    C(all(isnan(xx_annual),3)) = NaN;
     xx_myr(:,:,y)=C;

     
            y=y+1;
    end
end
