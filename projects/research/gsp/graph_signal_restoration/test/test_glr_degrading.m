clear;

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