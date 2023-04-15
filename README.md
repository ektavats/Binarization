# Automatic Document Image Binarization using Bayesian Optimization #

* Quick summary

This repository contains source code to automaticaally binarize document images using Bayesian optimization.

Document image binarization is often a challenging task due to various forms of degradation. 
Although there exist several binarization techniques in literature, the binarized image is typically sensitive 
to control parameter settings of the employed technique.
An automatic document image binarization algorithm is presented herewith to segment the text from heavily degraded document
images. The proposed technique uses a two band-pass filtering approach for background noise removal, and Bayesian optimization
for automatic hyperparameter selection for optimal results. The effectiveness of the proposed binarization technique is empirically
demonstrated on the Document Image Binarization Competition (DIBCO) and the Handwritten Document Image Binarization Competition (H-DIBCO) datasets.

If you use this repository, please cite:

Ekta Vats, Anders Hast and Prashant Singh, Automatic Document Image Binarization using Bayesian Optimization, 
In Proceedings of the 4th International Workshop on Historical Document Imaging and Processing (HIP 2017), 
Kyoto, Japan, ACM Press, Pages 89–94, 2017. 

Link: https://dl.acm.org/doi/10.1145/3151509.3151520


BibTeX:

@inproceedings{vats2017automatic,

  title={Automatic document image binarization using bayesian optimization},
  
  author={Vats, Ekta and Hast, Anders and Singh, Prashant},
  
  booktitle={Proceedings of the 4th International Workshop on Historical Document Imaging and Processing},
  
  pages={89--94},
  
  year={2017}
  
}


### USAGE ###

Run bayesianOptimizeParameters.m

In the current set up, 6 parameters are optimised:

     f  = mask size for blurring the text, if needed (f>1)
     
     th = threshold for removing noise
     
     C = local threshold mean-C or median-C in adaptivethreshold
     
     ws = local window size in adaptivethreshold
     
     sz1 = window size 1 in bgr
     
     sz2 = window size 2 in bgr
     
     g  = mask size for masking noise, if needed (g>1).

Output is the binarized image.

Accuracy of the resultant binarized image can be computed using the "mypublishtest.m" code by 
Reza FARRAHI MOGHADDAM and Hossein ZIAEI NAFCHI, Synchromedia Lab, ETS, Montreal, Canada.


### AUTHORS ###

Ekta Vats, Anders Hast and Prashant Singh.

Email: ektavats@gmail.com
