function config_optimization = factory_config_optimization(param, arg)

    switch param.type

        % Graph Laplacian Regularization
        case "glr"

            % Create a function handle that generates an optimization struct for the GLR
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_glr(graph, true_signal, observation_model), ...
                                                                                                        "solver", @solver_glr);

            % Create the configuration name
            config_optimization.configuration_name = {"solver=" + param.type};

        otherwise

            error("Invalid type for ""solver"": %s", param.type);

    end

end