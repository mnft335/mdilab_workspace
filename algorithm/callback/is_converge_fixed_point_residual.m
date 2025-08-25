function is_converge = is_converge_fixed_point_residual(config, state, tolerance)

    is_converge = state.residual < tolerance;

end