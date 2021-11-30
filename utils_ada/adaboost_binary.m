function [classifier] = adaboost_binary(train,labels,label, epochs)
    ids0=find(labels==label);
    ids1=find(labels~=label);
    labels(ids0)=1;
    labels(ids1)=0;
    weights=zeros(1,length(labels));
    weights(ids0)=1/length(ids0)/2;
    weights(ids1)=1/length(ids1)/2;
    w_original=weights;
    num_features=size(train,1);
    for i=1:num_features
        [vecX,orderX]=sort(train(i,:));
        sorted_vecX(i)=vecX;
        sorted_orders(i)=orderX;
    end
    H=zeros(1,size(train,2));
    h=zeros(1,size(train,2));
    classifier=zeros(4,epochs);
    for iter =1:epochs
        t_opt=0;
        sign_opt=0;
        error_opt=0.5;
        index=0;
        for i =1:size(train,2)
            [t,sign,error]=weak_classifier(sorted_vecX(i),weights(sorted_orders(i))...
                ,labels(sorted_orders(i)));
             if error<error_opt
                error_opt=error;
                t_opt=t;
                sign_opt=sign;
                index =i;
            end
        end
        classifier(1,iter)=error_opt;
        classifier(2,iter)=t_opt;
        classifier(3,iter)=sign_opt;
        classifier(4,iter)=index;
        alpha=log((1-error_opt)/error_opt)/2;
        [id1,id0]=find_elements(train,sorted_vecX,sorted_orders,t_opt);
        if sign_opt>0
            h(id1)=1;
            h(id0)=0;
        else
            h(id1)=0;
            h(id0)=1;
        end
        H=H+ht*alpha;
        yt=2*labels-1;
        weights=weights.*exp(-alpha*(yt.*h));
        weights=weights/sum(weights);

        ids0=find((H>0&labels==0)|(H<=0 & trainY==1));
        fprintf('train_error = %f\n',sum(w_original(ids0)));
    end
end

