function [xBest, fBest, gBest] = myPSO(fitnessfunc, xrange, particle)
%MYPSO Particle Swarm Optimization for CI

% This allows you to pass in other particle types in as an argument.
if nargin < 3
    % If no particle type is defined, then it will use the "BasicParticle"
    particle = @BasicParticle;
end

% Less that 30 seems to make it unstable. More that 500 seems to increase
% runtime way to much, but doesn't increase accuracy.
population = 200;

% Initialize the Swarm
for i = 1:population
    % Generate all the particles
    particles(i) = particle(fitnessfunc, ((xrange(:,2) - xrange(:,1)) .* rand(length(xrange(:,1)), 1) + xrange(:,1))');
end

% Save initial fitness
fitnesses = [particles.personalFitness];

% Setup initial conditions
fBest = Inf;
% xBest needs to be initialized to be an array, but zeros are probably not
% the best....
xBest = zeros(1, length(xrange));

iteration = 1;

% Let the swarm move around until they stop moving
while nnz([particles.velocity] > 1e-6) > (population * 0.85) || fBest == Inf
    % Get the best of the swarm
    [tfBest bestIndex] = min(fitnesses);
    txBest = particles(bestIndex).position;
    
    % Save the best ones
    if tfBest < fBest
        % fBest is the best global fitness ever seen
        fBest = tfBest;
        
        % xBest is the best global location ever seen
        xBest = txBest;
    end
    
    gBest(iteration) = fBest;
    iteration = iteration + 1;
    
    % Move each particle within the swarm
    for i = 1:population
        % Tried doing this without looping, and Matlab wasn't happy :(
        particles(i).move(xBest);
    end
    
    % Get new fitness for the swarm
    fitnesses = [particles.personalFitness];
end
end


