function graph = create_graph(weight_matrix)

    % Create a graph object
    graph = gsp_graph(weight_matrix);
    graph = gsp_compute_fourier_basis(graph);
    graph = gsp_adj2vec(graph);

end