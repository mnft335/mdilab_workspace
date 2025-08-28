% Paths to the registries of results and true graphs
path.path_result_registry = "projects/research/gsp/graph_signal_restoration/data/result_registry";
path.path_true_graph_registry = "projects/research/gsp/graph_signal_restoration/data/true_graph_registry";

% Parameter ranges to search
range_weight_corruption_ratio = 0.1:0.1:1.0;
range_std_dev_weight_noise = 0.1:0.1:1.0;
range_random_seed_corrupted_graph = 1:10;

% Create an index grid of all parameter indices 
[index_grid_weight_corruption_ratio, index_grid_std_dev_weight_noise, index_grid_random_seed_corrupted_graph] = ndgrid(1:numel(range_weight_corruption_ratio), 1:numel(range_std_dev_weight_noise), 1:numel(range_random_seed_corrupted_graph));

% Create a cell array that stores the results of the grid run
result_grid = cell(numel(range_weight_corruption_ratio), numel(range_std_dev_weight_noise), numel(range_random_seed_corrupted_graph));
param_single_run = struct();

parfor i = 1:numel(index_grid_weight_corruption_ratio)

    weight_corruption_ratio = range_weight_corruption_ratio(index_grid_weight_corruption_ratio(i));
    std_dev_weight_noise = range_std_dev_weight_noise(index_grid_std_dev_weight_noise(i));
    random_seed_corrupted_graph = range_random_seed_corrupted_graph(index_grid_random_seed_corrupted_graph(i));

    param_single_run.true_graph.type = "generate";
    param_single_run.true_graph.adjacency_matrix.type = "gsp_traffic";
    param_single_run.true_graph.adjacency_matrix.city_name = "Rome";
    param_single_run.true_graph.true_forward_weights.type = "gaussian";
    param_single_run.true_graph.true_forward_weights.random_seed = 1;

    param_single_run.corrupted_graph.type = "corrupt";
    param_single_run.corrupted_graph.forward_weight_corruption.type = "additive";
    param_single_run.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
    param_single_run.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = weight_corruption_ratio;
    param_single_run.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = random_seed_corrupted_graph;
    param_single_run.corrupted_graph.forward_weight_corruption.noise.type = "gaussian";
    param_single_run.corrupted_graph.forward_weight_corruption.noise.std_dev = std_dev_weight_noise;
    param_single_run.corrupted_graph.forward_weight_corruption.noise.random_seed = random_seed_corrupted_graph;

    param_single_run.true_signal.type = "smooth_sampling";
    param_single_run.true_signal.smooth_sampling_coefficients.type = "gaussian";
    param_single_run.true_signal.smooth_sampling_coefficients.std_dev = 1;
    param_single_run.true_signal.smooth_sampling_coefficients.sampling_ratio = 0.3;
    param_single_run.true_signal.smooth_sampling_coefficients.random_seed = 1;

    param_single_run.observation_model.type = "inpainting";
    param_single_run.observation_model.masking_ratio = 0.5;
    param_single_run.observation_model.random_seed_signal_mask = 1;
    param_single_run.observation_model.std_dev = 0;
    param_single_run.observation_model.random_seed_signal_noise = 1;

    param_single_run.optimization.type = "glr";

    result_grid{index_grid_weight_corruption_ratio(i), index_grid_std_dev_weight_noise(i), index_grid_random_seed_corrupted_graph(i)} = single_runner(param_single_run, path);

end

save(fullfile("projects\research\gsp\graph_signal_restoration\data\result_grid", "result_grid.mat"), "result_grid");