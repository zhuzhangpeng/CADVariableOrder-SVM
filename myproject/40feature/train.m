function  fun = train(m)
tic
posdatafilename=['.\TrainingData\', int2str(m), '-traindata','.txt'];       %train data
tunetagfilename=['.\Parameter\', int2str(m), '-getcg-tag','.txt'];   %Parameters and accuracy of each cross-validation
tunedfilename=['.\Parameter\', int2str(m), '-bestcg','.txt'];   %best parameters
display(['Classfier number is ',int2str(m)]);
display( ' \**************start training**********************\ ');
disp('begin to read training data ');
posdata = dlmread(posdatafilename);
possize = 6536;         %Cross-validated subset size

circsize=possize;
modelsize=circsize*3;
crosssize=circsize*4;
posdata = posdata(randsample(1:4*possize,4*possize),:);   %random data

oldcrossrate=0;
myjj = 0;    %best parameter of c
mykk = 0;  %best parameter of g
display('start training...');
%Coarse grid
% for jj =-10:1:15
 %    for kk =-5:1:10
 for  jj= -10 : 1 :15
     for  kk= -10 : 1 : 10
        crossrate=0;
        cc=2^jj;
        gg=2^kk;
        %-s 0 means SVM  type is c-SVC,-t 2 means kernel type if RBF,-c is
        %the parameter of c-SVC, -g is the gama in kernel,  -h is set shrinking
      cmd = ['-s 0 -t 2 -c ', num2str(cc), ' -g ', num2str(gg)];    
      crossdata = [posdata(1:possize,:);posdata(possize+1:2*possize,:);posdata(2*possize+1:3*possize,:);posdata(3*possize+1:4*possize,:)];
        for i = 1:4
%         for i = 1:5
            if i>1
                crossdata=circshift(crossdata, -circsize, 1);
            end 
            modeldata=crossdata(1:modelsize,:);
            tunedata=crossdata(modelsize+1:crosssize,:);
            modelclass = modeldata(:,1);
            modelvector = modeldata(:,2:end);
            mymodel=svmtrain(modelclass, modelvector,cmd);
            tuneclass = tunedata(:,1);
            tunevector = tunedata(:,2:end);
            v1=svmpredict(tuneclass,tunevector,mymodel);
            p1=tuneclass+v1;
            crossrate = crossrate + sum(p1~=0)/length(p1);   
        end
        crossrate=crossrate*0.25;
        dlmwrite(tunetagfilename,[jj kk crossrate],'-append','delimiter',' ','precision','%.6f');
        display(crossrate);
        if crossrate > oldcrossrate
           oldcrossrate=crossrate;
           myjj=jj;
           mykk=kk;
        end
     end
 end
 %Small grid
 for  jj= myjj-1 : 0.1 :myjj+1
     for  kk= mykk-1 : 0.1 : mykk+1
        crossrate=0;
        cc=2^jj;
        gg=2^kk;
      cmd = ['-s 0 -t 2 -c ', num2str(cc), ' -g ', num2str(gg)];
      crossdata = [posdata(1:possize,:);posdata(possize+1:2*possize,:);posdata(2*possize+1:3*possize,:);posdata(3*possize+1:4*possize,:)];
        for i = 1:4
%         for i = 1:5
            if i>1
                crossdata=circshift(crossdata, -circsize, 1);
            end 
            modeldata=crossdata(1:modelsize,:);
            tunedata=crossdata(modelsize+1:crosssize,:);
            modelclass = modeldata(:,1);
            modelvector = modeldata(:,2:end);
            mymodel=svmtrain(modelclass, modelvector,cmd);
            tuneclass = tunedata(:,1);
            tunevector = tunedata(:,2:end);
            v1=svmpredict(tuneclass,tunevector,mymodel);
            p1=tuneclass+v1;
            crossrate = crossrate + sum(p1~=0)/length(p1);   
        end
        crossrate=crossrate*0.25;
        dlmwrite(tunetagfilename,[jj kk crossrate],'-append','delimiter',' ','precision','%.6f');
        display(crossrate);
        if crossrate > oldcrossrate
           oldcrossrate=crossrate;
           myjj=jj;
           mykk=kk;
        end
     end
 end
 %best parameter and accuracy
    dlmwrite(tunedfilename,[myjj mykk oldcrossrate],'delimiter',' ','precision','%d');
  display( ' \**************end training**********************\ ');
    toc
end
