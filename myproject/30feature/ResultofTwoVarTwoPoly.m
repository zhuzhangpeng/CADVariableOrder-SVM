function sol = ResultofTwoVarTwoPoly()    
%For the label with the predicted result, when the predicted value is -1, the least credibility is +1, the other is marked as -1,
%                                                                when the predicted value has more than +1, the highest credibility is +1, the other  is marked as -1
%Calculate  percentage of predicted values the same as real values
display('getting final result of 2 variables and 2 polynomials');
v1data =  dlmread('.\TestData\1-testdata-2v2p.txt');
v1data =  v1data(26145:32680,:);
v1class = v1data(:,1);           %real labels
v2data =  dlmread('.\TestData\2-testdata-2v2p.txt');
v2data =  v2data(26145:32680,:);
v2class = v2data(:,1);
v3data =  dlmread('.\TestData\3-testdata-2v2p.txt');
v3data =  v3data(26145:32680,:);
v3class = v3data(:,1);
v4data =  dlmread('.\TestData\4-testdata-2v2p.txt');
v4data =  v4data(26145:32680,:);
v4class = v4data(:,1);
v5data =  dlmread('.\TestData\5-testdata-2v2p.txt');
v5data =  v5data(26145:32680,:);
v5class = v5data(:,1);
v6data =  dlmread('.\TestData\6-testdata-2v2p.txt');
v6data =  v6data(26145:32680,:);
v6class = v6data(:,1);

pre1data =  dlmread('.\TestResult\1-test-tag-2v2p.txt');
pre1data =  pre1data(1:end,:);
pre1class = pre1data(:,1);         %predict labels
trust1class = pre1data(:,2:3);      %predict labels's credibility
pre2data =  dlmread('.\TestResult\2-test-tag-2v2p.txt');
pre2data =  pre2data(1:end,:);
pre2class = pre2data(:,1);
trust2class = pre2data(:,2:3);
pre3data =  dlmread('.\TestResult\3-test-tag-2v2p.txt');
pre3data =  pre3data(1:end,:);
pre3class = pre3data(:,1);
trust3class = pre3data(:,2:3);
pre4data =  dlmread('.\TestResult\4-test-tag-2v2p.txt');
pre4data =  pre4data(1:end,:);
pre4class = pre4data(:,1);
trust4class = pre4data(:,2:3);
pre5data =  dlmread('.\TestResult\5-test-tag-2v2p.txt');
pre5data =  pre5data(1:end,:);
pre5class = pre5data(:,1);
trust5class = pre5data(:,2:3);
pre6data =  dlmread('.\TestResult\6-test-tag-2v2p.txt');
pre6data =  pre6data(1:end,:);
pre6class = pre6data(:,1);
trust6class = pre6data(:,2:3);
n=0;
for i =1:1:6536
   
    [a]=[-1 -1 -1 -1 -1 -1];
    m=0;         %How many predictions are +1
    j=0;    %   j  j is the position where the label is +1
    maxtrust=0;   %+1 credibility
    mintrust=0;    %-1 credibility
    %Calculate the final order according to the predictive labels of
    %different classifiers and the credibility of predicted labels
    %1
   if(pre1class(i)>=0)
       m=m+1;      
       j=1;
       maxtrust=max(trust1class(i,:));
   else
       m=0;
       j=1;
       mintrust=max(trust1class(i,:));
   end
   %2
    if(pre2class(i)>=0)
       m=m+1;
       if(max(trust2class(i,:))>=maxtrust)
       j=2;
       maxtrust=max(trust2class(i,:));
       end
    else
       if(m==0)
           if(max(trust2class(i,:))<=mintrust) 
               j=2;
               mintrust=max(trust2class(i,:));
           end
       end
    end
    %3
    if(pre3class(i)>=0)
       m=m+1;
       if(max(trust3class(i,:))>=maxtrust)
       j=3;
       maxtrust=max(trust3class(i,:));
       end
    else
       if(m==0)
           if(max(trust3class(i,:))<=mintrust) 
               j=3;
               mintrust=max(trust3class(i,:));
           end
       end
    end
   %4
    if(pre4class(i)>=0)
       m=m+1;
       if(max(trust4class(i,:))>=maxtrust)
       j=4;
       maxtrust=max(trust4class(i,:));
       end
    else
       if(m==0)
           if(max(trust4class(i,:))<=mintrust) 
               j=4;
               mintrust=max(trust4class(i,:));
           end
       end
    end
   %5
       if(pre5class(i)>=0)
            m=m+1;
            if(max(trust5class(i,:))>=maxtrust)
                 j=5;
                maxtrust=max(trust5class(i,:));
            end
       else
           if(m==0)
               if(max(trust5class(i,:))<=mintrust) 
                   j=5;
                   mintrust=max(trust5class(i,:));
               end
           end
       end
 %6  
      if(pre6class(i)>=0)
           m=m+1;
           if(max(trust6class(i,:))>=maxtrust)
                j=6;
              maxtrust=max(trust6class(i,:));
           end
    else
       if(m==0)
           if(max(trust6class(i,:))<=mintrust) 
               j=6;
               mintrust=max(trust6class(i,:));
           end
       end
     end
  %Calculate the same number of predicted values as the original label
     if(j==1)
          a(j)=1;
          if(v1class(i)==1)
               n=n+1; 
           end
     end
            
     if(j==2)
           a(j)=1;
           if(v2class(i)==1)
                n=n+1;
            end
      end
            
      if(j==3)
           a(j)=1;
           if(v3class(i)==1)
                n=n+1;
           end
      end
            
      if(j==4)
           a(j)=1;
           if(v4class(i)==1)
                    n=n+1;
           end
      end
            
      if(j==5)
           a(j)=1;
            if(v5class(i)==1)
               n=n+1;
            end
      end
            
      if(j==6)
           a(j)=1;
           if(v6class(i)==1)
                n=n+1;
           end
       end
          dlmwrite('.\FinalResult\PredictLabel-2v2p.txt',a,'-append','delimiter',' ','precision','%d');     
end

rate=0;
rate=n/6536;
dlmwrite('.\FinalResult\PredictAccuracy-2v2p.txt',rate,'delimiter',' ','precision','%d');
display('Result of 2v2p Accuracy:');
display(rate);
end