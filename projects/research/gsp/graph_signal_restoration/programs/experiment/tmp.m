% Define fixed "grid_param" for experiments
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

param_fixed.optimization.type = "proposal_1";
param_fixed.optimization.coefficient_l1 = 0.01:0.01:0.1;

% Define the parameter grid for corrupted graph configurations
grid_param_corrupted_graph.type = "corrupt";
grid_param_corrupted_graph.forward_weight_corruption.type = "binary_flip";
grid_param_corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
grid_param_corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1:0.1:0.9;
grid_param_corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1:10;

% Get the result for non-corrupted graph as a baseline
field_name = {"corrupted_graph", "type"};
param = setfield(param_fixed, field_name{:}, "no_corruption");
result_no_corruption = get_result(param, []);

% Compute NMSE for the baseline
baselines(1) = compute_nmse_from_result(result_no_corruption);

% Get the result for homogeneous corrupted graph as another baseline
field_name = {"corrupted_graph", "type"};
param = setfield(param_fixed, field_name{:}, "homogeneous");
result_homogeneous = get_result(param, []);

% Compute NMSE for the homogeneous corrupted graph
baselines(2) = compute_nmse_from_result(result_homogeneous);

% Get the grid results over the corrupted graph configurations
grid_param = setfield(param_fixed, "corrupted_graph", grid_param_corrupted_graph);
grid_result_over_corrupted_graph = get_grid_result(grid_param, "parallel", []);

% Compute NMSE for each corrupted graph configuration
nmse_over_corrupted_graph = compute_nmse_from_result(grid_result_over_corrupted_graph.result);

% Average NMSE over random seeds, eliminating redundant dimensions with size 1
dimension_random_seed = find_parameter_dimension(grid_result_over_corrupted_graph.grid_config_collection, "corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed");
averaged_nmse_over_corrupted_graph = squeeze(mean(nmse_over_corrupted_graph, dimension_random_seed));

% Plot the performance
plot_performance(baselines, averaged_nmse_over_corrupted_graph);