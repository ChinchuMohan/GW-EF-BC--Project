% creates a stack of upstream divided my MMF; percent of discharge that comes from upstream [ x = upstream; y = monthly flow] defaults to 1 if >1

function a = f_local(upstream,Q_low)

if(upstream/Q_low<1)
    a=(1-upstream/Q_low);
elseif  (upstream/Q_low>=1)
    a=1;
else 
    a=NaN;
end
end
