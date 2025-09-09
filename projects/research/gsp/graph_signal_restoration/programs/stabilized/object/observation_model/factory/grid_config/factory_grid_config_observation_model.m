function grid_config_observation_model = factory_grid_config_observation_model(param, arg)

    switch param.type

        case "inpainting"

            % Create a cell of parameter names
            grid_config_observation_model.parameter_name = {{"masking_ratio"}, {"random_seed_signal_mask"}, {"std_dev"}, {"random_seed_signal_noise"}};
            
            % Create a cell of parameter ranges
            grid_config_observation_model.parameter_range = {param.masking_ratio, param.random_seed_signal_mask, param.std_dev, param.random_seed_signal_noise};

            % Create the grid configuration name
            grid_config_observation_model.configuration_name = {"observation_model=" + param.type};

        case "denoising"

            % Create a cell of parameter names
            grid_config_observation_model.parameter_name = {{"std_dev"}, {"random_seed_signal_noise"}};
            
            % Create a cell of parameter ranges
            grid_config_observation_model.parameter_range = {param.std_dev, param.random_seed_signal_noise};

            % Create the grid configuration name
            grid_config_observation_model.configuration_name = {"observation_model=" + param.type};

        otherwise

            error("Invalid type for ""observation_model"": %s", param.type);

    end

    % Create a "param" struct template
    grid_config_observation_model.param_template = create_param_template(param, grid_config_observation_model.parameter_name);

end