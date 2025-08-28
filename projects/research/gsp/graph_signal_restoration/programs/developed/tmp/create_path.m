function path = create_path(configuration_name)

    % Replace a decimal point with "p" (point)
    configuration_name = replace([configuration_name{:}], '.', 'p');

    % Create the path by concatenating the field names and values
    path = fullfile(configuration_name{:});

end