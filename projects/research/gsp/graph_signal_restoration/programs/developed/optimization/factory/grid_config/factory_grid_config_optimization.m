function grid_config_optimization = factory_grid_config_optimization(param, arg)

    switch param.type

        % Graph Laplacian Regularization
        case "glr"

            % Create a cell of parameter names
            grid_config_optimization.parameter_name = {};
            
            % Create a cell of parameter ranges
            grid_config_optimization.parameter_range = {};

            % Create the grid configuration name
            grid_config_optimization.configuration_name = {"optimization=" + string(param.type)};

        otherwise

            error("Invalid type for ""optimization"": %s", param.type);

    end

end