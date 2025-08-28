param_true_graph.type = "generate";
param_true_graph.adjacency_matrix.type = "gsp_traffic";
param_true_graph.adjacency_matrix.city_name = ["Rome", "Tokyo", "Seoul"];
param_true_graph.true_forward_weights.type = "gaussian";
param_true_graph.true_forward_weights.random_seed = [1, 2, 3];

grid_config_true_graph = factory_grid_config_true_graph(param_true_graph, arg);
single_param.true_graph = grid_config_