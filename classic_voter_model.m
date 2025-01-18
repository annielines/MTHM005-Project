function[opinions, consensus_time, magnetism] = classic_voter_model(adj_matrix, initial_1)

% function for the basic voter model (binary discrete opinions):
% a node is selected at random, and adopts the opinion of random neighbour

% here, indicate different opinion states with either 1 or 0

% inputs:
% adj_initial = adjacency matrix for initial social network
% 1_initial = initial proportion of nodes with opinion 1

% outputs:
% opinions = vector of opinions (ith element is opinion of ith node)
% consensus_time = number of update steps taken to reach consensus
% magentism = vector of magnetism at each update step

% find number of nodes in social network
N = length(adj_matrix);

% calculate the desired number of nodes to be assigned opinion 1
num_ones = round(initial_1 * N);

% the rest of the nodes will have opinion 0
num_zeros = N - num_ones;

% create a vector containing 'num_ones' 1s and 'num_zeros' 0s
opinions = [ones(1, num_ones), zeros(1, num_zeros)];

% shuffle the vector to randomise opinion assignement
opinions = opinions(randperm(N));

% find the nodes that are initially assigned each opinion
opinions_0 = find(opinions == 0); % opinion 0
opinions_1 = find(opinions == 1); % opinion 1

% calculate initial magnetisation
magnetism(1) = (1/N) * (length(opinions_1) - length(opinions_0));

% initialise counter tracking time to reach consensus
consensus_time = 0;

% initialise opinion difference matrix (*)
D = abs(opinions - transpose(opinions));

% multiply the adjacency matrix with D, element-wise (**)
conflicting_edges = D.*adj_matrix;

% continue going until a consensus has been reached
while sum(sum(conflicting_edges)) ~= 0

    % select a node at random
    node_i = randi(N);

    % ensure this node is connected to at least one other node
    while sum(adj_matrix(node_i, :)) == 0
        node_i = randi(N);
    end

    % find all neighbouring nodes
    neighbouring_nodes = find(adj_matrix(node_i, :) == 1);

    % select a random neighbouring node
    j = randi([1 length(neighbouring_nodes)]);
    node_j = neighbouring_nodes(j);

    % change opinion of node to match neighbour's
    opinions(node_i) = opinions(node_j);

    % update matrices
    D = abs(opinions - transpose(opinions));
    conflicting_edges = D.*adj_matrix;

    % update counter
    consensus_time = consensus_time + 1;

    % find the nodes that now have each opinion
    opinions_0 = find(opinions == 0); % opinion 0
    opinions_1 = find(opinions == 1); % opinion 1

    % calculate magnetism
    magnetism(consensus_time + 1) = (1/N) * (length(opinions_1) - length(opinions_0));

end

% notes:

% (*) (i,j)th element is 1 if node i and node j have different opinion, else is 0

% (**) only elements that are 1s in both adjacency matrix (i.e. connected) and
% in D (i.e. different opinions) are 1s in this product

end