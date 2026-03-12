% This function generates a Random Geometric Graph (RGG) that is guaranteed to be connected.
% It uses a rejection sampling approach: if the generated graph is not connected,
% it increments the random_seed deterministically and tries again.
%
% Inputs:
%   num_nodes:          Number of nodes in the graph
%   distance_threshold: Threshold distance to connect two nodes
%   random_seed:        Seed for the random number generator
%
% Outputs:
%   A:                  Adjacency matrix of the connected RGG
%   node_coordinates:   Spatial coordinates of the nodes

function [A, node_coordinates] = generate_connected_rgg(num_nodes, distance_threshold, random_seed)
    
    current_seed = random_seed;
    is_connected = false;
    
    while ~is_connected
        % Generate the RGG using the underlying generator
        [A, node_coordinates] = generate_rgg(num_nodes, distance_threshold, current_seed);
        
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
