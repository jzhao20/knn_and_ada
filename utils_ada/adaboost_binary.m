function [outputArg1,outputArg2] = adaboost_binary(train,labels,label)
    ids0=find(labels==label);
    ids1=find(labels~=label);
    weights=zeros(1,length(labels));
    weights(ids0)=1/length(ids0)/2;
    weights(ids1)=1/length(ids1)/2;

    num_features=size(train,1);
    for i=1:num_features
        [vecX,orderX]=sort(train(i,:));
        sorted_vecX(i)=vecX;
        sorted_orders(i)=orderX;
end

