function [pred,label] = nearest_neighbors(projected_train,label_test,label_train,instance_id,test,projection)
    query=test(:,instance_id);
    label=label_test(instance_id);
    dif=(projection'*query)*ones(1,size(projected_train,2))-projected_train;
    [~,order]=sort(sqrt(sum(dif.*dif)));
    labels=zeros([1,10]);
    for i=1:10
        labels(label_train(order(i)))=labels(label_train(order(i)))+1;
    end
    [~,pred]=max(labels);
end

