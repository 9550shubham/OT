clc
clear all
cost=[2 1 0 0 0 0];
 a=[1 2 1 0 0;1 1 0 1 0;1 -1 0 0 1];
 b=[10;6;2];
A=[a b];
 Var={'x1','x2','s1','s2','s3','sol'}
 bv=[3 4 5]; % position of s1, s2, s3
zjcj=cost(bv)*A-cost;   

% Display initial simplex table
simplex_table=[A; zjcj]
array2table(simplex_table,'VariableNames',Var)
RUN=true;
 while RUN
if any(zjcj(1:end-1)<0) % check for negative value optamility condition
 fprintf(' The current BFS is not optimal \n');
 zc=zjcj(1:end-1);
 [Enter_val, pvt_col]= min(zc) ; %array 
 if all(A(:,pvt_col)<=0)
  error('LPP is Unbounded');
 else
 sol=A(:,end);
 column=A(:,pvt_col);
  for i=1:size(A,1)
 if column(i)>0   % pivot column value positive
 ratio(i)= sol (i)./column(i);
 else
 ratio(i)=inf;
 end
  end 
  [leaving_value,pvt_row]=min(ratio);
 end
 bv(pvt_row)=pvt_col;    % replaced leaving variable with entering variable
 pvt_key=A(pvt_row, pvt_col);
 A(pvt_row,:)=A (pvt_row,:)./pvt_key;
 % row operation 
for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)-A (i, pvt_col).*A(pvt_row,:);
 end
end
 zjcj=cost(bv)*A-cost;
 next_table=[zjcj; A];
array2table(next_table,'VariableNames',Var)

else
    RUN=false;
    
    fprintf('The final optimal value is % f \n',zjcj(end));
end
 end