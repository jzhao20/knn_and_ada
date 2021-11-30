function [projection] = projection(train)
    tp=mean(train')';
    tp=tp*tp';
    [u,~]=eig(tp);
    projection=u(:,3030:3072);
end

