clear
clf

% Set which function to test, with ranges
% func = @ackley; xrange = [-32.768*ones(3,1) 32.768*ones(3,1)];
% func = @branins; xrange = [-5*ones(5,1) 10*ones(5,1)];
% func = @dejong; xrange = [-5.12*ones(10,1) 5.12*ones(10,1)];
% func = @rosenbrock; xrange = [-5*ones(5,1) 10*ones(5,1)];
% func = @rastrigin; xrange = [-5.12*ones(4,1) 5.12*ones(4,1)];
func = @sumofpowers; xrange = [-ones(5,1) ones(5,1)];

% Test both versions of the BasicParticle type (Basic vs. Altered)
[x1 f1 g1] = myPSO(func, xrange);
[x2 f2 g2] = myPSO(func, xrange, @AlteredBasicParticle);

% Make a pretty graphs
% semilogy([1:length(g1)], g1);
semilogy([1:length(g1)], g1, [1:length(g2)], g2);
title(strcat("Global fitness of swarm during ", regexprep(func2str(func),'(\<[a-z])','${upper($1)}'), " benchmark"));
xlabel('Iteration');
ylabel('Fitness');
legend('Original','Optimized');