function  fun = traindata()   %get training data and test data
   display('getting training dadta and test data');
   %original data,include feature vector and CAD cellcount
   display('getting training dadta and test data of 3 variables and 2 polynomials');
   data=dlmread('.\TrainingData\40feature-3v2p.txt');
   resdata=data(:,41:end);
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
 
   orilable=dlmread('.\TrainingData\originallable-3v2p.txt');
   labledata=orilable(1:end,:);
   for i=1:1:6
       trainfilename=['.\TrainingData\',int2str(i),'-traindata','.txt'];
       testfilename=['.\TestData\',int2str(i),'-testdata-3v2p','.txt'];
       Feature=data(:,1:40);     
       %regularized feature vector
       vectordata = (Feature - repmat(min(Feature,[],1),size(Feature,1),1))*spdiags(1./(max(Feature,[],1)-min(Feature,[],1))',0,size(Feature,2),size(Feature,2));
      %training data
       for j = 1:1:26144   
           dlmwrite(trainfilename,[labledata(j,i) vectordata(j,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
       %test data
       for k = 26145:1:32680
           dlmwrite(testfilename,[labledata(k,i) vectordata(k,1:end)],'-append','delimiter',' ','precision','%.4f');
       end
   end
   
 
   
end