function  f = main()
%    If you want to reproduce the entire experiment from the first step,  please delete all the txt files in each folder, 
%      only the 9features*.txt file in the TrainingData folder and all the readme.txt files are saved. Then execute the traindata function. 

%  traindata();  
 
 %    If you want to regain the optimal parameters, please delete all files except the readme.txt file in the Parameter folder, 
 %         and then execute the train(i) function.
 %   If you want to retest with existing parameters, first delete all the files under the TestResult and FinalResult folders,
 %        but keep the readme file and then execute the test(i) function.
   
 for i=1:1:6   %i represents the i-th classifier
       % train(i);
         test(i);
 end
   
   ResultofThreeVarTwoPoly();   %get final result
end