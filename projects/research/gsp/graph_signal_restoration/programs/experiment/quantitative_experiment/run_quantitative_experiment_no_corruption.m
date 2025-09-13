% Define a grid parameter skeleton
grid_param_skeleton.true_graph.type = "generate";
grid_param_skeleton.true_graph.adjacency_matrix.type = "david_sensor_network";
grid_param_skeleton.true_graph.adjacency_matrix.num_nodes = 64;
grid_param_skeleton.true_graph.true_forward_weights.type = "binary";
grid_param_skeleton.true_graph.true_forward_weights.scaling_factor = 0.1;
grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.type = "random";
grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

grid_param_skeleton.corrupted_graph.type = "no_corruption";
% grid_param_skeleton.corrupted_graph.type = "corrupt";
% grid_param_skeleton.corrupted_graph.forward_weight_corruption.type = "binary_flip";
% grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
% grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1:0.1:0.5;
% grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;

grid_param_skeleton.true_signal.type = "smooth_sampling";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_skeleton.observation_model.type = "inpainting";
% grid_param_skeleton.observation_model.masking_ratio = 0.1:0.1:0.5;
grid_param_skeleton.observation_model.masking_ratio = 0.3;
grid_param_skeleton.observation_model.random_seed_signal_mask = 1;
% grid_param_skeleton.observation_model.std_dev = [0.05, 0.1];
grid_param_skeleton.observation_model.std_dev = 0;
grid_param_skeleton.observation_model.random_seed_signal_noise = 1;

% Get the optimal results for each method
optimal_grid_result_collection = get_optimal_grid_result_collection(grid_param_skeleton, 100, "parallel", []);

% Get the method names
field_names = fieldnames(optimal_grid_result_collection);

% Preallocate a cell array to store NMSEs averaged over random seeds for each method
nmse_collection = cell(numel(field_names), 1);

% Compute NMSEs for each method
for i = 1:numel(field_names)

    % Compute NMSE for the results
    nmse_collection{i} = compute_nmse_from_result(optimal_grid_result_collection.(field_names{i}).result);

end

% For testing
nmse = cell(numel(nmse_collection{1}), 1);
for i = 1:numel(nmse_collection{1})

    nmse{i} = cellfun(@(nmse_on_method) nmse_on_method(i), nmse_collection);

end