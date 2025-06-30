function result = solve_glr(shared_config, specific_config)

    import prox.*;
    prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, shared_config.b, shared_config.epsilon));
    prox_l2_conj = prox_conj(@(z, gamma) prox_l2(z, gamma, 1 / 2));

    problem_config.L = @(z) {shared_config.Phi(z{1}), ...
                             shared_config.G.Diff * z{1}};
    % problem_config.L = @(z) {shared_config.Phi(z{1}), ...
    %                          sqrt(shared_config.G.e) .* shared_config.G.U.' * z{1}};
    problem_config.Lt = @(z) {shared_config.Phit(z{1}) + shared_config.G.Diff.' * z{2}};
    % problem_config.Lt = @(z) {shared_config.Phit(z{1}) + shared_config.G.U * (sqrt(shared_config.G.e) .* z{2})};
    problem_config.grad_f = @(z) {zeros(size(z{1}))};
    problem_config.prox_g = @(z, gamma) {prox_box(z{1}, shared_config.lower, shared_config.upper)};
    problem_config.prox_h_conj = @(z, gamma) {prox_ball_l2_conj(z{1}, gamma{1}), ...
                                              prox_l2_conj(z{2}, gamma{2})};

    algorithm_config.x_init = {zeros(shared_config.G.N, 1)};
    algorithm_config.y_init = {zeros(shared_config.G.N, 1), ...
                               zeros(shared_config.G.Ne, 1)};
    algorithm_config.Gamma_x = {1 / (1 + sqrt(shared_config.G.lmax))};
    % algorithm_config.Gamma_x = {1 / (1 + shared_config.G.lmax)};
    algorithm_config.Gamma_y = {1, ...
                                1 / sqrt(shared_config.G.lmax)};
    % algorithm_config.Gamma_y = {1, ...
    %                             1 / shared_config.G.lmax};

    solver_config.stopping_criteria = shared_config.stopping_criteria;
    solver_config.before_iteration = shared_config.before_iteration;
    solver_config.after_iteration = shared_config.after_iteration;

    result = solve_pds(problem_config, algorithm_config, solver_config);
end