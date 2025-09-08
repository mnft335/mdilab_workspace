param.true_graph.type = "generate";
param.true_graph.adjacency_matrix.type = "david_sensor_network";
param.true_graph.adjacency_matrix.num_nodes = 64;
param.true_graph.true_forward_weights.type = "binary";
param.true_graph.true_forward_weights.scaling_factor = 0.1;
param.true_graph.true_forward_weights.idx_to_modify.type = "random";
param.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
param.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

config_true_graph = factory_config_true_graph(param.true_graph, []);
true_graph = config_true_graph.generate_true_graph();

i = 1;
% for i = [79, 81, 82, 83, 86, 98, 113, 119, 120, 121, 122, 155, 158, 187, 189, 193, 194, 195, 196]

    config_node.values = zeros(true_graph.N, 1);
    config_node.color_map = jet(256);
    config_edge.values = assign_partial_elements(zeros(true_graph.Ne, 1), i, 1);
    color_map = gray(288);
    config_edge.color_map = flipud(color_map(1:256, :));

    figure_object = figure;
    figure_object.WindowState = "maximized";

    plot_values_on_graph(true_graph, config_node, config_edge);

% end