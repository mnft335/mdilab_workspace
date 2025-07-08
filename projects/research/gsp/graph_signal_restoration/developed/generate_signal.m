function signal = generate_signal(W)
    G = gsp_graph(double(W));
    G = gsp_compute_fourier_basis(G);
    G = gsp_adj2vec(G);
    sum(G.e < 1e-9)
    G.e(G.e < 1e-9)
    sum(G.weights > 0)
    signal = ones(5, 1);
end