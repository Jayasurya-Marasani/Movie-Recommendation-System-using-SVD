
function mae = errorrate(act,pred)

er=zeros(size(act,1),size(act,2));

for x=1:size(act,1)
        for y = 1:size(act,2)
            if act(x,y)~=0
                er(x,y)= pred(x,y)-act(x,y);
            end       
        end
end

abs_err = sum(sum(abs(er)));
ind = find(er);
l=length(ind);

mae=abs_err/l;



