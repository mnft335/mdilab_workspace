% GENERATE_SBM Generates a Stochastic Block Model (SBM) graph
%
% Inputs:
%   cluster_sizes:            Vector containing the sizes of each cluster
%   connection_probabilities: Matrix of intra/inter-cluster connection probabilities
%   random_seed:              Seed for the random number stream
%
% Outputs:
%   adjacency_matrix:         Adjacency matrix of the SBM graph
%   cluster_labels:           Ground-truth cluster assignments for each node

function [adjacency_matrix, cluster_labels] = generate_sbm(cluster_sizes, connection_probabilities, random_seed)

    % Define the stream name for this generator internally
    random_stream_name = 'hoge_sbm';

    % Create a random stream using the provided seed and internal name
    random_stream = create_random_stream(random_seed, random_stream_name);

    % Compute the total number of clusters and nodes
    num_clusters = length(cluster_sizes);
    num_nodes = sum(cluster_sizes);

    % Assign a ground-truth cluster label to each node
    cluster_labels = zeros(num_nodes, 1);
    idx = 1;

    for k = 1:num_clusters

        cluster_labels(idx : idx + cluster_sizes(k) - 1) = k;
        idx = idx + cluster_sizes(k);

    end

    % Initialize the adjacency matrix
    adjacency_matrix = zeros(num_nodes, num_nodes);

    % Generate intra-cluster and inter-cluster edges based on probabilities
    for i = 1:num_clusters

        for j = i:num_clusters

            idx_i = find(cluster_labels == i);
            idx_j = find(cluster_labels == j);

            if i == j

                % Generate intra-cluster edges (upper triangular only to avoid directed edges)
                num_intra_nodes = length(idx_i);
                num_intra_edges = num_intra_nodes * (num_intra_nodes - 1) / 2;
                
                % Generate random numbers only for the strictly upper triangular part
                forward_edges = double(rand(random_stream, num_intra_edges, 1) < connection_probabilities(i, j));
                
                block_ij = zeros(num_intra_nodes, num_intra_nodes);
                mask = triu(true(num_intra_nodes, num_intra_nodes), 1);
                block_ij(mask) = forward_edges;
                block_ij = block_ij + block_ij';
                
                adjacency_matrix(idx_i, idx_i) = block_ij;

            else

                % Generate inter-cluster edges
                forward_edges = double(rand(random_stream, num_intra_nodes, num_inter_nodes) < connection_probabilities(i, j));
                adjacency_matrix(idx_i, idx_j) = forward_edges;
                adjacency_matrix(idx_j, idx_i) = forward_edges';

            end

        end

    end

end
