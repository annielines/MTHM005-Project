function[adj_matrix] = G_fixed_edges(n, m)

% function generating a random graph of n nodes and m edges:
% chooses m distinct pairs of nodes, and places m edges among them

% inputs:
% n = number of nodes
% m = number of edges

% outputs:
% adj_matrix = adjacency matrix of generated network

% initialise adjacency matrix with (n x n) zero matrix
adj_matrix = zeros(n);

% choose m distinct pairs of nodes
for i = 1:m

    % choose first node of the ith pair at random
    node_1 = randi(n);

    % initially set second node of ith pair as being same as the first node
    node_2 = node_1;

    % re-choose second node of ith pair at random, until it is distinct
    % and not already connected to the first node
    while (node_2 == node_1) || (adj_matrix(node_1, node_2) == 1)
        node_2 = randi(n);
    end

    % connect the pair (add a 1 in the adjacency matrix)
    adj_matrix(node_1, node_2) = 1;
    adj_matrix(node_2, node_1) = 1; % ensure symmetric

end

end