The complete process of the experiment is as follows:
1. Get original feature vector and CAD cellcount of different datasets.
   The feature vectors and polynomial cells of different data sets are obtained from the .mw file in the MapleFile folder. 9feature is the feature vector proposed by Huang et al., and 30feature is our proposed feature vector. 3v2p represents 3 variables and 2 polynomials, and the others are similar.The initial file of each data set is in the InitialData folder, and the data obtained by .wm is stored in the sub-folder TrainData of the folder such as 9feature. The data format in InitialData is in the format of maple.

2. Get trianing data and test data.
   The data set obtained in 1 is divided into training data and test data, the data is classified according to the number of CAD cells, and the feature vector is regularized. These can be achieved by traindata.m in a folder such as 30feature.  The input file is in the TrainData, and the output training data is stored in the TrainData. The test data is stored in TestData.

3. Get the best model and the model's parameters.
   The optimal training model and model parameters are obtained through train.m in a folder such as 30feature. The training process and optimal parameters are stored in the Parameter folder.

4. Test different dataset.
   Test the different data sets with the optimal model and get the test results of each data set.This process can be implemented by test.m. It should be noted that the test results at this time are only the test results of each classifier, not the final result.Tested test tags, test    accuracy, and tag confidence are stored in FinalResult.

5  Get final test result.
   The final prediction label is obtained according to the prediction results and credibility of different classifiers.The final prediction label is obtained according to the prediction results and credibility of different classifiers. The prediction result of the same set of data may have multiple +1s or all -1, but at this time, a unique +1 is determined according to the credibility. The final result is obtained through the Result*.m file, and the final predicted    label and accuracy are stored in FinalResult.

*****************************************************
Warning£ºSome of the experimental results in the experiment are stored in append form during storage, so it is necessary to manually delete the previous experimental results when repeating the experiment. These files include *-traindata.txt in TrainingData, originallabel*.txt, *-testdata-*.txt in TestData, all files in Parameter, all files in TestResult, and all files in FinalResult.
The parameters of our experimental model are already included in the uploaded project file, so you can test directly. If you want to reproduce the complete experiment, delete the trained parameters and make adjustments in the main function.
*****************************************************


 
The contents of each folder are as follows:
*****************************************************
9 feature: the experiment of 9 features
21 feature: the experiment of 21 features 
30 feature: the experiment of 30 features. You can get the accuracy of SuggestVariableOrder by suggestrate.m in this folder.
30 feature(+2v2p): the experiment of 30 features, but insert 1,2000 2 variables and 2 polynomials dataset into the model.
40 feature: the experiment of 40 features 

These 4 folders have the same subfolders and files.
TrainingData: In this folder, feature*.txt are the files of feature vector and cellcount. In 9feature*.txt file, the first 11 data are the features in Huang's paper every line,but we only use 3--11. The 12 to end are the polynomials CAD cellcount for different variable orders,and the variable orders are (x1,x2,x3),(x1,x3,x2),(x2,x1,x3),(x2,x3,x1),(x3,x1,x2),(x3,x2,x1).If the file name is feature-2v2p, the variable orders are (x1,x2), (x2,x1).    In 30feature*.txt file, the first 30 data are the features of our method, and 1--21 are the 21 feaures. The 30 to end are the polynomials CAD cellcount for different variable orders,and the variable orders are (x1,x2,x3),(x1,x3,x2),(x2,x1,x3),(x2,x3,x1),(x3,x1,x2),(x3,x2,x1).If the file name is feature-2v2p, the variable orders are (x1,x2), (x2,x1).

*-traindata.txt files are the training data of different classfiers. The first column is the label, 2 to end are the feature vectors which have been regularized.

original*.txt files are the label of variable orders for (x1,x2,x3),(x1,x3,x2),(x2,x1,x3),(x2,x3,x1),(x3,x1,x2),(x3,x2,x1).

*-traindata.txt and original*.txt files can be obtained by traindata.m file.



*****************************************************
TestData: In the folder, there are the files of test data for different datasets. The first column is the real label,2 to end are the feature vectors which have been regularized. These documents can be obtained by traindata.m file.


*****************************************************
Parameter: There are 2 kind file in this folder. The *-getcg-tag.txt files store the parameters c and g and the accuracy of cross-validation using the grid search method and cross-validation method.  The optimal parameters c, g, and the accuracy of cross-validation stored in the *-bestcg.txt file.


*****************************************************
TestResult:The testinfo-*.txt files in this folder store the test accuracy for classifiers of different datasets.   The test-tag*.txt files stores the prediction labels and the labels's cridibility for different datasets.And in these files, the first column is the predict labels, the second column is the cridibility for +1, the third column is the cridibility for -1.


*****************************************************
FinalResult: In this folder, the PredictAccuracy*.txt stores the final accuracy of different test datasets, the PredictLabel*.txt stores the final predict labels of different datasets.


*****************************************************
InitialDataset: Original different datasets which include the data's polynomials, CAD cellcount and CAD compute time.  In this folder,there are 2 kinds of files,cellcount*.txt and polynomial*.txt.  

The cellcount*.txt files saved the CAD cellcount and compute CAD time for the polynomials of different variables orders. If the polynomials have 3 variables,the cellcount and time follow the order of (x1,x2,x3),(x1,x3,x2),(x2,x1,x3),(x2,x3,x1),(x3,x1,x2),(x3,x2,x1).  If the polynomials have 2 variables,the cellcount and time follow the order of (x1,x2),(x2,x1).

The polynomial*.txt files saved the polynomials of different datasets.

*****************************************************
MapleFile: In this folder, there are the files of use MapleSoftware to get data's different features. 9feature*.txt is the files of get features of Huang's paper. 30feature*.txt is the files of get features of our paper, the first 21 are the features
21 features in our paper. 

*****************************************************
traindata.m: You can get training data and test data by this file.


*****************************************************
train.m: This file captures the optimal model and parameters through grid search and cross-validation, where the parameter m represents the first classifier.


*****************************************************
test.m:This file tests different types of data through the model, where the parameter m represents the first classifier.

*****************************************************
Result*.m: These files calculate the final prediction label by the results predicted by each classifier.


*****************************************************
main.m: This file is a complete experiment by calling other .m files, at which point you can set whether to run a complete experiment or a part of the experiment.