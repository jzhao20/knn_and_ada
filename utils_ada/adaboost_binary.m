function [outputArg1,outputArg2] = adaboost_binary(train,labels,label, epochs)
    ids0=find(labels==label);
    ids1=find(labels~=label);
    labels(ids0)=1;
    labels(ids1)=0;
    weights=zeros(1,length(labels));
    weights(ids0)=1/length(ids0)/2;
    weights(ids1)=1/length(ids1)/2;

    num_features=size(train,1);
    for i=1:num_features
        [vecX,orderX]=sort(train(i,:));
        sorted_vecX(i)=vecX;
        sorted_orders(i)=orderX;
    end
    H=zeros(1,size(train,2));
    h=zeros(1,size(train,2));
    classifier=zeros(5,epochs);
    for iter =1:epochs
        t_opt=0;
        sign_opt=0;
        error_opt=0.5;
        feaid_opt=0;
        for i =1:size(train,2)
            [t,sign,error]=weak_classifier(sorted_vecX(i),weights(sorted_orders(i))...
                ,labels(sorted_orders(i)))
        end
    end
end

