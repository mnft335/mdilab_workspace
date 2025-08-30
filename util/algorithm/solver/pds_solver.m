function state = pds_solver(formulation_config, pds_config, loop_config)

    % Formulation configurations
    config.L = formulation_config.L;
    config.Lt = formulation_config.Lt;
    config.grad_f = formulation_config.grad_f;
    config.prox_g = formulation_config.prox_g;
    config.prox_h_conj = formulation_config.prox_h_conj;

    % PDS configurations
    config.gamma_x = pds_config.gamma_x;
    config.gamma_y = pds_config.gamma_y;
    config.x_init = pds_config.x_init;
    config.y_init = pds_config.y_init;

    % Solver configurations
    config.stopping_criteria = loop_config.stopping_criteria;
    config.before_iteration = loop_config.before_iteration;
    config.after_iteration = loop_config.after_iteration;

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

    argument = cellfun(@(z1, z2, z3, z4) z1 - z2 * (z3 + z4), state.x, config.gamma_x, config.grad_f(state.x), config.Lt(state.y), "UniformOutput", false);
    x_updated = config.prox_g(argument, config.gamma_x);

end

function y_updated = update_y(config, state)

    argument = cellfun(@(z1, z2) 2 * z1 - z2, state.x, state.x_prev, "UniformOutput", false);
    argument = cellfun(@(z1, z2, z3) z1 + z2 * z3, state.y, config.gamma_y, config.L(argument), "UniformOutput", false);
    y_updated = config.prox_h_conj(argument, config.gamma_y);
    
end