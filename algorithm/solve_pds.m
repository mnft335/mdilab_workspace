function state = solve_pds(problem_config, algorithm_config, solver_config)

    % Problem configurations
    config.L = problem_config.L;
    config.Lt = problem_config.Lt;
    config.grad_f = problem_config.grad_f;
    config.prox_g = problem_config.prox_g;
    config.prox_h_conj = problem_config.prox_h_conj;

    % Algorithm configurations
    config.x_init = algorithm_config.x_init;
    config.y_init = algorithm_config.y_init;
    config.Gamma_x = algorithm_config.Gamma_x;
    config.Gamma_y = algorithm_config.Gamma_y;

    % Program configurations
    config.stopping_criteria = solver_config.stopping_criteria;
    config.before_iteration = solver_config.before_iteration;
    config.after_iteration = solver_config.after_iteration;

    % Main loop
    state.x = config.x_init;
    state.y = config.y_init;
    
    while 1
        state = config.before_iteration(config, state);

        state.x_prev = state.x;
        state.x = update_x(config, state);

        state.y_prev = state.y;
        state.y = update_y(config, state);

        state = config.after_iteration(config, state);
        
        if config.stopping_criteria(config, state), break; end
    end

end

function x_updated = update_x(config, state)

    argument = cellfun(@(z1, z2, z3, z4) z1 - z2 * (z3 + z4), state.x, config.Gamma_x, config.grad_f(state.x), config.Lt(state.y), "UniformOutput", false);
    x_updated = config.prox_g(argument, config.Gamma_x);

end

function y_updated = update_y(config, state)

    argument = cellfun(@(z1, z2) 2 * z1 - z2, state.x, state.x_prev, "UniformOutput", false);
    argument = cellfun(@(z1, z2, z3) z1 + z2 * z3, state.y, config.Gamma_y, config.L(argument), "UniformOutput", false);
    y_updated = config.prox_h_conj(argument, config.Gamma_y);
    
end