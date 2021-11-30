function [value]=compute_rectangle(integral_image,x1,y1,x2,y2)
    if x1==0 || y1==0
        small=0;
    else
        small=integral_image(x1-1,y1-1);
    end
    if x1==0
        left=0;
    else
        left=integral_image(x1-1,y1);
    end
    if y1==0
        up=0;
    else
        up=integral_image(x1,y1-1);
    end
    value=integral_image(x2,y2)-left-above+small;
end

