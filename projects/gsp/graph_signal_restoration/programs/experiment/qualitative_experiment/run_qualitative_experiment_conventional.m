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
grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "specify";
grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.cut_name = ["middle_left_top_center"];

grid_param_skeleton.true_signal.type = "smooth_sampling";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.type = "gaussian";
grid_param_skeleton.true_signal.smooth_sampling_coefficients.std_dev = 1;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
grid_param_skeleton.true_signal.smooth_sampling_coefficients.random_seed = 1;

grid_param_skeleton.observation_model.type = "inpainting";
grid_param_skeleton.observation_model.masking_ratio = 0.5;
grid_param_skeleton.observation_model.random_seed_signal_mask = 1;
grid_param_skeleton.observation_model.std_dev = 0;
grid_param_skeleton.observation_model.random_seed_signal_noise = 1;

% Get the result for GLR
grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", "glr");
optimal_grid_result_collection.glr = get_grid_result(grid_param_collection, "serial", []);

% Get the result for gtv
grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", "gtv");
optimal_grid_result_collection.gtv = get_grid_result(grid_param_collection, "serial", []);

% Plot the restoration error for each method
field_names = fieldnames(optimal_grid_result_collection);

for i = 1:numel(field_names)

    for j = 1:numel(grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.cut_name)

        figure_object = figure;
        figure_object.WindowState = "maximized";

        plot_restoration_error(optimal_grid_result_collection.(field_names{i}).result(j));
        title(field_names{i} + " - " + grid_param_skeleton.corrupted_graph.forward_weight_corruption.idx_to_corrupt.cut_name{j}, Interpreter="none");

    end

end