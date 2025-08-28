function config_smooth_sampling_coefficients = factory_config_smooth_sampling_coefficients(param, arg)

    switch param.type

        % Generate smooth sampling coefficients
        case "gaussian"

            % Create a helper handle that generates non-zero coefficients
            random_stream = get_random_stream(param.random_seed, "generate_smooth_sampling_coefficients:gaussian");
            generate_nonzero_coefficients = @(vector) param.std_dev * sample_gaussian(random_stream, [numel(vector), 1]);

            % Create a function handle that generates smooth sampling coefficients
            config_smooth_sampling_coefficients.generate_smooth_sampling_coefficients = @(ascending_eigenvectors) apply_partial_data(zeros(size(ascending_eigenvectors, 2), 1), 1:int64(size(ascending_eigenvectors, 2) * param.sampling_ratio), generate_nonzero_coefficients);

            % Create the configuration name
            config_smooth_sampling_coefficients.configuration_name = {"smooth_sampling_coefficients=" + param.type, ...
                                                                      "std_dev=" + string(param.std_dev), ...
                                                                      "sampling_ratio=" + string(param.sampling_ratio), ...
                                                                      "random_seed=" + string(param.random_seed)};

        otherwise

            error("Invalid type for ""smooth_sampling_coefficients"": %s", param.type);

    end

end