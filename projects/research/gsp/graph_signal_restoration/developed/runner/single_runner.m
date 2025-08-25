function result = single_runner(param)

    % 
    path_result = factory_path_result(param)

    if exist(path_result)

        load(path_result);
        return;

    end

    data = factory_data();
    config_glr = factory_config_glr(data.corrupted_graph, data.true_signal, data.observation_model);
    result = glr_solver(config_glr);
    save(fullfile(path_result, "result.mat"), "result");

end