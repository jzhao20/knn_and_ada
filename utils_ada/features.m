function [random_features, random_feature_indexes] = features(integral_matrix,random_feature_indexes)
        %create some of each type and then select a random subset of each one
        %in this case 250 of each
        [rows,cols]=size(integral_matrix);
        features=[];
        for x=1:rows
            for y=1:cols
                for x2=x+2:rows
                    for y2=y+2:cols
                        for i=1:4
                            features(end+1)=compute_features(integral_matrix,x,y,x2,y2,i);
                        end
                    end
                end
            end
        end
        %pick 2000 random features and store the indexes of these features so
        %that it'll always remain the same 
        if nargin <2
            random_feature_indexes=randperm(size(features),2000);
        end
        random_features=features(random_feature_indexes);
end

