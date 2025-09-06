clear;

graph = gsp_path(64);
coordinates = graph.coords;
graph.Ne

generate_new_forward_weights = @(forward_weights) randn(size(forward_weights));
graph = generate_new_graph(graph.W, generate_new_forward_weights);
graph.coords = coordinates;
graph.Ne
min(graph.weights)

figure;
plot_graph_signal(graph, create_true_signal(graph.U(:, 2)));