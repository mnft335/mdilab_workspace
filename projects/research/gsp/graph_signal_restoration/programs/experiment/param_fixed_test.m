param_fixed.true_graph.type = "generate";
param_fixed.true_graph.adjacency_matrix.type = "path";
param_fixed.true_graph.adjacency_matrix.num_nodes = 128;
param_fixed.true_graph.true_forward_weights.type = "binary";
param_fixed.true_graph.true_forward_weights.scaling_factor = 0.1;
param_fixed.true_graph.true_forward_weights.idx_to_modify.type = "random";
param_fixed.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
param_fixed.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

param_fixed.true_signal.type = "smooth_sampling";
param_fixed.true_signal.smooth_sampling_coefficients.type = "gaussian";
param_fixed.true_signal.smooth_sampling_coefficients.std_dev = 0.1;
param_fixed.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
param_fixed.true_signal.smooth_sampling_coefficients.random_seed = 1;

param_fixed.observation_model.type = "inpainting";
param_fixed.observation_model.masking_ratio = 0.3;
param_fixed.observation_model.random_seed_signal_mask = 1;
param_fixed.observation_model.std_dev = 0.1;
param_fixed.observation_model.random_seed_signal_noise = 1;

param_fixed.optimization.type = "glr";