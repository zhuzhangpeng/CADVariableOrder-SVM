function  fun = traindata()   %get training data and test data
   display('getting training dadta and test data');
   %original data,include feature vector and CAD cellcount
   display('getting training dadta and test data of 3 variables and 2 polynomials');
   data=dlmread('.\TrainingData\30feature-3v2p.txt');
   resdata=data(:,31:end);
   for i=1:1:size(resdata)   %set data label
       [lable]=[];
        a=min(resdata(i,1:6));
        [r]=resdata(i,1:6);
        for j=1:1:6
            if( r(j) <= (a*1.10) )   %Increase 10% fault tolerance
                lable(j)=1;
            else
                lable(j)=-1;
            end
        end
        dlmwrite('.\TrainingData\originallable-3v2p.txt', [ lable ],'-append','delimiter', ' ', 'precision', '%d');
   end
   %data of 3v 2p
   orilable1=dlmread('.\TrainingData\originallable-3v2p.txt');
   labledata1=orilable1(1:end,:);
   for i=1:1:6
       trainfilename=['.\TrainingData\',int2str(i),'-traindata-3v2p','.txt'];
       testfilename=['.\TestData\',int2str(i),'-testdata-3v2p','.txt'];
       Feature=data(:,1:30);
       %regularized feature vector
       vectordata = (Feature - repmat(min(Feature,[],1),size(Feature,1),1))*spdiags(1./(max(Feature,[],1)-min(Feature,[],1))',0,size(Feature,2),size(Feature,2));
       for j = 1:1:26144        %training data
           dlmwrite(trainfilename,[labledata1(j,i) vectordata(j,1:end)],'-append','delimiter',' ','precision','%.4f');
       end     
       for k = 26145:1:32680   %test data
           dlmwrite(testfilename,[labledata1(k,i) vectordata(k,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
   end
   
   % data of 2v2p
   display('gettingtest data of 2 variables and 2 polynomial');
   data2=dlmread('.\TrainingData\30feature-2v2p.txt');
   resdata2=data2(:,31:end);
   for i=1:1:size(resdata2)   %set data label
       [lable]=[-1 -1 -1 -1 -1 -1];
        a=min(resdata2(i,1:2));
        [r]=resdata2(i,1:2);
        for j=1:1:2
            if( r(1) <= (a*1.10) )
                lable(1)=1;
                lable(2)=1;
                lable(5)=1;
            end
            if( r(2) <= (a*1.10) )
                lable(3)=1;
                lable(4)=1;
                lable(6)=1;
            end
        end
        dlmwrite('.\TrainingData\originallable-2v2p.txt',  lable ,'-append','delimiter', ' ', 'precision', '%d');
   end
 
   orilable2=dlmread('.\TrainingData\originallable-2v2p.txt');
   labledata2=orilable2(1:end,:);
   for i=1:1:6
       trainfilename=['.\TrainingData\',int2str(i),'-traindata-2v2p','.txt'];
       testfilename=['.\TestData\',int2str(i),'-testdata-2v2p','.txt'];
       Feature=data2(:,1:30);
      % vectordata = (Feature - repmat(min(Feature,[],1),size(Feature,1),1))*spdiags(1./(max(Feature,[],1)-min(Feature,[],1))',0,size(Feature,2),size(Feature,2));
   %regularized feature vector
      vectordata = mapminmax(Feature,0,1);
      for j = 1:1:20000   %training data
           dlmwrite(trainfilename,[labledata2(j,i) vectordata(j,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
       
       for k = 20001:1:50000  %test data
           dlmwrite(testfilename,[labledata2(k,i) vectordata(k,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
   end

    % data of 3v1p
   display('gettingtest data of 3 variables and 1 polynomial');
     data2=dlmread('.\TrainingData\30feature-3v1p.txt');
   resdata2=data2(:,31:end);
   for i=1:1:size(resdata2)   %set data label
       [lable]=[];
        a=min(resdata2(i,1:6));
        [r]=resdata2(i,1:6);
        for j=1:1:6
            if( r(j) <= (a*1.10) )   %Increase 10% fault tolerance
                lable(j)=1;
            else
                lable(j)=-1;
            end
        end
        dlmwrite('.\TrainingData\originallable-3v1p.txt',  lable ,'-append','delimiter', ' ', 'precision', '%d');
   end
 
   orilable2=dlmread('.\TrainingData\originallable-3v1p.txt');
   labledata2=orilable2(1:end,:);
   for i=1:1:6
       testfilename=['.\TestData\',int2str(i),'-testdata-3v1p','.txt'];
       Feature=data2(:,1:30);   %Regularized featurevector
       vectordata = (Feature - repmat(min(Feature,[],1),size(Feature,1),1))*spdiags(1./(max(Feature,[],1)-min(Feature,[],1))',0,size(Feature,2),size(Feature,2));
       for j = 1:1:length(vectordata)
           dlmwrite(testfilename,[labledata2(j,i) vectordata(j,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
   end
 
   % data of ASG
   display('getting  test data of Algebraic Surface Gallery');
     data3=dlmread('.\TrainingData\30feature-ASG.txt');
   resdata3=data3(:,31:end);
   for i=1:1:size(resdata3)   %set data label
       [lable]=[];
        a=min(resdata3(i,1:6));
        [r]=resdata3(i,1:6);
        for j=1:1:6
            if( r(j) <= (a*1.10) )   %Increase 10% fault tolerance
                lable(j)=1;
            else
                lable(j)=-1;
            end
        end
        dlmwrite('.\TrainingData\originallable-ASG.txt',  lable ,'-append','delimiter', ' ', 'precision', '%d');
   end
 
   orilable3=dlmread('.\TrainingData\originallable-ASG.txt');
   labledata3=orilable3(1:end,:);
   for i=1:1:6
       testfilename=['.\TestData\',int2str(i),'-testdata-ASG','.txt'];
       Feature=data3(:,1:30);   %Regularized featurevector
     %  vectordata = (Feature - repmat(min(Feature,[],1),size(Feature,1),1))*spdiags(1./(max(Feature,[],1)-min(Feature,[],1))',0,size(Feature,2),size(Feature,2));
      vectordata = Feature(:)';
      vectordata = mapminmax(vectordata, 0,1);
      vectordata = reshape(vectordata, size(Feature));
       for j = 1:1:length(vectordata)
           dlmwrite(testfilename,[labledata3(j,i) vectordata(j,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
   end

   
end