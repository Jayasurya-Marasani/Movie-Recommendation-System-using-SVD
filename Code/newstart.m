clc;
close all;
%load test and train datasets
clc;
T=ratingsimport('ratings.dat',[1,inf]);
head(T,10)
T=table2array(T);
T=T(:,1:3);
T=array2table(T,'VariableNames',{'UserID','MovieID','Ratings'});
M=importmovies('movies.dat',[1,inf]);
head(M,10)
T=unstack(T,'Ratings','MovieID','VariableNamingRule','preserve');
T=table2array(T);
T(:,1)=[];
ratings_mat=T;
ratings_mat=ratings_mat';
ratings_mat(isnan(ratings_mat))=0;
%%
for i=1:3706
    norm_mat(i,:)=normalise(ratings_mat(i,:));
end
%%
[U,S,V]=svd(norm_mat);
%%
k=input('Enter The K value:');
moviename=input("Enter movie name: ",'s');   %Toy Story (1995)
v=V';
pred=predict(ratings_mat,U,S,v,k);
%%
f=errorrate(norm_mat,pred);
disp("The Mean Absolute Error is:"+f);
%%
m=M.MovieID(find(M.MovieName==moviename),1);
v=V';
%%
v(k:end,:)=[];
siml=zeros(3076,3076);
for i=1:3706
    for j=1:3706
        x=v(:,i);
        y=v(:,j);
        siml(i,j)=getCosineSimilarity(x,y);
    end
end
%%
x=v(:,m);
cosimilarity=zeros(3706,1);
for i=1:3706
    y=v(:,i);
    cosimilarity(i)=getCosineSimilarity(x,y);
end
top=maxk(cosimilarity,11);
disp("The recommendations for "+moviename+":");
for i=1:10
    [r, ~] = find(cosimilarity == top(i));
    name=M.MovieName(find(M.MovieID==r),1);
    disp(name);
end
