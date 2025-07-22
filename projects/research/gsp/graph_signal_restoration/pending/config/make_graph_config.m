function config = make_graph_config()
    load("minnesota_graph.mat", G);
    
    config.graph = gsp_adj2vec(G);
    config.num_vertices = G.N;
    config.num_edges = G.Ne;
    config.W = diag(G.weights);
    config.D = G.Diff;
end