% Copyright:
% Ekta Vats, Anders Hast and Prashant Singh 
% 2017
% Uppsala University, Sweden.


% Cite as:
% Ekta Vats, Anders Hast and Prashant Singh, Automatic Document Image Binarization using Bayesian Optimization, In Proceedings of the 4th International Workshop on Historical Document Imaging and Processing (HIP 2017), Kyoto, Japan, ACM Press, Pages 89–94, 2017. 
% Link: https://dl.acm.org/doi/10.1145/3151509.3151520


% For research purposes only. 
% Contact the authors for more information.
% Email: {ekta.vats, anders,hast, prashant.singh}@it.uu.se


% Run bayesianOptimizeParameters.m
% 6 parameters are optimised:
    % f  = mask size for blurring the text if wanted (f>1)
    % th = threshold for removing noise
    % C = local threshold mean-C or median-C in adaptivethreshold
    % ws = local window size in adaptivethreshold
    % sz1 = window size 1 in bgr
    % sz2 = window size 2 in bgr
    % g  = mask size for masking noise if wanted (g>1)


% Run bgrCallBO.m to compute the accuracy of the binarization result.
