% This function generates a Barabasi-Albert (BA) graph.
% Since the BA model constructs the graph by connecting new nodes to an initially connected 
% complete graph (num_initial_nodes >= 1), the resulting graph is inherently connected.
% This wrapper is provided to maintain a consistent interface with other generate_connected_* functions.
%
% Inputs:
%   num_nodes:         Total number of nodes in the graph
%   num_initial_nodes: Number of nodes in the initial complete graph
%   num_edges_to_add:  Number of edges to attach from a new node to existing nodes
%   random_seed:       Seed for the random number generator
%
% Outputs:
%   A:                 Adjacency matrix of the connected BA graph

function A = generate_connected_ba(num_nodes, num_initial_nodes, num_edges_to_add, random_seed)
    
    current_seed = random_seed;
    is_connected = false;
    
    while ~is_connected
        % Generate the BA graph
        A = generate_ba(num_nodes, num_initial_nodes, num_edges_to_add, current_seed);
        
        % Check connectivity (this should almost always pass, but included for complete safety)
        G = graph(A);
        bins = conncomp(G);
        
        if max(bins) == 1
            is_connected = true;
        else
            current_seed = current_seed + 1;
        end
    end
end
