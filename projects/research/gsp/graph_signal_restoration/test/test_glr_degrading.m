clear;

num_configurations = numel(generate_weights) * numel(corrupt_weights) * numel(masking_rate) * numel(sigma);
glr_solved(num_configurations) = 

experiment_config.generate_weights = generate_weights{i}
experiment_config.corrupt_weights = 
experiment_config.masking_rate = 
experiment_config.sigma = 

glr_config = struct();
shared_config = shared_config_factory(experiment_config);

glr_solved = solve_glr(shared_config, glr_config);

