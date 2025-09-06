function config_optimization = factory_config_optimization(param, arg)

    switch param.type

        % Graph Laplacian Regularization
        case "glr"

            % Create a function handle that generates an optimization struct for the GLR
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_glr(graph, true_signal, observation_model), ...
                                                                                                        "solver", @solver_glr);

            % Create the configuration name
            config_optimization.configuration_name = {"optimization=" + param.type};

        case "gtv"

            % Create a function handle that generates an optimization struct for the GTV
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_gtv(graph, true_signal, observation_model), ...
                                                                                                        "solver", @solver_gtv);

            % Create the configuration name
            config_optimization.configuration_name = {"optimization=" + param.type};

        case "proposal_1"

            % Create a function handle that generates an optimization struct for the proposed method 1
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_proposal_1(graph, true_signal, observation_model, param.coefficient_l1), ...
                                                                                                        "solver", @solver_proposal_1);

            % Create the configuration name
            config_optimization.configuration_name = {"optimization=" + param.type, ...
                                                      "coefficient_l1=" + string(param.coefficient_l1)};

        case "proposal_2"

            % Create a function handle that generates an optimization struct for the proposed method 2
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_proposal_2(graph, true_signal, observation_model, param.coefficient_l1), ...
                                                                                                        "solver", @solver_proposal_2);

            % Create the configuration name
            config_optimization.configuration_name = {"optimization=" + param.type, ...
                                                      "coefficient_l1=" + string(param.coefficient_l1)};

        case "proposal_3"

            % Create a function handle that generates an optimization struct for the proposed method 3
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_proposal_3(graph, true_signal, observation_model, param.coefficient_l1), ...
                                                                                                        "solver", @solver_proposal_3);

            % Create the configuration name
            config_optimization.configuration_name = {"optimization=" + param.type, ...
                                                      "coefficient_l1=" + string(param.coefficient_l1)};

        case "proposal_4"

            % Create a function handle that generates an optimization struct for the proposed method 4
            config_optimization.generate_optimization = @(graph, true_signal, observation_model) struct("config_solver", generate_config_proposal_4(graph, true_signal, observation_model, param.coefficient_l1), ...
                                                                                                        "solver", @solver_proposal_4);

            % Create the configuration name
            config_optimization.configuration_name = {"optimization=" + param.type, ...
                                                      "coefficient_l1=" + string(param.coefficient_l1)};

        otherwise

            error("Invalid type for ""optimization"": %s", param.type);

    end

end