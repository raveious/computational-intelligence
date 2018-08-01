function [fxbest,xbest] = myGA(funchandle, xrange)

% Why? Why not.
population = 150;

xbest = [];
newPop = [];

% Initialize with randomly distributed values
for l = 1:length(xrange)
    % This is stil 2-dimensional.... Is that ok?
    % Each column is representing a "dimension" within the defined bounds
    xbest(:,l) = -(xrange(l) / 2) + (xrange(l) * rand(1,population));
end

% Initial evaluation of the population
prevFxBest = 0;
fxbest = funchandle(xbest);

% Loop until the population doesnt seem to move anymore
while any((min(fxbest) - prevFxBest) > 1e-6)
    % Crossover probability
    % \todo Make this a dynamic values based on how adventurous the pop. is
    crossOverChance = 0.7;
    
    % Mutation probability
    % \todo Make this a dynamic values based on how adventurous the pop. is
    mutationChance = 0.001;
    
    % Normalize the fitness of the population
    fxInv = max(fxbest) - fxbest;
    normalizedFx = fxInv ./ sum(fxInv);
    cumNormFx = cumsum(normalizedFx);
    
    % Determine selection values for new population
    selectors = rand(1, population);
    crossOvers = rand(1, population) < crossOverChance;
    mutations = rand(1, population) < mutationChance;
    
    % Select reproduce population from existing population
    for q = 1:population
        f = find(cumNormFx > selectors(q), 1);
        
        % Copy new population
        newPop(q, :) = xbest(f, :);
        
        % Only need to do conversion from phenotypes to genotypes and back
        % IFF we do cross over and/or mutation so save processing time
        if (crossOvers(q) && mod(q, 2) == 0) || mutations(q)
            for x = 1:length(newPop(q, :))
                % Convert phenotypes to genotypes for processing
                temp = float2bin(newPop(q, x));
                
                % Crossover only on the even members with the odd members
                if crossOvers(q) && mod(q, 2) == 0
                    oddTemp = float2bin(newPop(q-1, x));
                    
                    b = randi([2, length(temp)]);
                    
                    evenFront = temp(1 : b-1);
                    evenBack = temp(b : end);
                    
                    oddFront = oddTemp(1: b-1);
                    oddBack = oddTemp(b : end);
                    
                    temp = strcat(evenFront, oddBack);
                    oddTemp = strcat(oddFront, evenBack);
                    
                    newPop(q-1, x) = bin2float(oddTemp);
                end
                
                % mutation within the population
                if mutations(q)
                    b = randi([1, length(temp)]);
                    temp(b) = num2str(~str2double(temp(b)));
                end
                
                % Convert genotypes to phenotypes
                newPop(q, x) = bin2float(temp);
            end
        end
    end
    
    % Save previous population state
    prevFxBest = min(fxbest);
    
    % Re-evaluate populations fitness
    xbest = newPop;
    fxbest = funchandle(xbest);
end

fxbest = min(fxbest);
