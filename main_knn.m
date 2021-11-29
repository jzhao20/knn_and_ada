addpath("utils")
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

proj=projection(train);
projected_train=proj'*train;
correct=zeros([length(classes),length(classes)+1],'double');
for i=1:sum([imsetTest.Count])
    [pred,label]=nearest_neighbors(projected_train,test_labels,labels,i,test,proj);
    correct(label,pred)=correct(label,pred)+1;
end

num_correct=0;
for i=1:length(classes)
    num_correct=num_correct+correct(i,i);
    correct(i,end)=correct(i,i)/count(i);
end

format short g
accuracy=num_correct/total_count;

rows=classes;
classes{end+1}='total';
cols=classes;

T=array2table(correct,'VariableNames',cols,'RowNames',rows);

accuracy_string=sprintf("Accuracy is: %f%%",accuracy*100);
f=figure;
t=uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'RowName',T.Properties.RowNames);
uicontrol('Style','text','Position',[30 330 200 20],'String',accuracy_string);

