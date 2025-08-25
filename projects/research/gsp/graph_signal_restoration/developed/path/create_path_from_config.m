function path = create_path_from_config(config)

    % Get configuration parameters, excluding the configuration name
    config_params = setdiff(fieldnames(config), "config_name");

    % Set field names with the configuration name at the top and the configuration parameters in ascending order for consistent naming
    fields = {"config_name", sort(config_params)};

    % Get values corresponding to field names
    values = cellfun(@(field) config.(field), fields, 'UniformOutput', false);

    % Convert numeric values to strings by replacing a decimal point with an underscore
    values = cellfun(@(z) strrep(string(z), '.', '_'), values, 'UniformOutput', false);

    % Create the path by concatenating the field names and values
    paired_field_value = cellfun(@(field, value) field + "=" + value, field, values, 'UniformOutput', false);
    path = fullfile(paired_field_value{:});

end