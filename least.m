%LCM  clc
clear all
% a supply
%b demand
%c cost matrix
c=[6 4 1 5;8 9 2 7;4 3 6 4]
a=[14 16 5];
b=[6 10 15 4];
m=size(c,1);     %no of rows
n=size(c,2);     %no of columns
z=0;
if sum(a)==sum(b)  % if supply and demand is equal
    fprintf('given transportation problem is balanced \n');
else
    fprintf('given transportation problem is unbalanced \n');
    if sum(a)<sum(b)      % if demand> supply then
        c(end+1,:)=zeros(1,length(b))    %add new row in c and put 0 from position 1 to length of b matrix
        a(end+1)=sum(b)-sum(a)    % addvalue of new supply as demand-supply
    else
        c(:,end+1)=zeros(length(a),1)  %if supply>demand then add new column and initialise with 0 from 1 to whole column
        b(end+1)=sum(a)-sum(b)     % add value of b as their difference
    end 
end

X=zeros(m,n)
Initialc=c 
for i=1:size(c,1)     % row
    for j=1:size(c,2)    %column
        cpq=min(c(:))      %choosing min cost in whole c matrix and stored in cpq
        if cpq==Inf
            break
        end
        [p1,q1]=find(cpq==c)  % storing position of min cost element
        a(p1)    %choosing its supply value
        b(q1)    % choosing its demand value
        xpq=min(a(p1),b(q1))  %put the min value of both of them in xpq
        X(p1,q1)              % choosing poistion where is it kept
        [X(p1,q1),ind]=max(xpq)   
        p=p1(ind)
        q=q1(ind)
        X(p,q)=min(a(p),b(q))
        if min (a(p),b(q))==a(p)   % if min value choosen is suppply
            b(q)=b(q)-a(p)           % then demand is reduced by supply
            a(p)=a(p)-X(p,q)     % and supply is 0
            c(p,:)=Inf         %and cut the whole row
        else
            a(p)=a(p)-b(q) 
            b(q)=b(q)-X(p,q)  %demand is 0
            c(:,q)=Inf        % cut the whole column
        end 
    end
end
for i=1:size(c,1)
    for j=1:size(c,2)
        z=z+Initialc(i,j)*X(i,j)  % cost * value of that matrix cell gices total min cost
    end
end
%fprintf('InitIAL BFS \N)
array2table(X)
fprintf('Transporation cost is %f \n',z)