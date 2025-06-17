clear;

% Graph setup
load("minnesota_graph.mat");
V = G.N;
L = G.L;
G = gsp_compute_fourier_basis(G);
    