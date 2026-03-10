% This method generates a Stochastic Block Model (SBM) graph
function [A, labels] = generate_sbm(cluster_sizes, connection_probabilities, random_seed)

    % Define the stream name for this generator internally
    random_stream_name = 'hoge_sbm';

    % Create a random stream using the provided seed and internal name
    random_stream = create_random_stream(random_seed, random_stream_name);

    % Compute the total number of clusters and nodes
    num_clusters = length(cluster_sizes);
    num_nodes = sum(cluster_sizes);

    % Assign a ground-truth cluster label to each node
    labels = zeros(num_nodes, 1);
    idx = 1;

    for k = 1:num_clusters
        labels(idx : idx + cluster_sizes(k) - 1) = k;
        idx = idx + cluster_sizes(k);
    end

    % Initialize the adjacency matrix
    A = zeros(num_nodes, num_nodes);

    % Generate intra-cluster and inter-cluster edges based on probabilities
    for i = 1:num_clusters
        for j = i:num_clusters

            idx_i = find(labels == i);
            idx_j = find(labels == j);

            if i == j

                % Generate intra-cluster edges (upper triangular to avoid directed edges)
                R = rand(random_stream, length(idx_i), length(idx_i));
                block_A = double(R < connection_probabilities(i, j));
                block_A = triu(block_A, 1);
                block_A = block_A + block_A';
                A(idx_i, idx_i) = block_A;

            else

                % Generate inter-cluster edges
                R = rand(random_stream, length(idx_i), length(idx_j));
                block_A = double(R < connection_probabilities(i, j));
                A(idx_i, idx_j) = block_A;
                A(idx_j, idx_i) = block_A';

            end

        end
    end

end
