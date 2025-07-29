clear;

gsp_start();

% Configure functions with random streams initialized by the master seed
random_functions = 

% Graph setup
% Load a graph adjacency W
load(path_search("Rome"));

% Generate a signal from correct weights
W_clean = graph.generate_weighted_adjacency(W, )

formulation_specifics.observed_signal

formulation_specifics.linear_observation = @()
formulation_specifics.linear_observation_transpose = 
formulation_specifics.root_laplacian = @(z) 
formulation_specifics.root_laplacian_transpose = 

formulation_specifics.signal_lower_bound = 0;
formulation_specifics.signal_upper_bound = 1;
formulation_specifics.l2_ball_radius = 0.9 * sqrt()
formulation_specifics.coefficient_l2

algorithm_specifics.step_size_primal_variable = 
algorithm_specifics.step_size_dual_variable_l2_ball = 
algorithm_specifics.step_size_dual_variable_l2 = 

solver_specifics.initial_primal_variable = zeros()
solver_specifics.initial_dual_variable_l2_ball = zeros()
solver_specifics.initial_dual_variable_l2 = zeros()
solver_specifics.stopping_criteria
solver_specifics.before_iteration
solver_specifics.after_iteration


list_generate_uniform_weights = create_handle_list(@)

% Configurations to iterate over
config.generate_weights = {@(z) generate_uniform_weights(z), ...
                    @(z) generate_truncated_normal_weights(z, 1)};

config.weight_corruption = {@add_truncated_normal_noise, ...
                     @multiply_truncated_normal_noise};

additive_weight_noise_sigma = 1:10;
additive_weight_noise_ratio = 0.1:0.1:1.0;

config.multiplicative_weight_noise_sigma = 1:10;
config.multiplicative_weight_noise_ratio = 0.1:0.1:1.0;

config.masking_rate = 0.1:0.1:0.5;
config.signal_noise_sigma = 0.00:0.05:0.2;
config.random_seed = 0:9;

% Preallocate memory for a struct array to store the results
config = struct2cell(config);
config_indices = cellarray(@(z) 1:numel(z), config, "UniformOutput", false);
glr_result(config_indices{:}) = struct("x", [], "y", []);

% Create an index grid to iterate over
[index_grid{1:numel(config)}] = ndgrid(config_indices{:});

% Iterate over a single counter k 
parfor i = 1:numel(glr_result)