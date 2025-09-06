param.true_graph.type = "generate";
param.true_graph.adjacency_matrix.type = "path";
param.true_graph.adjacency_matrix.num_nodes = 128;
param.true_graph.true_forward_weights.type = "binary";
param.true_graph.true_forward_weights.scaling_factor = 0.1;
param.true_graph.true_forward_weights.idx_to_modify.type = "random";
param.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
param.true_graph.true_forward_weights.idx_to_modify.random_seed = 10;

param.corrupted_graph.type = "corrupt";
param.corrupted_graph.forward_weight_corruption.type = "binary_flip";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.0;
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;

param.true_signal.type = "smooth_sampling";
param.true_signal.smooth_sampling_coefficients.type = "gaussian";
param.true_signal.smooth_sampling_coefficients.std_dev = 0.1;
param.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
param.true_signal.smooth_sampling_coefficients.random_seed = 1;

param.observation_model.type = "inpainting";
param.observation_model.masking_ratio = 0.0;
param.observation_model.random_seed_signal_mask = 1;
param.observation_model.std_dev = 0.0;
param.observation_model.random_seed_signal_noise = 1;

param.optimization.type = "proposal_3";
param.optimization.coefficient_l1 = 0.5;