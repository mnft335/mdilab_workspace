function config = make_algorithm_config(V, E)
    config.Gamma_x = {0.1, 0.1};
    config.Gamma_y = {1 / 30 * config.Gamma_x{1}, 1 / 30 * config.Gamma_x{2}};
    config.x_init = {zeros(V, 1), zeros(E, 1)};
    config.y_init = {zeros(V, 1), zeros(E, 1)};
    config.stopping_criteria = @(obj) IterationLimit(20000).check();
end