clear;

glr_config = struct();
shared_config = shared_config_factory(experiment_config);

glr_solved = solve_glr(shared_config, glr_config);
