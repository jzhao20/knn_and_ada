function [features] = compute_features(integral_matrix,x1,y1,x2,y2,type)
    switch  type
        case 1 
            features=typeA(integral_matrix,x1,y1,x2,y2);
        case 2
            features=typeB(integral_matrix,x1,y1,x2,y2);
        case 3
            features=typeC(integral_matrix,x1,y1,x2,y2);
        case 4
            features=typeD(integral_matrix,x1,y1,x2,y2);
    end
end

function [output]=typeA(integral_matrix,x1,y1,x2,y2)
    big=compute_rectangle(integral_matrix,x1,y1,x2,y2);
    middle_point=floor((y1+y2)/2);
    white_rectangle=compute_rectangle(integral_matrix,x1,y1,x2,middle_point);
    output=big-white_rectangle*2;
end

function [output]=typeB(integral_matrix,x1,y1,x2,y2)
    big=compute_rectangle(integral_matrix,x1,y1,x2,y2);
    middle_point=floor((x1+x2)/2);
    white_rectangle=compute_rectangle(integral_matrix,x1,y1,middle_point,y2);
    output=big-white_rectangle*2;
end

function [output]=typeC(integral_matrix,x1,y1,x2,y2)
    big=compute_rectangle(integral_matrix,x1,y1,x2,y2);
    y3=floor((y2-y1)/3)+y1;
    y4=floor((y2-y1)*2/3)+y1;
    black_rectangle=compute_rectangle(integral_matrix,x1,y3,x2,y4);
    output=2*black_rectangle-big;
end

function [output]=typeD(integral_matrix,x1,y1,x2,y2)
    big=compute_rectangle(integral_matrix,x1,y1,x2,y2);
    x3=floor((x1+x2)/2);
    y3=floor((y1+y2)/2);
    white_rectangle1=compute_rectangle(integral_matrix,x1,y1,x3,y3);
    white_rectangle2=compute_rectangle(integral_matrix,x3,y3,x2,y2);
    output=big-2*(white_rectangle1+white_rectangle2);
end

