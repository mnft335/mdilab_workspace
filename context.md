# Context for Implementation: Robust Graph Signal Recovery Experiments
**Target:** Experiments for IEEE Transactions on Signal Processing (TSP) paper
**Agent Role:** Analyze the current codebase, identify missing components, and generate a concrete, actionable task list for the user.

## 1. Project Goal
Implement and evaluate a novel graph signal recovery method robust to "Fatal Errors" (spurious edges with high weights) in proxy graphs. The proposed method uses a Generalized Infimal Convolution of L1 and L2 norms, solved via Preconditioned Primal-Dual Splitting (P-PDS).

## 2. Experimental Requirements (To Be Implemented)
The experiments must validate the method against baseline models (GLR, GTV, and GLR+GTV linear combination) using both synthetic and real-world datasets.

### A. Synthetic Data Generation
* **Graph Models:** Need generators for three types of graphs:
    1.  Random Geometric Graph (RGG): Simulates sensor networks.
    2.  Stochastic Block Model (SBM): Simulates social networks (cluster structure).
    3.  Barabasi-Albert Model (BA): Simulates scale-free infrastructure networks.
* **True Graph Weights:** Initialization logic (e.g., using a Gaussian kernel based on distance or cluster affiliation).
* **Smooth Signal Generation:** Create true ground-truth signals by taking a linear combination of low-frequency components (eigenvectors corresponding to the smallest eigenvalues of the true graph Laplacian).

### B. Error / Noise Injection (Crucial for Evaluation)
We need robust functions to corrupt the true graph into a "Proxy Graph".
* **Fatal Errors (Overestimated Weights):** Randomly select edges with *small* true weights (below a threshold) and replace them with *large* values.
* **Underestimated Weights:** Randomly select edges with *large* true weights (above a threshold) and replace them with *small* values.
* **Mixed Errors:** A combination of overestimated and underestimated weights.
* **Global Noise:** Apply uniform random noise to all edge weights.

### C. Optimization Algorithms & Baselines
* **Baselines:** Standard GLR, Standard GTV, and a simple linear combination of GLR + GTV.
* **Proposed Method:** P-PDS solver integrating the infimal convolution regularizer.
    * *Note:* Ensure the P-PDS algorithm includes automatic step-size calculation (based on operator norms/maximum singular values).

### D. Evaluation Metrics & Visualizations
* **Robustness Plots:** Plot MSE (y-axis) against the severity/ratio of errors (x-axis) for all methods.
* **Qualitative Bypass Visualization:** A specific plot/output showing that large signal differences on corrupted edges are being absorbed by the L1 component of the infimal convolution, while the L2 component remains small.