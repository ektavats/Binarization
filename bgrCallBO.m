function [ out ] = bgrCallBO( x )
%  bgrCallBO calls bgr

%  Reference:
%  Ekta Vats, Anders Hast and Prashant Singh, 
%  Automatic Document Image Binarization using Bayesian Optimization, 
%  In Proceedings of the 4th International Workshop on Historical Document Imaging and Processing (HIP 2017), 
%  Kyoto, Japan, ACM Press, Pages 89–94, 2017. 

%   Test for one of the images
    f = x.f;
    th = x.th;
    C = x.C;
    ws = x.ws;
    sz1 = x.sz1;
    sz2 = x.sz2;
    g = x.g;
    ima=(double(rgb2gray(imread('data2016_01.bmp')))/255);
    ima=adaptivethreshold(ima,ws,C,0);             % Preprocessing
    nim=bgr(ima,f,th,1.0,sz1,sz2,g);               % two band pass filtering
    nim_kittler = KittlerMet(im2uint8(nim));       % gray to binary conversion
    imwrite(nim_kittler,'data2016_01_bgr.bmp');
    
    % original file name
    u_filename = 'data2016_01.bmp';

    % GT file name
    u_GT_filename = 'data2016_01_gt.bmp';

    % Binarized file name
    u_bw_filename = 'data2016_01_bgr.bmp';

    % read files
    u = double(imread(u_filename)) / 255;
    u_GT = [im2bw((imread(u_GT_filename))) > 0 ];
    u_bw = [(imread(u_bw_filename)) > 0 ];

    [rowu_GT, colu_GT] = size(u_GT);
    [rowu_bw, colu_bw] = size(u_bw);

    if rowu_GT ~= rowu_bw || colu_GT ~= colu_bw 
        u_GT = imresize(u_GT, [rowu_bw colu_bw]); 
    end

    % calculate the measures
    temp_obj_eval = objective_evaluation_core(u_bw, u_GT);
    out = -1 * temp_obj_eval.Fmeasure; % minimization
    %out = -1 * ((temp_obj_eval.Fmeasure + temp_obj_eval.PSNR)/2); %
    % for multi-objective optimization
end

