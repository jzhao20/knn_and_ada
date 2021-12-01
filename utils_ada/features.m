function [random_features, random_feature_indexes] = features(gray_image,num_features,random_feature_indexes)
        %pick some random features and store those as the way to grab
        %features
        integral_matrix=integral_image(gray_image);
        random_features=zeros([1,num_features]);
        if nargin < 3
            [rows,cols]=size(integral_matrix);
            random_feature_indexes=zeros([5,num_features]);
            for i =1:num_features
                type=randi(4,1,1);
                values=randi([1,rows-1],1,2);
                [x1,y1]=deal(values(1),values(2));
                x2=randi([x1,rows],1);
                y2=randi([y1,cols],1);
                random_feature_indexes(:,i)=[x1,y1,x2,y2,type]';
                random_features(i)=compute_features(integral_matrix,x1,y1,x2,y2,type);
            end
        else
            for i=1:num_features
                j=random_feature_indexes(:,i);
                [x1,y1,x2,y2,type]=deal(j(1),j(2),j(3),j(4),j(5));
                random_features(i)=compute_features(integral_matrix,x1,y1,x2,y2,type);
            end
        end
end

