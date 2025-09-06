function param_template = create_param_template(param, parameter_name)

    % Empty the parameter ranges
    for i = 1:numel(parameter_name)

        param = setfield(param, parameter_name{i}{:}, []);

    end

    param_template = param;

end