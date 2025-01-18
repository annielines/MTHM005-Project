%% ---- investigating consensus time (as function of rho) ----
clear

N = 101; % set number of nodes
p = 0.5; % set probability of connecting each pair of nodes
s = 10; % set number of simulation repeats

% set values for rho
initial_1 = [0:0.05:1];

% calculate mean degree
mean_degree = (N-1)*p;

% loop over rho values
for j = 1:length(initial_1)

    % repeat simulation 's' times
    for i = 1:s

        % generate a random graph (approximately homogeneous)
        g = G_fixed_probability(N, p);

        % implement 'classic voter model' onto graph
        [~, consensus_time(i), ~] = classic_voter_model(g, initial_1(j));

    end

    % find average consensus time over 's' simulation repeats
    simulated_consensus_time(j) = sum(consensus_time) / s;

end

% expand values for rho
initial_1_expand = [0.01:0.01:0.99];

% evaluted expected consensus time using formula
expected_consensus_time = (-N).*((initial_1_expand .* log(initial_1_expand)) + ((1-initial_1_expand).*log(1-initial_1_expand)));

% plot expected and simulated consensus times
figure(1)
hold on
set(gca,'fontsize',14)
title('Consensus Time as a Function of \rho', 'FontSize', 18)
xlabel('Initial \rho', 'FontSize', 16)
ylabel('T(\rho)', 'FontSize', 16)
grid on; grid minor

% expected consensus time
plot1 = plot(initial_1_expand, expected_consensus_time, '-', 'Color', '#3661AB', 'LineWidth', 1.5);

% simulated consensus time (re-scaled by dividing by N)
plot2 = plot(initial_1, simulated_consensus_time/N, 'x', 'Color', '#D25050', 'LineWidth', 1.5);

l = legend([plot1, plot2], 'Expected', 'Simulated', 'FontSize', 12, 'Location','northwest');
dim = [0.1478 0.6968 0.09460 0.1132];
str = {['N = ', num2str(N)], ['s = ', num2str(s)]};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off

%% ---- investigating exit probability (as function of m) ----
clear

N = 101; % set number of nodes
p = 0.5; % set probability of connecting each pair of nodes
s = 400; % set number of simulation repeats

% set values for rho
initial_1 = [0:0.05:1];

% calculate mean degree
mean_degree = (N-1)*p;

% loop over rho values
for j = 1:length(initial_1)

    % count number of +1 consensuses reaches, over 's' simulations
    consensus_1_counter(j) = 0; % initialise counter

    % repeat simulation 's' times
    for i = 1:s

        % generate a random graph (approximately homogeneous)
        g = G_fixed_probability(N, p);

        % implement 'classic voter model' onto graph
        [opinions1, ~, magnetism] = classic_voter_model(g, initial_1(j));

        % save vector of magnetisms for each initial rho
        m(j) = magnetism(1);

        % find nodes with final opinion +1
        opinions_1 = find(opinions1 == 1);

        % if all nodes have final opinion +1 in the consensus state...
        % (i.e. if a +1 consensus is reached)
        if length(opinions_1) == N

            % ...then +1 to the counter
            consensus_1_counter(j) = consensus_1_counter(j) + 1;

        end

    end

    % find average exit probability over 's' simulation repeats
    simulated_exit_prob(j) = consensus_1_counter(j) / s;

end

% set vector of magnetisms to apply to formula
mag = [-1:0.1:1];

% evaluted expected exit probability using formula
expected_exit_prob = 0.5.*(mag + 1);

% plot expected and simulated exit probabilities
figure(1)
hold on
set(gca,'fontsize',14)
title('Exit Probability as a Function of m', 'FontSize', 18)
xlabel('Initial m', 'FontSize', 16)
ylabel('E(m)', 'FontSize', 16)
grid on; grid minor

% expected exit probability
plot1 = plot(mag, expected_exit_prob, '-', 'Color', '#3661AB', 'LineWidth', 1.5);

% simulated exit probability
plot2 = plot(m, simulated_exit_prob, 'x', 'Color', '#D25050', 'LineWidth', 1.5);

l1 = legend([plot1, plot2], 'Expected', 'Simulated', 'FontSize', 12, 'Location','northwest');
dim = [0.1478 0.6968 0.09460 0.1132];
str = {['N = ', num2str(N)], ['s = ', num2str(s)]};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off

%% ---- investigating exit probability (as function of rho) ----
clear

N = 101; % set number of nodes
p = 0.5; % set probability of connecting each pair of nodes
s = 10; % set number of simulation repeats

% set values for rho
initial_1 = [0:0.05:1];

% calculate mean degree
mean_degree = (N-1)*p;

% loop over rho values
for j = 1:length(initial_1)

    % count number of +1 consensuses, over 's' simulations
    consensus_1_counter(j) = 0; % initialise counter

    % repeat simulation 's' times
    for i = 1:s

        % generate a random graph (approximately homogeneous)
        g = G_fixed_probability(N, p);

        % implement 'classic voter model' onto graph
        [opinions1, ~, ~] = classic_voter_model(g, initial_1(j));

        % find nodes with final opinion +1
        opinions_1 = find(opinions1 == 1);

        % if all nodes have final opinion +1 in the consensus state...
        % (i.e. if a +1 consensus is reached)
        if length(opinions_1) == N

            % ...then +1 to the counter
            consensus_1_counter(j) = consensus_1_counter(j) + 1;

        end

    end

    % find average exit probability over 's' simulation repeats
    simulated_exit_prob(j) = consensus_1_counter(j) / s;

end

% evaluted expected exit probability using formula
expected_exit_prob = initial_1;

% plot expected and simulated exit probabilities
figure(1)
hold on
set(gca,'fontsize',14)
title('Exit Probability as a Function of \rho', 'FontSize', 18)
xlabel('Initial \rho', 'FontSize', 16)
ylabel('E(\rho)', 'FontSize', 16)
grid on; grid minor

% expected exit probability
plot1 = plot(initial_1, expected_exit_prob, '-', 'Color', '#3661AB', 'LineWidth', 1.5);

% simulated exit probability
plot2 = plot(initial_1, simulated_exit_prob, 'x', 'Color', '#D25050', 'LineWidth', 1.5);

l1 = legend([plot1, plot2], 'Expected', 'Simulated', 'FontSize', 12, 'Location','northwest');
dim = [0.1478 0.6968 0.09460 0.1132];
str = {['N = ', num2str(N)], ['s = ', num2str(s)]};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off
