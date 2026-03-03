function grid_result_over_object = get_grid_result_over_object(grid_param_fixed, grid_run_schedule_over_object, arg)

    % Get the field name of the object to vary over
    field_name_to_vary = fieldnames(grid_run_schedule_over_object{1}.grid_param);

    % Preallocate a cell array to store the grid results
    grid_result_over_object = cell(1, numel(grid_run_schedule_over_object));

    for i = 1:numel(grid_run_schedule_over_object)

        % Get the grid result for the current object configuration
        grid_param = setfield(grid_param_fixed, field_name_to_vary{1}, grid_run_schedule_over_object{i}.grid_param);
        grid_result_over_object{i} = get_grid_result(grid_param, grid_run_schedule_over_object{i}.mode, arg);

    end

end