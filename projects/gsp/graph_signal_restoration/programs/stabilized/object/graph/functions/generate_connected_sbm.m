% This function generates a Stochastic Block Model (SBM) graph that is guaranteed to be connected.
% It uses a rejection sampling approach: if the generated graph is not connected,
% it increments the random_seed deterministically and tries again.
%
% Inputs:
%   cluster_sizes:            Vector containing the number of nodes in each cluster
%   connection_probabilities: Matrix of connection probabilities between/within clusters
%   random_seed:              Seed for the random number generator
%
% Outputs:
%   A:                        Adjacency matrix of the connected SBM graph
%   labels:                   Vector of ground-truth cluster labels for each node

function [A, labels] = generate_connected_sbm(cluster_sizes, connection_probabilities, random_seed)
    
    current_seed = random_seed;
    is_connected = false;
    
    while ~is_connected
        % Generate the SBM using the underlying generator
        [A, labels] = generate_sbm(cluster_sizes, connection_probabilities, current_seed);
        
        % Check connectivity using MATLAB's graph and conncomp functions
        G = graph(A);
        bins = conncomp(G);
        
        if max(bins) == 1
            % The graph is connected (all nodes belong to a single connected component)
            is_connected = true;
        else
            % Reject and increment seed for deterministic retry
            current_seed = current_seed + 1;
        end
    end
end
