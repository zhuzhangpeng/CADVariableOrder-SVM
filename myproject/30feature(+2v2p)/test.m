function sol = test(m) 
   data3v2pfilename=['.\TrainingData\', int2str(m), '-traindata-3v2p','.txt'];       %train data
   data2v2pfilename=['.\TrainingData\', int2str(m), '-traindata-2v2p','.txt'];       %train data
   parameterfilename=['.\Parameter\',int2str(m),'-cg','.txt'];   % model parameter   
   
   test3v2pfilename = ['.\TestData\',int2str(m),'-testdata-3v2p','.txt'];
   testinfo3v2pfilename = ['.\TestResult\',int2str(m),'-testinfo-3v2p','.txt'];        %predict accuracy
   testtag3v2pfilename = ['.\TestResult\',int2str(m),'-test-tag-3v2p','.txt'];    %predict label
   
   test2v2pfilename = ['.\TestData\',int2str(m),'-testdata-2v2p','.txt'];
   testinfo2v2pfilename = ['.\TestResult\',int2str(m),'-testinfo-2v2p','.txt'];        %predict accuracy
   testtag2v2pfilename = ['.\TestResult\',int2str(m),'-test-tag-2v2p','.txt'];    %predict label
 
    test3v1pfilename = ['.\TestData\',int2str(m),'-testdata-3v1p','.txt'];
   testinfo3v1pfilename = ['.\TestResult\',int2str(m),'-testinfo-3v1p','.txt'];        %predict accuracy
   testtag3v1pfilename = ['.\TestResult\',int2str(m),'-test-tag-3v1p','.txt'];    %predict label
   
   testASGfilename = ['.\TestData\',int2str(m),'-testdata-ASG','.txt'];
   testinfoASGfilename = ['.\TestResult\',int2str(m),'-testinfo-ASG','.txt'];        %predict accuracy
   testtagASGfilename = ['.\TestResult\',int2str(m),'-test-tag-ASG','.txt'];    %predict label
   display(['Classfier number is ',int2str(m)]);
   display( ' \**************start testing**********************\ ');
   disp('begin to read model data and model parameter'); 
   %get model
   data1 = dlmread(data3v2pfilename);
   data2 = dlmread(data2v2pfilename);
   datasize  = 3000;   %insert datasize*4 2 variable and 2 polynomial data
   posdata = [data1(1:26144,:);data2(1:datasize*4,:)];
   possize = 6536+datasize;         %6536+3000
   posdata = posdata(randsample(1:4*possize,4*possize),:);   %random data
  
   parameter =  dlmread(parameterfilename);
   cc=parameter(1,1);   %best parameter of c
   gg = parameter(1,2);   %best parameter of g

   mycc = 2^(cc);
   mygg = 2^(gg);
   %the parameter of c-SVC, -g is the gama in kernel, -b 1 means getting credibility 
    cmd = ['-s 0 -t 2 -c ', num2str(mycc), ' -g ', num2str(mygg), ' -b 1'];
    modelclass = posdata(:,1);
    modelvector = posdata(:,2:end);
    mymodel=svmtrain(modelclass, modelvector,cmd);   %test model

    %test 3 variable and 2 polynomial data,data is from 1 to 6536 
     disp('test 3 variable and 2 polynomial data ');
    testdata1 =  dlmread(test3v2pfilename);
    testdata1 = testdata1(1:6536,:);       
    testclass1 = testdata1(:,1);
    testvector1 = testdata1(:,2:end);
    [predicted_label1, accuracy1, pre_values1]=svmpredict(testclass1,testvector1,mymodel,' -b 1');
    dlmwrite(testtag3v2pfilename,[predicted_label1   pre_values1],'-append','delimiter',' ','precision','%.10f');
    dlmwrite(testinfo3v2pfilename,accuracy1(1),'delimiter',' ', 'precision', '%.10f');

     %test 2 variable and 2 polynomial data,data is from 6145 to 12680
     disp('test 2 variable and 2 polynomial data ');
    testdata4 =  dlmread(test2v2pfilename);
    testdata4 = testdata4(6145:12680,:);       
    testclass4 = testdata4(:,1);
    testvector4 = testdata4(:,2:end);
    [predicted_label4, accuracy4, pre_values4]=svmpredict(testclass4,testvector4,mymodel,' -b 1');
    dlmwrite(testtag2v2pfilename,[predicted_label4   pre_values4],'-append','delimiter',' ','precision','%.10f');
    dlmwrite(testinfo2v2pfilename,accuracy4(1),'delimiter',' ', 'precision', '%.10f');

     %test 3 variable and 1 polynomial data, data is from 26145 to 32680
     disp('test 3 variable and 1 polynomial data ');
    testdata2 =  dlmread(test3v1pfilename);
    testdata2 = testdata2(26145:32680,:);       
    testclass2 = testdata2(:,1);
    testvector2 = testdata2(:,2:end);
    [predicted_label2, accuracy2, pre_values2]=svmpredict(testclass2,testvector2,mymodel,' -b 1');
    dlmwrite(testtag3v1pfilename,[predicted_label2   pre_values2],'-append','delimiter',' ','precision','%.10f');
    dlmwrite(testinfo3v1pfilename,accuracy2(1),'delimiter',' ', 'precision', '%.10f');
 
     %test ASG data
     disp('test Algebraic Surface Gallery data ');
    testdata3 =  dlmread(testASGfilename);
    testdata3 = testdata3(1:814,:);       
    testclass3 = testdata3(:,1);
    testvector3 = testdata3(:,2:end);
    [predicted_label3, accuracy3, pre_values3]=svmpredict(testclass3,testvector3,mymodel,' -b 1');
    dlmwrite(testtagASGfilename,[predicted_label3   pre_values3],'-append','delimiter',' ','precision','%.10f');
    dlmwrite(testinfoASGfilename,accuracy3(1),'delimiter',' ', 'precision', '%.10f');
    display('*******************end****************************');
end

