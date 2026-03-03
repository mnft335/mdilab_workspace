% Define a grid parameter skeleton
grid_param_skeleton.true_graph.type = "generate";
grid_param_skeleton.true_graph.adjacency_matrix.type = "david_sensor_network";
grid_param_skeleton.true_graph.adjacency_matrix.num_nodes = 64;
grid_param_skeleton.true_graph.true_forward_weights.type = "uniform";
grid_param_skeleton.true_graph.true_forward_weights.lower_bound = 0;
grid_param_skeleton.true_graph.true_forward_weights.upper_bound = 1;
grid_param_skeleton.true_graph.true_forward_weights.random_seed = 1;

grid_param_skeleton.corrupted_graph.type = "no_corruption";

grid_param_skeleton.true_signal.type = "smooth_sampling";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_skeleton.observation_model.type = "inpainting_without_noise";
grid_param_skeleton.observation_model.masking_ratio = 0.2;
grid_param_skeleton.observation_model.random_seed_signal_mask = 1:30;

grid_param_skeleton.optimization.type = "glr";
