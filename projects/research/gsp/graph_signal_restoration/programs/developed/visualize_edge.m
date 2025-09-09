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

% subscripts_to_highlight = [[23, 22]; [38, 22]; [25, 22]; [61, 22]];
% subscripts_to_highlight = [[63, 37]; [49, 37]; [50, 37]; [37, 29]; [37, 36]; [37, 14]; [41, 37]];
% subscripts_to_highlight = [[21, 20]];
% subscripts_to_highlight = [[45, 12]; [45, 35]];
subscripts_to_highlight = [[47, 29]; [60, 16]; [46, 13]];
idx_forward_weights_to_highlight = arrayfun(@(row, col) find_idx_forward_weight_from_subscripts(true_graph.W, row, col), subscripts_to_highlight(:, 1), subscripts_to_highlight(:, 2))

config_node.values = zeros(true_graph.N, 1);
config_node.color_map = jet(256);
config_edge.values = assign_partial_elements(zeros(true_graph.Ne, 1), idx_forward_weights_to_highlight, 1);
color_map = gray(288);
config_edge.color_map = flipud(color_map(1:256, :));

figure_object = figure;
figure_object.WindowState = "maximized";

plot_values_on_graph(true_graph, config_node, config_edge);

function idx_forward_weight = find_idx_forward_weight_from_subscripts(weight_matrix, row_to_find, col_to_find)

    % Create the subscripts for the forward weights in the same way as in the GSP toolbox
    [row, col, ~] = find(tril(weight_matrix));

    % Find the index of the forward weight corresponding to the given subscripts
    [~, idx_forward_weight] = ismember([row_to_find, col_to_find], [row, col], 'rows');

end