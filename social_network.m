%% ---- social network visualisation ----
clear

% run a random network under the nonlinear coevolutionary voter model
% (CNVM) and plot the final graph

n = 80; % set number of nodes
m = 140; % set number of edges

% generate random adjacency matrix with n nodes and m edges
adj_matrix = G_fixed_edges(n, m);

% initialise parameters
p = 0.1;
q = 0.6;

% set the proportion of nodes that initially have opinion 1
initial_1 = 0.5;

% set the maximum number of steps in the CNVM before it terminates
max_step = 100000;

% implement the CNVM
[adj_matrix_final, consensus_time, opinions_0, opinions_1] = coev_nonlinear_voter_model(adj_matrix, p, q, initial_1, max_step);

% plot the final social network (colours indicate opinions)
figure(1)
g1 = plot(graph(adj_matrix_final));
layout(g1, 'force');
g1.NodeLabel = []; % turn off node labels
highlight(g1, opinions_1, 'NodeColor', '#D25050', 'Marker', '^', 'MarkerSize', 6)
highlight(g1, opinions_0, 'NodeColor', '#3661AB', 'MarkerSize', 6)

% dummy plots for legend
hold on;
p1 = plot(nan, nan, '^', 'MarkerFaceColor', '#D25050', 'MarkerEdgeColor', '#D25050', 'MarkerSize', 6, 'DisplayName', 'Opinion 1');
p2 = plot(nan, nan, 'o', 'MarkerFaceColor', '#3661AB', 'MarkerEdgeColor', '#3661AB', 'MarkerSize', 6, 'DisplayName', 'Opinion 0');
hold off;

% add legend
legend([p1, p2], 'Opinion A', 'Opinion B', 'Location', 'bestoutside', 'FontSize', 10); % Adjust legend location
title('Social Network with Binary Opinions', 'FontSize', 14);