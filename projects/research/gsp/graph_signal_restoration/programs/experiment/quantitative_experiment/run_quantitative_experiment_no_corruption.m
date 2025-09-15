clear;
% Define a grid parameter skeleton
grid_param_skeleton.true_graph.type = "generate";
grid_param_skeleton.true_graph.adjacency_matrix.type = "david_sensor_network";
grid_param_skeleton.true_graph.adjacency_matrix.num_nodes = 64;
% grid_param_skeleton.true_graph.true_forward_weights.type = "binary";
% grid_param_skeleton.true_graph.true_forward_weights.scaling_factor = 0.1;
% grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.type = "random";
% grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
% grid_param_skeleton.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;
grid_param_skeleton.true_graph.true_forward_weights.type = "gaussian";
grid_param_skeleton.true_graph.true_forward_weights.std_dev = 1;
grid_param_skeleton.true_graph.true_forward_weights.random_seed = 1;

grid_param_skeleton.corrupted_graph.type = "no_corruption";

grid_param_skeleton.true_signal.type = "smooth_sampling";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_skeleton.observation_model.type = "inpainting";
grid_param_skeleton.observation_model.masking_ratio = 0.1;
grid_param_skeleton.observation_model.random_seed_signal_mask = 1;
grid_param_skeleton.observation_model.std_dev = 0.05;
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

minimum_nmse = cellfun(@(x) min(x, [], 'all'), nmse_collection);