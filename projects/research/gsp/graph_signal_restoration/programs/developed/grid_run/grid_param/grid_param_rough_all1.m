param.true_graph.type = "generate";
param.true_graph.adjacency_matrix.type = "gsp_traffic";
param.true_graph.adjacency_matrix.city_name = ["Rome"];
param.true_graph.true_forward_weights.type = "gaussian";
param.true_graph.true_forward_weights.random_seed = 1;

param.corrupted_graph.type = "all1";

param.true_signal.type = "smooth_sampling";
param.true_signal.smooth_sampling_coefficients.type = "gaussian";
param.true_signal.smooth_sampling_coefficients.std_dev = [0.5, 1.0];
param.true_signal.smooth_sampling_coefficients.sampling_ratio = [0.1, 0.3];
param.true_signal.smooth_sampling_coefficients.random_seed = 1;

param.observation_model.type = "inpainting";
param.observation_model.masking_ratio = [0.3, 0.5];
param.observation_model.random_seed_signal_mask = 1;
param.observation_model.std_dev = [0.5, 1.0];
param.observation_model.random_seed_signal_noise = 1;

param.optimization.type = "glr";