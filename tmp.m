clear;

param_true_graph.type = "generate";
param_true_graph.adjacency_matrix.type = "david_sensor_network";
param_true_graph.adjacency_matrix.num_nodes = 64;
param_true_graph.true_forward_weights.type = "uniform";
param_true_graph.true_forward_weights.lower_bound = 0;
param_true_graph.true_forward_weights.upper_bound = 1;
param_true_graph.true_forward_weights.random_seed = 1;

config_true_graph = factory_config_true_graph(param_true_graph, []);
true_graph = get_true_graph(config_true_graph);