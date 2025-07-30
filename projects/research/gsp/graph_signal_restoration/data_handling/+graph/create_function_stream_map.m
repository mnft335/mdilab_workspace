function function_stream_map = create_function_stream_map(master_seed, function_id_map)

    functions = keys(function_id_map);
    ids = values(function_id_map);

    streams = cellfun(@(z) RandStream("threefry", "Seed", master_seed + z), ids, "UniformOutput", false);

    function_stream_map = containers.Map(functions, streams);

end