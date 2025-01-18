%% ---- visualisation for labelled social network ----
clear

% run a random network under the nonlinear coevolutionary voter model
% (CNVM) and plot the final labelled graph

n = 20; % set number of nodes
m = 40; % set number of edges

% generate random adjacency matrix with n nodes and m edges
adj_matrix = G_fixed_edges(n, m);

% initialise parameters
p = 0.1;
q = 0.2;

% set the proportion of nodes that initially have opinion 1
initial_1 = 0.5;

% set the maximum number of steps in the CNVM before it terminates
max_step = 10;

% implement the CNVM
[adj_matrix_final, consensus_time, opinions_0, opinions_1] = coev_nonlinear_voter_model(adj_matrix, p, q, initial_1, max_step);

% plot the final social network (colours indicate opinions)
figure(1)
g1 = plot(graph(adj_matrix_final));
layout(g1, 'force');
g1.NodeLabel = arrayfun(@(x) sprintf('v_{%d}', x), 1:n, 'UniformOutput', false);
g1.NodeFontSize = 10;
highlight(g1, opinions_1, 'NodeColor', '#D25050', 'Marker', '^', 'MarkerSize', 6)
highlight(g1, opinions_0, 'NodeColor', '#3661AB', 'MarkerSize', 6)

% dummy plots for legend
hold on;
p1 = plot(nan, nan, '^', 'MarkerFaceColor', '#D25050', 'MarkerEdgeColor', '#D25050', 'MarkerSize', 6, 'DisplayName', 'Opinion 1');
p2 = plot(nan, nan, 'o', 'MarkerFaceColor', '#3661AB', 'MarkerEdgeColor', '#3661AB', 'MarkerSize', 6, 'DisplayName', 'Opinion 0');
hold off;

% add legend
legend([p1, p2], '\sigma_i = +1', '\sigma_i = -1', 'Location', 'bestoutside', 'FontSize', 12); % Adjust legend location
title('Initial Social Network for a Basic Voter Model', 'FontSize', 14);