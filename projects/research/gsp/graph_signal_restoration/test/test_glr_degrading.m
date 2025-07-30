clear;

gsp_start();

% Get a function-stream map
function_id_map = get_function_id_map();
function_stream_map = create_function_stream_map(master_seed, function_id_map);

% Graph setup
% Load a graph adjacency W
load(path_search("Rome"));

% Generate a clean signal from correct weights
w_clean = graph.generate_weighted_adjacency(W);
g_clean = graph.create_graph(w_clean);
generate_raw_signal = @() sample_low_frequency_components(function_stream_map("sample_low_frequency_components", 60));
true_signal = generate_clean_signal(generate_raw_signal);

% Generate 

formulation_specifics.observed_signal

formulation_specifics.linear_observation = @()
formulation_specifics.linear_observation_transpose = 
formulation_specifics.root_laplacian = @(z) 
formulation_specifics.root_laplacian_transpose = 

formulation_specifics.signal_lower_bound = 0;
formulation_specifics.signal_upper_bound = 1;
formulation_specifics.l2_ball_radius = 0.9 * sqrt(int64((1 - masking_rate) * g_clean.N)) * signal_noise_sigma;
formulation_specifics.coefficient_l2 = 1;

algorithm_specifics.step_size_primal_variable = 1 / ()
algorithm_specifics.step_size_dual_variable_l2_ball = 
algorithm_specifics.step_size_dual_variable_l2 = 

solver_specifics.initial_primal_variable = zeros(g_clean.N, 1);
solver_specifics.initial_dual_variable_l2_ball = zeros(g_clean.N, 1);
solver_specifics.initial_dual_variable_l2 = zeros(g_clean.Ne, 1);
solver_specifics.stopping_criteria
solver_specifics.before_iteration
solver_specifics.after_iteration  