function random_stream = get_random_stream(random_seed, random_stream_name)

    % Get the name-ID map for random streams
    random_stream_ids = get_random_stream_ids();

    % Get the ID for the specified random stream name
    random_stream_id = random_stream_ids(random_stream_name);

    % Create a random stream specified by the "name_random_stream" with the given random seed
    random_stream = RandStream("Threefry", "Seed", random_seed + random_stream_id);

end 