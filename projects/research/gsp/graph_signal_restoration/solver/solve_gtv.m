function result = solve_gtv(shared_config, specific_config)

    gamma_y2 = 0.5 / (sqrt(max(eig(shared_config.G.Diff.' * diag(shared_config.G.weights) * shared_config.G.Diff))));

    import prox.*;
    prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, shared_config.b, shared_config.epsilon));
    prox_l1_conj = prox_conj(@(z, gamma) prox_l1(z, gamma, gamma_y2 * 0.5));

    problem_config.L = @(z) {shared_config.Phi(z{1}), ...
                             sqrt(shared_config.G.weights) .* (shared_config.G.Diff * z{1})};
    problem_config.Lt = @(z) {shared_config.Phit(z{1}) + shared_config.G.Diff.' * (sqrt(shared_config.G.weights) .* z{2})};
    problem_config.grad_f = @(z) {zeros(size(z{1}))};
    problem_config.prox_g = @(z, gamma) {prox_box(z{1}, shared_config.lower, shared_config.upper)};
    problem_config.prox_h_conj = @(z, gamma) {prox_ball_l2_conj(z{1}, gamma{1}), ...
                                              prox_l1_conj(z{2}, gamma{2})};
                                  
    algorithm_config.x_init = {zeros(shared_config.G.N, 1)};
    algorithm_config.y_init = {zeros(shared_config.G.N, 1), ...
                               zeros(shared_config.G.Ne, 1)};
    algorithm_config.Gamma_x = {1 / (1 + sqrt(max(eig(shared_config.G.Diff.' * diag(shared_config.G.weights) * shared_config.G.Diff))))};

    algorithm_config.Gamma_y = {1, ...
                                1 / (sqrt(max(eig(shared_config.G.Diff.' * diag(shared_config.G.weights) * shared_config.G.Diff))))};

    solver_config.stopping_criteria = shared_config.stopping_criteria;
    solver_config.before_iteration = shared_config.before_iteration;
    solver_config.after_iteration = shared_config.after_iteration;

    result = solve_pds(problem_config, algorithm_config, solver_config);
end