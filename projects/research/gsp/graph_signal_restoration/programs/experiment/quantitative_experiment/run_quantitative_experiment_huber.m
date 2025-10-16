% Define a grid parameter skeleton
grid_param.true_graph.type = "generate";
grid_param.true_graph.adjacency_matrix.type = "david_sensor_network";
grid_param.true_graph.adjacency_matrix.num_nodes = 64;
grid_param.true_graph.true_forward_weights.type = "binary";
grid_param.true_graph.true_forward_weights.scaling_factor = 0.1;
grid_param.true_graph.true_forward_weights.idx_to_modify.type = "random";
grid_param.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
grid_param.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

grid_param.corrupted_graph.type = "corrupt";
grid_param.corrupted_graph.forward_weight_corruption.type = "binary_flip";
grid_param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
grid_param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1;
grid_param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;

grid_param.true_signal.type = "smooth_sampling";
grid_param.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
grid_param.true_signal.smooth_sampling_coefficients.random_seed = 1:20;

grid_param.observation_model.type = "inpainting_without_noise";
grid_param.observation_model.masking_ratio = 0.2;
grid_param.observation_model.random_seed_signal_mask = 1;

grid_stride_coefficient_huber = 0.005;
range_hyperparameter_coefficient_huber = linspace(0, 1, int64(1 / grid_stride_coefficient_huber) + 1);
grid_stride_threshold_huber = 0.1;
range_param_skeleton.optimization.threshold_huber = linspace(0, 5, int64(5 / grid_stride_threshold_huber) + 1);

grid_param.optimization.type = "proposal_7";
grid_param.optimization.coefficient_huber = range_hyperparameter_coefficient_huber(2:end-1);
grid_param.optimization.threshold_huber = range_param_skeleton.optimization.threshold_huber(2:end);

% Get the optimal grid results
optimal_grid_result = get_optimal_grid_result_over_hyperparameters(grid_param, "parallel", ["optimization.coefficient_huber", "optimization.threshold_huber"], []);

% Compute NMSE for the optimal results
nmse_optimal = compute_nmse_from_result(optimal_grid_result.result);

% Get the dimension of the random seed
dimension_random_seed = find_parameter_dimension(optimal_grid_result.grid_config_collection, "observation_model.random_seed_signal_mask");

% Average the NMSE over the random seed dimension
averaged_nmse_optimal = mean(nmse_optimal, dimension_random_seed);

% Get the minimum and argmin of the NMSEs
[min_nmse_optimal, argmin_nmse_optimal] = min(averaged_nmse_optimal);

min_nmse_optimal
argmin_nmse_optimal
averaged_nmse_optimal