function [integral_image] = integral_image(image)
    [rows,cols]=size(image);
    integral_image=zeros([rows,cols]);
    for i=2:rows
        integral_image(i,1)=integral_image(i-1,1)+image(i,1);
    end
    for i=2:cols
        integral_image(1,i)=integral_image(1,i-1)+image(1,i);
    end
    for i =2:rows
        for j=2:cols
            integral_image(i,j)=integral_image(i-1,j)+integral_image(i,j-1)+image(i,j)-integral_image(i-1,j-1);
        end
    end
end

