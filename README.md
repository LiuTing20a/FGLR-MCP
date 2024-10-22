# FGLR-MCP：Graph Laplacian Regularization for Fast Infrared Small Target Detection
**Matlab implementation of "*Graph Laplacian Regularization for Fast Infrared Small Target Detection*", 
## *Highlights:*
#### 1. * (a) Different from usual graphs that are constructed on each pixel or patch of infrared image, we propose to construct the graph with each frame of infrared sequence. This strategy can reduce the number of vertices in the graph, thereby reducing computational complexity.
<p align="center"> <img src="https://raw.github.com/LiuTing20a/FGLR-MCP/master/Figs/garph_construct.jpg" width="90%"> </p>
#### 2.  * (b) Based on the above graph construction, we propose a fast graph Laplacian regularization (FGLR). The proposed FGLR can describe the low-rank information between infrared sequence images. Toy examples and theoretical 
deductions have demonstrated that FGLR is as effective as nuclear norm. Compared with nuclear norm, the proposed FGLR avoids SVD computation and has a closed-form solution for background estimation. Therefore, the proposed FGLR is more efficient than nuclear norm.representative coefficient matrix. This avoids computing SVD and solving complex regularization terms.
 <p align="center"> <img src="https://raw.github.com/LiuTing20a/FGLR-MCP/master/Figs/flow.jpg" width="90%"> </p>
 
 #### 2. *To demonstrate the advantages of the FGLR-MCP method, we compare it with other eiught methods on six different infrared image scenes.*
 <p align="center"> <img src="https://raw.github.com/LiuTing20a/FGLR-MCP/master/Figs/show11.jpg" width="90%"> </p>
 <p align="center"> <img src="https://raw.github.com/LiuTing20a/FGLR-MCP/master/Figs/show22.jpg" width="90%"> </p>
 
## Get Started
Run demo_WSNMSTIPTLT_FGLRMCP.

## Details

For details such as parameter setting, please refer to [<a href="https://authors.elsevier.com/c/1jyo377nKoMbW">pdf</a>].
## Citation

```
@article{liu2024graph,
  title={Graph Laplacian regularization for fast infrared small target detection},
  author={Liu, Ting and Liu, Yongxian and Yang, Jungang and Li, Boyang and Wang, Yingqian and An, Wei},
  journal={Pattern Recognition},
  pages={111077},
  year={2024},
  publisher={Elsevier}
}
```
## Contact
**Any question regarding this work can be addressed to [liuting@nudt.edu.cn](liuting@nudt.edu.cn).**
