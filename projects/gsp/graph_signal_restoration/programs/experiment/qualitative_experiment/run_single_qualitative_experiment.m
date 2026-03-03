% Define the parameters
param.true_graph.type = "generate";
param.true_graph.adjacency_matrix.type = "david_sensor_network";
param.true_graph.adjacency_matrix.num_nodes = 64;
param.true_graph.true_forward_weights.type = "binary";
param.true_graph.true_forward_weights.scaling_factor = 0.1;
param.true_graph.true_forward_weights.idx_to_modify.type = "random";
param.true_graph.true_forward_weights.idx_to_modify.scaling_ratio = 0.5;
param.true_graph.true_forward_weights.idx_to_modify.random_seed = 1;

param.corrupted_graph.type = "corrupt";
param.corrupted_graph.forward_weight_corruption.type = "binary_flip";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1;
param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;

param.true_signal.type = "smooth_sampling";
param.true_signal.smooth_sampling_coefficients.type = "gaussian";
param.true_signal.smooth_sampling_coefficients.std_dev = 1;
param.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
param.true_signal.smooth_sampling_coefficients.random_seed = 1;

param.observation_model.type = "inpainting_without_noise";
param.observation_model.masking_ratio = 0.2;
param.observation_model.random_seed_signal_mask = 20;

param.optimization.type = "proposal_3";

grid_stride = 0.005;
range_hyperparameter = linspace(0, 1, int64(1 / grid_stride) + 1);
param.optimization.coefficient_l1 = range_hyperparameter(2:end-1);

% Get the optimal result over the hyperparameter
optimal_grid_result = get_optimal_grid_result_over_hyperparameter(param, "parallel", []);

% Get the restored signal plot
restored_plot = plot_restored_signal_for_paper(optimal_grid_result.result);

% Put the plot in the configuration for paper
restored_figure = plot_for_paper(restored_plot);

% Export the figure as an EPS file
path_image_registry = "projects\research\gsp\graph_signal_restoration\resources\data\images\qualitative_experiment";
exportgraphics(restored_figure, fullfile(path_image_registry, "restored_signal_plot.eps"), "ContentType", "vector", "BackgroundColor", "none");

% Get the restoration residual plot
residual_plot = plot_restoration_residual_for_paper(optimal_grid_result.result);

% Put the plot in the configuration for paper
residual_figure = plot_for_paper(residual_plot);

% Export the figure as an EPS file
exportgraphics(residual_figure, fullfile(path_image_registry, "restoration_residual_plot.eps"), "ContentType", "vector", "BackgroundColor", "none");