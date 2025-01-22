function shift = FindShiftFFT(im1name, im2name)

    image1 = imread(im1name);
    image2 = imread(im2name);


    IMAGE1 = fft2(image1);
    IMAGE2 = fft2(image2);

    IMAGECORR = conj(IMAGE1).*IMAGE2;
    imagecorr = ifft2(IMAGECORR);

    imagecorrshift = fftshift(imagecorr);

    imagesize = size(image1);
    xcenter = imagesize(2)/2+1;
    ycenter = imagesize(1)/2+1;

    [ymax,xmax,value] = find(imagecorrshift==max(imagecorrshift(:)));
    
    

    shift = [ymax-ycenter,xmax-xcenter];
    
end
