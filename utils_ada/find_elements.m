function [id1,id0] = find_elements(sorted_vecX,sorted_orders,t_opt)
    %find the first point that's larger than it in sorted_vecX and then
    %return all the elements in sorted_orders that are larger and smaller
    dividing_point=binary_search(sorted_vecX,t_opt);
    id1=sorted_orders(dividing_point:end);
    id0=sorted_orders(1:dividing_point);
end

function [index]= binary_search(sorted_vecX,t_opt)
    l=1;
    r=length(sorted_vecX);
    while l<=r
        m=(l+r)/2;
        if sorted_vecX(m)<=t_opt
            r=m-1;
        else
            l=m+1;
        end
    end
    index=l;
end
