function [t,sign,error] = weak_classifier(sorted_vec,weights,labels)
    error=0.5;
    t=0;
    sign=1;
    w0=sum(weights(find(labels==0)));
    w1=sum(weights(find(labels==1)));
    w0_c=0;
    w1_c=0;
    for i=1:length(sorted_vec)
        if label(i)==0
            w0_c=w0_c+weights(i);
        else
            w1_c+w1_c+weights(i);
        end
        error_positive=w1_c+w0-w0_c;
        error_negative=w1-w1_c+w0_c;
        if min(error_positive,error_negative)<error
            error=min(error_positive,error_negative);
            if i==1 || i==length(vec)
                t=sorted_vec(i);
            else
                t=vec(i)+vec(i+1)/2;
            end
    end
end

