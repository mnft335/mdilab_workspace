shared_config = shared_config_factory();
specific_config = struct();

state_solved = solve_glr(shared_config, specific_config);
show_result(state_solved);