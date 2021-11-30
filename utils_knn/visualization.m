function [] = visualization(img)
    img=reshape(img,[32,32,3]);
    r=img(:,:,1);
    g=img(:,:,2);
    b=img(:,:,3);
    im(:,:,1)=r;
    im(:,:,2)=g;
    im(:,:,3)=b;
    imshow(imresize(im,[192,192]))
end

