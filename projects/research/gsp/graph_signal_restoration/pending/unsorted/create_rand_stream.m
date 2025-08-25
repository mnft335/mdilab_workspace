function stream = create_rand_stream(master_seed, id)

    stream = RandStream("threefry", "seed", master_seed + id);

end