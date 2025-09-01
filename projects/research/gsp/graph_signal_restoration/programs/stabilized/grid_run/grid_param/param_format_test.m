param.true_graph.type = "generate";
param.true_graph.adjacency_matrix.type = "gsp_traffic";
param.true_graph.adjacency_matrix.city_name = ["Rome"];
param.true_graph.true_forward_weights.type = "gaussian";
param.true_graph.true_forward_weights.random_seed = 1:2;

param.corrupted_graph.type = "corrupt";
param.corrupted_graph.forward_weight_corruption.type = "additive";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1:0.1:0.2;
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1:2;
param.corrupted_graph.forward_weight_corruption.noise.type = "gaussian";
param.corrupted_graph.forward_weight_corruption.noise.std_dev = 0.1:0.1:0.2;
param.corrupted_graph.forward_weight_corruption.noise.random_seed = 1:2;

param.true_signal.type = "smooth_sampling";
param.true_signal.smooth_sampling_coefficients.type = "gaussian";
param.true_signal.smooth_sampling_coefficients.std_dev = 0.1:0.1:0.2;
param.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.1:0.1:0.2;
param.true_signal.smooth_sampling_coefficients.random_seed = 1;

param.observation_model.type = "inpainting";
param.observation_model.masking_ratio = 0.1:0.1:0.2;
param.observation_model.random_seed_signal_mask = 1:2;
param.observation_model.std_dev = 0.1:0.1:0.2;
param.observation_model.random_seed_signal_noise = 1:2;

param.optimization.type = "glr";