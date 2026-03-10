% This method generates a Barabasi-Albert (BA) graph
function A = generate_ba(num_nodes, num_initial_nodes, num_edges_to_add, random_seed)

    % Input error handling
    if num_edges_to_add > num_initial_nodes, error('num_edges_to_add must be less than or equal to num_initial_nodes.'); end

    % Define the stream name for this generator internally
    random_stream_name = 'hoge_ba';

    % Create a random stream using the provided seed and internal name
    random_stream = create_random_stream(random_seed, random_stream_name);

    % Initialize the graph to be a complete graph
    A = zeros(num_nodes, num_nodes);
    A(1:num_initial_nodes, 1:num_initial_nodes) = ones(num_initial_nodes, num_initial_nodes) - eye(num_initial_nodes);

    % Initialize the degrees of the nodes   
    degrees = zeros(1, num_nodes);
    degrees(1:num_initial_nodes) = sum(A(1:num_initial_nodes, 1:num_initial_nodes));

    % Add edges to the graph
    for i = num_initial_nodes + 1 : num_nodes

        % Calculate the probability of adding an edge to each node
        current_degrees = degrees(1:i-1);
        probability = current_degrees / sum(current_degrees);

        % Select 'num_edges_to_add' nodes to connect to the new node
        targets = randsample(random_stream, 1:i-1, num_edges_to_add, false, probability);

        % Add edges to the graph
        A(i, targets) = 1;
        A(targets, i) = 1;

        % Update the degrees of the nodes
        degrees(targets) = degrees(targets) + 1;
        degrees(i) = num_edges_to_add;

    end

end