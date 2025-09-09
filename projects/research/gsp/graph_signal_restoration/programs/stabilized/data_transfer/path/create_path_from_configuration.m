function path_collection = create_path_from_configuration(configuration_name)

    % Replace a decimal point with "p" (point)
    configuration_name = cellfun(@(z) replace(z, '.', 'p'), configuration_name, 'UniformOutput', false);

    % Replace a minus sign with "m" (minus)
    configuration_name = cellfun(@(z) replace(z, '-', 'm'), configuration_name, 'UniformOutput', false);

    % Create the path by concatenating the field names and values
    path_collection = fullfile(configuration_name{:});

end