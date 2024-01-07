function [R]=predict(rat_mat,u,s,v1,k1)
q=u;
p=s*v1;
q(:,k1:end)=[];
p(k1:end,:)=[];
for i=1:3706
    for j=1:6040
        if(rat_mat(i,j)==0)
            R(i,j)=dot(q(i,:),p(:,j));
        else
            R(i,j)=rat_mat(i,j);
        end
    end
end


