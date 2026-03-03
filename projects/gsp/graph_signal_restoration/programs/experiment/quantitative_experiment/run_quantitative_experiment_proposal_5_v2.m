clear;

% Define a grid parameter skeleton
grid_param_skeleton.true_graph.type = "generate";
grid_param_skeleton.true_graph.adjacency_matrix.type = "david_sensor_network";
grid_param_skeleton.true_graph.adjacency_matrix.num_nodes = 64;
grid_param_skeleton.true_graph.true_forward_weights.type = "binary";
grid_param_skeleton.true_graph.true_forward_weights.scaling_factor = 0.1;
grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.type = "random";
grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

grid_param_skeleton.corrupted_graph.type = "corrupt";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.type = "binary_flip";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1;
grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;

grid_param_skeleton.true_signal.type = "smooth_sampling";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_skeleton.observation_model.type = "denoising";
grid_param_skeleton.observation_model.std_dev = 0.05;
grid_param_skeleton.observation_model.random_seed_signal_noise = 1:20;

grid_param_skeleton.optimization.type = "proposal_1";

grid_stride = 0.005;
range_hyperparameter = linspace(0, 1, int64(1 / grid_stride) + 1);
grid_param_skeleton.optimization.coefficient_l1 = range_hyperparameter(2:end-1);

% Get the optimal grid results over hyperparameters
optimal_grid_result_over_hyperparameter = get_optimal_grid_result_over_hyperparameter(grid_param_skeleton, "parallel", []);

% Compute NMSE for the optimal results
nmse = compute_nmse_from_result(optimal_grid_result_over_hyperparameter.result);

% Get the dimension of the random seed for the observation
dimension = find_parameter_dimension(optimal_grid_result_over_hyperparameter.grid_config_collection, "observation_model.random_seed_signal_noise");

% Average the NMSE over the random seed dimension
averaged_nmse = mean(nmse, dimension);

% Get the minimum and argmin of the NMSE over hyperparameters
[minimum_nmse, argmin_nmse] = min(nmse, [], "all");

minimum_nmse
argmin_nmse
averaged_nmse