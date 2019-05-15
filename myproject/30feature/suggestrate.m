function f=suggestrate()
%SuggestVariableOreder method's acuuracy of 3 vriable and 2 polynomial data
display('**************getting SuggestVariableOrder accuract of different datasets**************');
display('getting SuggestVariableOrder accuract of 3 variables and 2 polynomials');
featurelabel1=dlmread('.\TrainingData\originallable-3v2p.txt');
suggest1=dlmread('.\TestData\suggest-3v2p.txt');
n1=0;          
for i=26145:1:32680
    for j=1:1:6
        if(suggest1(i,j)==1)
             if(featurelabel1(i,j)==1)
                     n1=n1+1; 
             end
        end
    end
end
rate1= n1/6536;
dlmwrite('.\FinalResult\SVOAcuuracy.txt','SVO accuracy of 3v2p: ','-append','delimiter',' ', 'precision','%.4f');
dlmwrite('.\FinalResult\SVOAcuuracy.txt',rate1,'-append','delimiter',' ', 'precision','%.4f');
dispaly(rate1);
%SuggestVariableOreder method's acuuracy of 3 vriable and 1 polynomial data
display('getting SuggestVariableOrder accuract of 3 variables and 1 polynomials');
featurelabel2=dlmread('.\TrainingData\originallable-3v1p.txt');
suggest2=dlmread('.\TestData\suggest-3v1p.txt');
n2=0;          
for i=26145:1:32680
    for j=1:1:6
        if(suggest2(i,j)==1)
             if(featurelabel2(i,j)==1)
                     n2=n2+1; 
             end
        end
    end
end
rate2= n2/6536;
dlmwrite('.\FinalResult\SVOAcuuracy.txt','SVO accuracy of 3v1p: ' ,'-append','delimiter',' ', 'precision','%.4f');
dlmwrite('.\FinalResult\SVOAcuuracy.txt', rate2,'-append','delimiter',' ', 'precision','%.4f');
dispaly(rate2);
%SuggestVariableOreder method's acuuracy of ASG data
display('getting SuggestVariableOrder accuract ofAlgebraic Surface Gallery ');
featurelabel3=dlmread('.\TrainingData\originallable-ASG.txt');
suggest3=dlmread('.\TestData\suggest-ASG.txt');
n3=0;          
for i=1:1:814
    for j=1:1:6
        if(suggest3(i,j)==1)
             if(featurelabel3(i,j)==1)
                     n3=n3+1; 
             end
        end
    end
end
rate3= n3/814;
dispaly(rate3);
dlmwrite('.\FinalResult\SVOAcuuracy.txt','SVO accuracy of ASG: ' ,'-append','delimiter',' ', 'precision','%.4f');
dlmwrite('.\FinalResult\SVOAcuuracy.txt', rate3,'-append','delimiter',' ', 'precision','%.4f');
%SuggestVariableOreder method's acuuracy of 2 vriable and 2 polynomial data
display('getting SuggestVariableOrder accuract of 2 variables and 2 polynomials');
featurelabel4=dlmread('.\TrainingData\originallable-2v2p.txt');
suggest4=dlmread('.\TestData\suggest-2v2p.txt');
n4=0;          
for i=26145:1:32680
        if(suggest4(i,1)==1)
             if(featurelabel4(i,1)==1 || featurelabel4(i,2)==1 || featurelabel4(i,5)==1)
                     n4=n4+1; 
             end
        end
        
        if(suggest4(i,2)==1)
             if(featurelabel4(i,3)==1 || featurelabel4(i,4)==1 || featurelabel4(i,6)==1)
                     n4=n4+1; 
             end
        end
end
rate4= n4/6536;
dispaly(rate4);
dlmwrite('.\FinalResult\SVOAcuuracy.txt','SVO accuracy of 2v2p: ','-append','delimiter',' ', 'precision','%.4f');
dlmwrite('.\FinalResult\SVOAcuuracy.txt', rate4,'-append','delimiter',' ', 'precision','%.4f');
end