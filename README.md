# PSF Blur Kernel Generation
This repository is forked from a [repository](https://github.com/handong1587/PSF_generation) that references the work of [Giacomo Boracchi](https://boracchi.faculty.polimi.it/). In his [paper](https://ieeexplore.ieee.org/document/6175123), Boracchi describes an approach using Point Spread Function (PSF) trajectories, representing the path along which a camera or object moves during exposure time, to generate motion blur kernels. 

## Modified Blur Kernel Generation Script
This repository includes a new blur kernel generation script that incorporates two additional parameters, anxiety and exposure, to create motion blur kernels of varying levels of blur, following this paper on [Class Centric Motion Blur Augmentation](https://openaccess.thecvf.com/content/CVPR2023/papers/Aakanksha_Improving_Robustness_of_Semantic_Segmentation_to_Motion-Blur_Using_Class-Centric_Augmentation_CVPR_2023_paper.pdf). 
Anxiety influences the randomness in motion, affecting the complexity of blur, while Exposure refers to the duration of motion, affecting the extent of blur. In total, 900 of such kernels, 100 for each anxiety and exposure combination, were generated and grouped into levels L1-3 according to the exposure level, to be used for data augmentation in both model training and testing. The kernel generation was done with this MATLAB script, modified from the PSF study’s original code.

