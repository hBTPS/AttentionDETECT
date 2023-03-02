clear all; close all;

MiniSAR = dir('..\MiniSAR_GFF\*.gff');
mkdir('..\MiniSAR_JPG');

for k=1:length(MiniSAR)
    % pathname = 'MiniSAR20050519p0001image008.gff';
    pathname = MiniSAR(k).name;
    [Image, Header, fname] = load_gff_1_8b(strcat('..\MiniSAR_GFF\', pathname));
    
    if Header.BytesPerPixel>1
        im_qp = sqrt(abs(Image));
    else
        im_qp = abs(Image);
    end
    
    im_qp = 255*im_qp/max(max(im_qp));
    im_qp = round(min(4*im_qp,255));
    
    imwrite(ind2rgb(im_qp, gray(256)), strcat('..\MiniSAR_JPG\', pathname(1:end-4), '.jpg'));

    subplot(5, 4, k); 
    image(im_qp); 
    colormap(gray(256));
    axis('image');
    title(pathname(8:end));
end