clear;

rng(0);

shared_config = shared_config_factory();
glr_config = struct();
gtv_config = struct();
proposal_config.alpha = 0.5;

% glr_solved = solve_glr(shared_config, glr_config);
% gtv_solved = solve_gtv(shared_config, gtv_config);
proposal_solved = solve_proposal(shared_config, proposal_config);