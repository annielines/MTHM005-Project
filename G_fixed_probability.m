function[adj_matrix] = G_fixed_probability(n, p)

% function generating a random graph of n nodes:
% takes all distinct pairs of nodes and places an edges between each pair
% with an independent probability p

% inputs:
% n = number of nodes
% p = independent probability of connecting each pair of nodes

% outputs:
% adj_matrix = adjacency matrix of generated network

% initialise adjacency matrix with (n x n) zero matrix
adj_matrix = zeros(n,n);

% find all distinct pairs of nodes
all_pairs = nchoosek(1:n, 2);

% loop over each distinct pair
for i = 1:length(all_pairs)

    % connect pair with probability p
    if rand < p

        % extract both individual nodes from current pair
        node_1 = all_pairs(i, 1);
        node_2 = all_pairs(i, 2);

        % connect pair (add a 1 in the adjacency matrix)
        adj_matrix(node_1, node_2) = 1;
        adj_matrix(node_2, node_1) = 1;  % ensure symmetry

    end

end

end