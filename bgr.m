% BackGround Removal
% (C) Anders Hast 2017

%  Reference:
%  Ekta Vats, Anders Hast and Prashant Singh, 
%  Automatic Document Image Binarization using Bayesian Optimization, 
%  In Proceedings of the 4th International Workshop on Historical Document Imaging and Processing (HIP 2017), 
%  Kyoto, Japan, ACM Press, Pages 89–94, 2017. 

function [nim] = bgr(im, f, th, ct, sz1, sz2, g)
    
    % im = image
    % f  = mask size for blurring the text if wanted (f>1)
    % g  = mask size for masking noise if wanted (g>1)
    % th = threshold for removing noise
    % ct = enhance contrast (ct>0)
    % sz1 = window size 1
    % sz2 = window size 2
    %
    % The idea is to use two band pass filters, where the first one is more
    % blurry but makes it possible to threshold away noise in the image.
    % The second on the other hand is less blurr and more correct, but also
    % have more noise, but less than the original. Hence by thresholding
    % the first and using it as a mask to mask away noise from the second,
    % we obtain a high quality output, which is distinct and with much less
    % noise.
   
    % Start by computing a thick masking of the text
    So=size(im);
    
    % Blurring makes the removal efficient
    if g>1
        [N, sigma]=mask(g, 0);

        g1 = fspecial('gauss',[N 1],sigma);
        div1 = conv2(conv2(ones(So),g1,'same'),g1','same');
        p1=conv2(conv2(im,g1,'same'),g1','same')./div1;
    else
        p1=im;
    end
    
    
    % Compute mask size and sigma using a large window 
    %[N, sigma]=mask(So, 300);
    [N, sigma]=mask(So, sz1);
   
    g2 = fspecial('gauss',[N 1],sigma);
    div2 = conv2(conv2(ones(So),g2,'same'),g2','same'); 
  
    % Compute the bandpass filter
    p2=conv2(conv2(im,g2,'same'),g2','same')./div2;
    im2=p2-p1;
    
    % Threshold the result
    nim1=(im2>th);
    
    
    % Then compute a thin masking of the text 
   
    % Do we want to blur the text a bit?
    if f>1
        [N, sigma]=mask(f, 0);

        g1 = fspecial('gauss',[N 1],sigma);
        div1 = conv2(conv2(ones(So),g1,'same'),g1','same');
        p1=conv2(conv2(im,g1,'same'),g1','same')./div1;
    else
        p1=im;
    end
    
    % Compute mask size and sigma using a small window
    %[N, sigma]=mask(So, 100);
    [N, sigma]=mask(So, sz2);
    g2 = fspecial('gauss',[N 1],sigma);
    div2 = conv2(conv2(ones(So),g2,'same'),g2','same'); 

    % Compute the bandpass filter
    p2=conv2(conv2(im,g2,'same'),g2','same')./div2;
    im2=p2-p1;
    
    % Threshold the image (Negative values are the background)
    nim2=(im2>0).*im2;
    
    % Blow up contrast if necessary
    if ct
        nim2=nim2-min(min(nim2));
        nim2=nim2/max(max(nim2));
    end
    % Extract the text
    % Threshold the thicker mask
    % and use it to mask out the thinner text
    nim=1-(nim1.*nim2);
end

% Function to compute mask size and sigma depending on the window size
function [N,sigma]=mask(So,sz)
    if sz==0
        N=So;
    else
        % What scale shall we use
        scale = min(So)/sz;   
        S=ceil(So/scale);
        % Compute mask size depending on the size of the image
        N=ceil(max(S));
    end
    % Make sure N is odd!
    if mod(N,2) == 0
        N=N+1;
    end
    % Compute sigma depending on mask size
    sigma=N/6;
end