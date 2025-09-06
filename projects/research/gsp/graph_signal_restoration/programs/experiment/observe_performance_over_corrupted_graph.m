function observe_performance_over_corrupted_graph( arg)

    % Get the result for non-corrupted graph as a baseline
    param = setfield(param_fixed, {"corrupted_graph", "type"}, "no_corruption");
    result_no_corruption = get_result(param, arg);

    % Compute NMSE for the baseline
    baselines(1) = compute_nmse_from_result(result_no_corruption);

    % Get the result for homogeneous corrupted graph as another baseline
    param = setfield(param_fixed, {"corrupted_graph", "type"}, "homogeneous");
    result_homogeneous = get_result(param, arg);

    % Compute NMSE for the homogeneous corrupted graph
    baselines(2) = compute_nmse_from_result(result_homogeneous);

    % Get the grid results over the corrupted graph
    grid_result_over_corrupted_graph = get_grid_result_over_object(param_fixed, grid_run_schedule_over_corrupted_graph, arg);

    % Compute NMSE for each corrupted graph configuration
    nmse_over_corrupted_graph = cellfun(@(grid_result) arrayfun(@compute_nmse_from_result, grid_result.result), grid_result_over_corrupted_graph, 'UniformOutput', false);

    % Average the NMSEs over each grid
    performance = cellfun(@(z) mean(z, "all"), nmse_over_corrupted_graph);

    % Plot the performance over corrupted graph configurations
    plot_performance(baselines, performance);

end