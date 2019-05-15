function sol = test(m) 
    modeldatafilename=['.\TrainingData\',int2str(m),'-traindata','.txt'];  %model data
    parameterfilename=['.\Parameter\',int2str(m),'-bestcg','.txt'];   % model parameter   
   
    test3v2pfilename = ['.\TestData\',int2str(m),'-testdata-3v2p','.txt'];     %test data
    testinfo3v2pfilename = ['.\TestResult\',int2str(m),'-testinfo-3v2p','.txt'];        %predict accuracy
    testtag3v2pfilename = ['.\TestResult\',int2str(m),'-test-tag-3v2p','.txt'];    %predict label
    display(['Classfier number is ',int2str(m)]);
    display( ' \**************start testing**********************\ ');
    disp('begin to read model data and model parameter');
  
    posdata = dlmread(modeldatafilename);      
    parameter =  dlmread(parameterfilename);
    cc=parameter(:,1);    %best parameter of c
    gg = parameter(:,2);    %best parameter of g
   
    disp(['c =', int2str(cc), '    g = ',int2str(gg)]);
   
    mycc = 2^(cc);
    mygg = 2^(gg);
    %the parameter of c-SVC, -g is the gama in kernel, -b 1 means getting credibility 
    cmd = ['-s 0 -t 2 -c ', num2str(mycc), ' -g ', num2str(mygg), ' -b 1'];
    modelclass = posdata(:,1);
    modelvector = posdata(:,2:end);
    
    disp('getting the model...');
    mymodel=svmtrain(modelclass, modelvector,cmd);   %test model
    
    disp('model is ready ');
    %test 3 variable and 2 polynomial data
    disp('test 3 variable and 2 polynomial data ');
    testdata1 =  dlmread(test3v2pfilename);
    testdata1 = testdata1(1:6536,:);       
    testclass1 = testdata1(:,1);
    testvector1 = testdata1(:,2:end);
    [predicted_label1, accuracy1, pre_values1]=svmpredict(testclass1,testvector1,mymodel,' -b 1');
     fd = fopen(testtag3v2pfilename,'w');
     fclose(fd);
    dlmwrite(testtag3v2pfilename,[predicted_label1   pre_values1],'-append','delimiter',' ','precision','%.10f');
    dlmwrite(testinfo3v2pfilename,accuracy1(1),'delimiter',' ', 'precision', '%.10f');  
display('*******************end****************************');
end

