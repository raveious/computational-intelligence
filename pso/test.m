clear
clf

data = [];
rounds = 100;

% Set which function to test, with ranges
% func = @ackley; xrange = [-32.768*ones(3,1) 32.768*ones(3,1)];
% func = @branins; xrange = [-5*ones(5,1) 10*ones(5,1)];
% func = @dejong; xrange = [-5.12*ones(10,1) 5.12*ones(10,1)];
% func = @rosenbrock; xrange = [-5*ones(5,1) 10*ones(5,1)];
% func = @rastrigin; xrange = [-5.12*ones(4,1) 5.12*ones(4,1)];
func = @sumofpowers; xrange = [-ones(5,1) ones(5,1)];

% Collect all the differet test runs
for i = 1:rounds
    [x f] = myPSO(func, xrange);

    data(i, :) = [f x];
end

% Calculate the mean and std
m = mean(data(:, 1));
s = std(data(:, 1));

% Sort the data for the graph
data = sortrows(data, 1);
semilogy([1:rounds], data(:, 1));

% Make the pretty graph
title(strcat(num2str(rounds), " rounds of ", regexprep(func2str(func),'(\<[a-z])','${upper($1)}'), " benchmark"));
xlabel('Rank');
ylabel('Fitness');

% Grab the best and worst runs
best = data(1, 2:end);
worst = data(rounds, 2:end);
