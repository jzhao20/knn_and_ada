addpath('utils')
[test,train,labels,test_labels,classes]=read_input();
train_indexes=get_points(train,labels);



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
labels=[];
train=zeros([32,32,sum([imsetTrain.Count])]);
j=0;
for c=1:length(imsetTrain)
    for i=1:imsetTrain(c).Count
        labels(end+1)=c;
        train(:,:,i+j)=rrgb2gray(ead(imsetTrain(c),i));
    end
    j=j+imsetTrain(c).Count;
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
