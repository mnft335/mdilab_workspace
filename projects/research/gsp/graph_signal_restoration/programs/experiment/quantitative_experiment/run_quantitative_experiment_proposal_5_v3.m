clear;

% Preallocate a cell array to store optimal grid results over the shared random seeds
shared_random_seed = 1:20;
optimal_grid_result_over_hyperparameter_tmp = cell(numel(shared_random_seed), 1);

for i = 1:numel(shared_random_seed)

    % Define grid parameter skeleton
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

    grid_param_skeleton.observation_model.type = "inpainting";
    grid_param_skeleton.observation_model.masking_ratio = 0.2;
    grid_param_skeleton.observation_model.random_seed_signal_mask = shared_random_seed(i);
    grid_param_skeleton.observation_model.std_dev = 0.05;
    grid_param_skeleton.observation_model.random_seed_signal_noise = shared_random_seed(i);

    grid_param_skeleton.optimization.type = "proposal_1";

    grid_stride = 0.005;
    range_hyperparameter = linspace(0, 1, int64(1 / grid_stride) + 1);
    grid_param_skeleton.optimization.coefficient_l1 = range_hyperparameter(2:end-1);

    % Get the optimal results for each method
    optimal_grid_result_over_hyperparameter_tmp{i} = get_optimal_grid_result_over_hyperparameter(grid_param_skeleton, "parallel", []);

end

% Create a struct to aggregate the optimal grid results over the shared random seeds for each method
optimal_grid_result_over_hyperparameter = cellfun(@(optimal_grid_result) optimal_grid_result.result, optimal_grid_result_over_hyperparameter_tmp, 'UniformOutput', false);

% Concatenate the results over the shared random seeds along a new dimension at the tail
optimal_grid_result_over_hyperparameter = cat(ndims(optimal_grid_result_over_hyperparameter{1}) + 1, optimal_grid_result_over_hyperparameter{:});

% Compute NMSE for the results
nmse = compute_nmse_from_result(optimal_grid_result_over_hyperparameter);

% Average the NMSE over the random seed dimension
averaged_nmse = mean(nmse, ndims(optimal_grid_result_over_hyperparameter));

% Get the minimum and argmin of the NMSEs
[minimum_nmse, argmin_nmse] = min(nmse, [], "all");

minimum_nmse = minimum_nmse'
argmin_nmse = argmin_nmse'
averaged_nmse = averaged_nmse'