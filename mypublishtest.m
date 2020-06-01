% test example
% December 27th, 2012, By Reza FARRAHI MOGHADDAM and Hossein ZIAEI NAFCHI, Synchromedia Lab, ETS, Montreal, Canada
% April 15th, 2010, By Reza FARRAHI MOGHADDAM, Synchromedia Lab, ETS, Montreal, Canada

% original file name
u_filename = 'data2009_P05.bmp';

% GT file name
u_GT_filename = 'data2009_P05_gt.tiff';

% Binarized file name
u_bw_filename = 'data2009_P05_bgr.bmp';
%u_bw_filename = 'HW01_bgr_fcm.tif';

% read files
u = double(imread(u_filename)) / 255;
% figure, imshow(u)

u_GT = [(imread(u_GT_filename)) > 0 ];
u_bw = [(imread(u_bw_filename)) > 0 ];
% figure, imshow([u_GT, u_bw])

[rowu_GT, colu_GT] = size(u_GT);
[rowu_bw, colu_bw] = size(u_bw);

if rowu_GT ~= rowu_bw || colu_GT ~= colu_bw 
    u_GT = imresize(u_GT, [rowu_bw colu_bw]); 
end

% calculate the measures
temp_obj_eval = objective_evaluation_core(u_bw, u_GT);
fprintf(' Precision = %9.5f \n Recall = %9.5f \n F-measure (%%) = %9.5f \n Sensitivity = %9.5f \n Specificity = %9.5f \n BCR = %9.5f \n BER (%%) = %9.5f \n F-measure of sens/spec (%%) = %9.5f\n Geometric Accuracy = %9.5f\n pFMeasure (%%) = %9.5f\n NRM  = %9.5f\n PSNR  = %9.5f\n DRD  = %9.5f\n MPM (x1000) = %9.5f \n\n' , ...
    temp_obj_eval.Precision, temp_obj_eval.Recall, temp_obj_eval.Fmeasure, temp_obj_eval.Sensitivity, temp_obj_eval.Specificity, ...
    temp_obj_eval.BCR, temp_obj_eval.BER, temp_obj_eval.SFmeasure, temp_obj_eval.GAccuracy, temp_obj_eval.P_Fmeasure, temp_obj_eval.NRM, temp_obj_eval.PSNR, temp_obj_eval.DRD, 1000 * temp_obj_eval.MPM);
	
	