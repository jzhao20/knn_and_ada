addpath("utils_knn")

[test,train,labels,test_labels,classes,count]=read_input();

proj=projection(train);
projected_train=proj'*train;
correct=zeros([length(classes),length(classes)+1],'double');
k=11;
for i=1:length(test)
    [pred,label]=nearest_neighbors(projected_train,test_labels,labels,i,test,proj,k);
    correct(label,pred)=correct(label,pred)+1;
end

num_correct=0;
for i=1:length(classes)
    num_correct=num_correct+correct(i,i);
    correct(i,end)=correct(i,i)/count(i);
end

format short g
total_count=sum(count);
accuracy=num_correct/total_count;

accuracy_string=fprintf("Accuracy is: %f%%\n",accuracy*100);
f=figure;
confusionchart(correct(:,1:end-1),classes);



function [test,train,labels,test_labels,classes,count] = read_input()
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
    train=zeros([3072,sum([imsetTrain.Count])]);
    j=0;
    for c=1:length(imsetTrain)
        for i=1:imsetTrain(c).Count
            labels(end+1)=c;
            train(:,i+j)=reshape(read(imsetTrain(c),i),[3072,1,1]);
        end
        j=j+imsetTrain(c).Count;
    end
    
    imsetTest=imageSet('cifar10Test','recursive');
    test_labels=[];
    count=[imsetTest.Count];
    total_count=sum(count);
    test=zeros([3072,total_count]);
    j=0;
    for c=1:length(imsetTest)
        for i=1:imsetTest(c).Count
            test_labels(end+1)=c;
            test(:,i+j)=reshape(read(imsetTest(c),i),[3072,1,1]);
        end
        j=j+imsetTest(c).Count;
    end
end
