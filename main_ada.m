addpath('utils')
[test,train,labels,test_labels,classes]=read_input();
train_indexes=get_points(train,labels);
epochs=10;
num_features=500;
feature_train=zeros([num_features,size(train,3)]);
feature_indexes=zeros([1,num_features]);
for i=1:size(train,3)
    if i==1
        [feature_train(:,i),features_indexes]=features(train(:,:,i),num_features);
    else
        feature_train(:,i)=features(train(:,:,i),num_features,features_indexes);
    end
end

feature_test=zeros([num_features,size(test,3)]);
for i=1:size(test,3)
    feature_test(:,i)=features(feature_test,num_features,feature_indexes);
end

classifiers=zeros([5,epochs,length(classes)]);
for i = 1:length(classes)
    classifiers(:,:,i)=adaboost_binary(feature_train,labels,i,epochs);
end

correct=zeros(length(classes));
num_correct=0;
for i=1:size(feature_test,2)
    tmp=zeros([1,10]);
    for j=1:size(classifiers,3)
        tmp(j)=classify_ada(classifiers(:,:,j),feature_test(:,i));
    end
    [~,class]=max(tmp);
    num_correct=num_correct+(class == test_labels(i));
    correct(test_labels(i),class)=correct(test_labels(i),class)+1;
end

format short g;
accuracy=num_correct/(size(feature_test,2));
fprintf("the accuracy was %f%%",accuracy*100);
confusionchart(correct);


function [test,train,labels,test_labels,classes] = read_input()
if ~exist('cifar-10-batches-mat','dir')
    cifar10Dataset = 'cifar-10-matlab';
    websave([cifar10Dataset,'.tar.gz'],...
        ['https://www.cs.toronto.edu/~kriz/',cifar10Dataset,'.tar.gz']);
    gunzip([cifar10Dataset,'.tar.gz'])
    delete([cifar10Dataset,'.tar.gz'])
    untar([cifar10Dataset,'.tar'])
    delete([cifar10Dataset,'.tar'])
end    
   
if ~exist('cifar10Train','dir') 
    saveCIFAR10AsFolderOfImages('cifar-10-batches-mat', pwd, true);
end
%code above from https://www.mathworks.com/matlabcentral/fileexchange/62990-deep-learning-tutorial-series

imsetTrain=imageSet('cifar10Train','recursive');
classes={imsetTrain.Description};
num_per_class=200;
train=zeros([32,32,num_per_class*length(classes)]);
labels=zeros([1,num_per_class*length(classes)]);
j=0;
for c=1:length(imsetTrain)
    %select 200 random ones per class to reduce time of training
    tmp=zeros([32,32,imsetTrain(c).Count]);
    tmp_labels=zeros([1,imsetTrain(c).Count]);
    for i=1:imsetTrain(c).Count
        tmp_labels(i)=c;
        tmp(i)=rrgb2gray(read(imsetTrain(c),i));
    end
    indexes=randperm(1,num_per_class);
    for i =1:num_per_class
        labels(i+j)=tmp_labels(indexes(i));
        train(i+j)=tmp(:,:,indexes(i));
    end
    j=j+num_per_class;
end

imsetTest=imageSet('cifar10Test','recursive');
test_labels=[];
count=[imsetTest.Count];
total_count=sum(count);
test=zeros([32,32,total_count]);
j=0;
for c=1:length(imsetTest)
    for i=1:imsetTest(c).Count
        test_labels(end+1)=c;
        test(:,i+j)=rgb2gray(read(imsetTest(c),i));
    end
    j=j+imsetTest(c).Count;
end
end
