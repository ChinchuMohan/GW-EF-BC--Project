function a = combQ(x,y,z)
     if ~isnan(x)
        a = x;
     elseif  ~isnan(y)
        a = y;
      elseif  ~isnan(z)
        a = z;
     else
         a=NaN;
     end
 end