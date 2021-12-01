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
    sorted_vecX=zeros(num_features,size(train,2));
    sorted_orders=zeros(num_features,size(train,2));
    for i=1:num_features
        [vecX,orderX]=sort(train(i,:));
        sorted_vecX(i,:)=vecX;
        sorted_orders(i,:)=orderX;
    end
    H=zeros(1,size(train,2));
    ht=zeros(1,size(train,2));
    classifier=zeros(5,epochs);
    for iter =1:epochs
        t_opt=0;
        sign_opt=0;
        error_opt=0.5;
        index=0;
        for i =1:size(train,1)
            [t,sign,error]=weak_classifier(sorted_vecX(i,:),weights(sorted_orders(i,:))...
                ,labels(sorted_orders(i,:)));
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
        [id1,id0]=find_elements(sorted_vecX(index,:),sorted_orders(index,:),t_opt);
        if sign_opt>0
            ht(id1)=1;
            ht(id0)=-1;
        else
            ht(id1)=-1;
            ht(id0)=1;
        end
        H=H+ht*alpha;
        classifier(5,iter)=alpha;
        yt=2*labels-1;
        weights=weights.*exp(-alpha*(yt.*ht));
        weights=weights/sum(weights);

        ids0=find((H>0&labels==0)|(H<=0 & labels==1));
        fprintf('train_error = %f\n',sum(w_original(ids0)));
    end
    fprintf('\n');
end

