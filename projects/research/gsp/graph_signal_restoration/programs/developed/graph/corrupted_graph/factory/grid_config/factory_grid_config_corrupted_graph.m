function grid_config_corrupted_graph = factory_grid_config_corrupted_graph(param, arg)

    switch param.type

        case "corrupt"

            % Create a grid configuration for the forward weight corruption
            grid_config_forward_weight_corruption = factory_grid_config_forward_weight_corruption(param.forward_weight_corruption, arg);

            % Create a cell of parameter names
            grid_config_corrupted_graph.parameter_name = cellfun(@(z) [{"forward_weight_corruption"}, z], grid_config_forward_weight_corruption.parameter_name, 'UniformOutput', false);
            
            % Create a cell of parameter ranges
            grid_config_corrupted_graph.parameter_range = grid_config_forward_weight_corruption.parameter_range;

            % Create the grid configuration name
            grid_config_corrupted_graph.configuration_name = [{"corrupted_graph=" + param.type}, ...
                                                              grid_config_forward_weight_corruption.configuration_name];

        otherwise

            error("Invalid type for ""corrupted_graph"": %s", param.type);

    end

    % Create a "param" struct template
    grid_config_corrupted_graph.param_template = create_param_template(param, grid_config_corrupted_graph.parameter_name);

end