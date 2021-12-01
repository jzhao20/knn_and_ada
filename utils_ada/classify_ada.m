function [output] = classify_ada(classifier,features)
    output=0;
    for i=1:size(classifier,2)
        index=classifier(4,i);
        t_opt=classifier(2,i);
        if(features(index)>t_opt)
            ht=1;
        else
            ht=-1;
        end
        sign_opt=classifier(3,i);
        if sign_opt<0
            ht=-ht;
        end
        output=output+ht*classifier(5,i);
    end
end

