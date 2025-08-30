function state = compute_pds_residual(config, state)

    % Compute the fixed-point residual
    if ~isfield(state, "residual"), state.residual = Inf; end

    previous_residual = state.residual;

    primal_difference = cellfun(@(z1, z2) z1 - z2, state.x, state.x_prev, "UniformOutput", false);
    dual_difference = cellfun(@(z1, z2) z1 - z2, state.y, state.y_prev, "UniformOutput", false);

    primal_quadratic_form = cellfun(@(z1, z2) sum(z1.^2) / z2, primal_difference, config.gamma_x);
    dual_quadratic_form = cellfun(@(z1, z2) sum(z1.^2) / z2, dual_difference, config.gamma_y);
    primal_dual_bilinear_form = cellfun(@(z1, z2) - 2 * dot(z1, z2), primal_difference, config.Lt(dual_difference));
    state.residual = sum([primal_quadratic_form, dual_quadratic_form, primal_dual_bilinear_form]);

    if state.residual > previous_residual, disp("The fixed-point residual is not monotonically nonincreasing: Gap = " + num2str(state.residual - previous_residual)); end

end