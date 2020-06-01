%% Bayesian Optimization for parameters

%  Reference:
%  Ekta Vats, Anders Hast and Prashant Singh, 
%  Automatic Document Image Binarization using Bayesian Optimization, 
%  In Proceedings of the 4th International Workshop on Historical Document Imaging and Processing (HIP 2017), 
%  Kyoto, Japan, ACM Press, Pages 89–94, 2017.

% 6 parameters are optimised:
    % f  = mask size for blurring the text if wanted (f>1)
    % th = threshold for removing noise
    % C = local threshold mean-C or median-C in adaptivethreshold
    % ws = local window size in adaptivethreshold
    % sz1 = window size 1 in bgr
    % sz2 = window size 2 in bgr
    % g  = mask size for masking noise if wanted (g>1)

% Bound constraints
fRange = [0,10];
thRange = [0.05,0.5];
CRange = [0.05,0.2];
wsRange = [35,95];
sz1Range = [200, 400];
sz2Range = [50, 150];
gRange = [0,10];

numVariables = 7;
evaluationBudget = 150;

numInitialPts = 80; 

% Set up optimization
fvar = optimizableVariable('f',fRange,'Type','integer');
thvar = optimizableVariable('th',thRange);
C = optimizableVariable('C',CRange);
ws = optimizableVariable('ws',wsRange,'Type','integer');
sz1 = optimizableVariable('sz1',sz1Range,'Type','integer');
sz2 = optimizableVariable('sz2',sz2Range,'Type','integer');
gvar = optimizableVariable('g',gRange,'Type','integer');
results = bayesopt(@bgrCallBO,[fvar,thvar,C,ws,sz1,sz2,gvar],'Verbose',1,'AcquisitionFunctionName','lower-confidence-bound','MaxObjectiveEvaluations',evaluationBudget,'NumSeedPoints',numInitialPts)

%Use best values to get the final image
best_f = results.XAtMinObjective.f;
best_th = results.XAtMinObjective.th;
best_ws = results.XAtMinObjective.ws;
best_C = results.XAtMinObjective.C;
best_sz1 = results.XAtMinObjective.sz1;
best_sz2 = results.XAtMinObjective.sz2;
best_g = results.XAtMinObjective.g;

ima=(double(rgb2gray(imread('data2016_01.bmp')))/255);
ima=adaptivethreshold(ima,best_ws,best_C,0);
nim=bgr(ima,best_f,best_th,1.0,best_sz1,best_sz2,best_g);
nim_kittler = KittlerMet(im2uint8(nim));

figure; 
imshow(nim_kittler);
imwrite(nim_kittler,'data2016_01_bgr.bmp');
