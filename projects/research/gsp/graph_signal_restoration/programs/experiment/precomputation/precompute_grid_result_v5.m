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
grid_param_skeleton.corrupted_graph.forward_weight_corruption.type = "additive";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "all";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.noise.type = "gaussian";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.noise.std_dev = [0.05, 0.1];
grid_param_skeleton.corrupted_graph.forward_weight_corruption.noise.random_seed = 1;

grid_param_skeleton.true_signal.type = "smooth_sampling";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_skeleton.observation_model.type = "inpainting_without_noise";
grid_param_skeleton.observation_model.masking_ratio = 0.1:0.1;
grid_param_skeleton.observation_model.random_seed_signal_mask = 1:20;

grid_stride = 0.05;
range_hyperparameter = linspace(0, 1, int64(1 / grid_stride) + 1);
grid_param_skeleton.optimization.coefficient_l1 = range_hyperparameter(2:end-1);

% Create a list of methods
list_methods = ["glr", "gtv", "proposal_2", "proposal_3", "proposal_4"];

% Ensure the all results exist
for i = 1:numel(list_methods)

    grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", list_methods(i));
    ensure_grid_result(grid_param_collection, "parallel", []);

end