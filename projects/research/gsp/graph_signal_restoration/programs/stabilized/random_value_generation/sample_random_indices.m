function result = sample_random_indices(stream, num_indices, num_sampled_indices)

    % Sample "num_sampled_indices" indices from the range 1:num_indices
    result = randperm(stream, num_indices, num_sampled_indices);

end