clc
clear all
cost=[-2 0 -1 0 0 0]                %S1,S2,b=0
a=[-1 -1 1 1 0 ; -1 2 -4 0 1]
b=[-5;-8]
A=[a b]
var={'x1','x2','x3','s1','s2','sol'}
bv=[4,5];            %position of s1,s2
zjcj=cost(bv)*A-cost; 

simplex_table=[zjcj;A] 
array2table(simplex_table,'variablenames',var)
run=true;
while run
    sol= A(:,end)
    if any(sol<0) 
        fprintf('the current bfs is not feasible')
        zc=zjcj(1:end-1) 
        [leaving_value,pvt_row]=min(sol);
       
        if all(A(pvt_row,1:end-1)>=0)
            error('lpp is infeasible')
        else
      
            row=A(pvt_row,1:end-1)
            for i=1:size(A,2)-1
                if row(i)<0 
                    ratio(i)=abs(zc(i)./row(i));
                else
                    ratio(i)=inf;
                end
            end
            [enter_val,pvt_col]=min(ratio)
    end
    bv(pvt_row)=pvt_col; 
    pvt_key=A(pvt_row,pvt_col);
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
   
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
        end
    end
    zjcj=cost(bv)*A-cost
    next_table=[zjcj;A];
    array2table(next_table,'variablenames',var)
    else
        run=false;
        fprintf('the final optimal value is %f \n',zjcj(end));
end
end