param.true_graph.type = "generate";
param.true_graph.adjacency_matrix.type = "gsp_traffic";
param.true_graph.adjacency_matrix.city_name = "Rome";
param.true_graph.true_forward_weights.type = "gaussian";
param.true_graph.true_forward_weights.random_seed = 1;

param.corrupted_graph.type = "corrupt";
param.corrupted_graph.forward_weight_corruption.type = "additive";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.5;
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;
param.corrupted_graph.forward_weight_corruption.noise.type = "gaussian";
param.corrupted_graph.forward_weight_corruption.noise.std_dev = 0.5;
param.corrupted_graph.forward_weight_corruption.noise.random_seed = 1;

param.true_signal.type = "smooth_sampling";
param.true_signal.smooth_sampling_coefficients.type = "gaussian";
param.true_signal.smooth_sampling_coefficients.std_dev = 0.1;
param.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.2;
param.true_signal.smooth_sampling_coefficients.random_seed = 1;

param.observation_model.type = "inpainting";
param.observation_model.masking_ratio = 0;
param.observation_model.random_seed_signal_mask = 1;
param.observation_model.std_dev = 0;
param.observation_model.random_seed_signal_noise = 1;

param.optimization.type = "glr";

path.path_result_registry = "projects/research/gsp/graph_signal_restoration/data/result_registry";
path.path_true_graph_registry = "projects/research/gsp/graph_signal_restoration/data/true_graph_registry";

grid_config_true_graph = factory_grid_config_true_graph(param.true_graph, []);
grid_config_corrupted_graph = factory_grid_config_corrupted_graph(param.corrupted_graph, []);
grid_config_true_signal = factory_grid_config_true_signal(param.true_signal, []);
grid_config_observation_model = factory_grid_config_observation_model(param.observation_model, []);
grid_config_optimization = factory_grid_config_optimization(param.optimization, []);

% result = single_runner(param, path);