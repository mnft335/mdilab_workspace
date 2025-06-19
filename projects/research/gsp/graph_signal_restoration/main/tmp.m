load(path_search("Rome"));
data = double(data(:, 1));
G_original = gsp_graph(double(W), pos);
G = gsp_adj2vec(G_original);
weights = exp(- abs(G.Diff * data));
G = gsp_vec2adj(G.A, weights);
G = gsp_graph(G, pos);
gsp_plot_signal(G, data);