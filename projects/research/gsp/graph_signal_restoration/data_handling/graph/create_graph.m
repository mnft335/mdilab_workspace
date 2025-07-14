function graph = create_graph(weights)

    graph = gsp_graph(double(weights));
    graph = gsp_compute_fourier_basis(graph);
    graph = gsp_adj2vec(graph);

end