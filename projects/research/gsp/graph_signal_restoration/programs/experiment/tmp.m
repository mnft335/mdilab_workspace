clear;

% Define fixed "grid_param" for experiments
grid_param_fixed.true_graph.type = "generate";
grid_param_fixed.true_graph.adjacency_matrix.type = "david_sensor_network";
grid_param_fixed.true_graph.adjacency_matrix.num_nodes = 64;
grid_param_fixed.true_graph.true_forward_weights.type = "binary";
grid_param_fixed.true_graph.true_forward_weights.scaling_factor = 0.1;
grid_param_fixed.true_graph.true_forward_weights.idx_to_modify.type = "random";
grid_param_fixed.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
grid_param_fixed.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

grid_param_fixed.corrupted_graph.type = [];

grid_param_fixed.true_signal.type = "smooth_sampling";
grid_param_fixed.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_fixed.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_fixed.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.2;
grid_param_fixed.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_fixed.observation_model.type = "inpainting";
grid_param_fixed.observation_model.masking_ratio = 0.3;
grid_param_fixed.observation_model.random_seed_signal_mask = 1;
grid_param_fixed.observation_model.std_dev = 0;
grid_param_fixed.observation_model.random_seed_signal_noise = 1;

grid_param_fixed.optimization.type = "proposal_1";
grid_param_fixed.optimization.coefficient_l1 = linspace(0.0001, 0.9999, 1000);

% Define the parameter grid for corrupted graph configurations
grid_param_varied.corrupted_graph.type = "corrupt";
grid_param_varied.corrupted_graph.forward_weight_corruption.type = "binary_flip";
grid_param_varied.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
grid_param_varied.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1:0.1:0.9;
grid_param_varied.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;

% Get the result for non-corrupted graph as a baseline
grid_param = setfield(grid_param_fixed, "corrupted_graph", "type", "no_corruption");
grid_result_no_corruption = get_grid_result(grid_param, "parallel", []);

% Compute NMSE for the baseline
nmse_no_corruption = compute_nmse_from_result(grid_result_no_corruption.result);

% Find the maximum values over the coefficints on the L1 term
dimension_coefficient_l1 = find_parameter_dimension(grid_result_no_corruption.grid_config_collection, "optimization.coefficient_l1");
[minimum_nmse_no_corruption, argmin_nmse_over_no_corruption] = min(nmse_no_corruption, [], dimension_coefficient_l1);
baselines(1) = minimum_nmse_no_corruption;

% Get the result for homogeneous corrupted graph as another baseline
param = setfield(grid_param_fixed, "corrupted_graph", "type", "homogeneous");
grid_result_homogeneous = get_grid_result(param, "parallel", []);

% Compute NMSE for the homogeneous corrupted graph
nmse_homogeneous = compute_nmse_from_result(grid_result_homogeneous.result);

% Find the maximum values over the coefficints on the L1 term
dimension_coefficient_l1 = find_parameter_dimension(grid_result_homogeneous.grid_config_collection, "optimization.coefficient_l1");
[minimum_nmse_homogeneous, argmin_nmse_over_homogeneous] = min(nmse_homogeneous, [], dimension_coefficient_l1);
baselines(2) = minimum_nmse_homogeneous;

% Get the grid results over the corrupted graph configurations
grid_param = setfield(grid_param_fixed, "corrupted_graph", grid_param_varied.corrupted_graph);
grid_result_over_corrupted_graph = get_grid_result(grid_param, "parallel", []);

% Compute NMSE for each corrupted graph configuration
nmse_over_corrupted_graph = compute_nmse_from_result(grid_result_over_corrupted_graph.result);

% Find the maximum values over the coefficints on the L1 term
dimension_coefficient_l1 = find_parameter_dimension(grid_result_over_corrupted_graph.grid_config_collection, "optimization.coefficient_l1");
[minimum_nmse_over_coefficient_l1, argmin_nmse_over_coefficient_l1] = min(nmse_over_corrupted_graph, [], dimension_coefficient_l1);

% Average NMSE over random seeds, eliminating redundant dimensions with size 1
dimension_random_seed = find_parameter_dimension(grid_result_over_corrupted_graph.grid_config_collection, "corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed");
averaged_nmse_over_corrupted_graph = squeeze(mean(minimum_nmse_over_coefficient_l1, dimension_random_seed));

% Plot the best performance
plot_performance(baselines, averaged_nmse_over_corrupted_graph);

% Visualize the infimal convolution using the best result over the coefficients on the L1 term, at the corruption ratio of 0.5 and the random seed of 1
[~, idx_result_to_plot] = min(nmse_over_corrupted_graph, [], "all");
plot_infimal_convolution(grid_result_over_corrupted_graph.result(idx_result_to_plot), "horizontal");

% Plot the resultant graph signals with the best and worst NMSEs over the coefficients on the L1 term
[~, idx_result_to_plot] = min(nmse_over_corrupted_graph, [], "all");
plot_resultant_graph_signals(grid_result_over_corrupted_graph.result(idx_result_to_plot), "horizontal");
[~, idx_result_to_plot] = max(nmse_over_corrupted_graph, [], "all");
plot_resultant_graph_signals(grid_result_over_corrupted_graph.result(idx_result_to_plot), "horizontal");

min(averaged_nmse_over_corrupted_graph, [], "all")
max(averaged_nmse_over_corrupted_graph, [], "all")