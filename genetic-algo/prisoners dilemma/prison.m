function [p1, p2] = prison(you, opponent)
%PRISON Prisoners Dilemma with 2 players

memory = 3;
population = 10;
inmates = [];

% Initial population
for i = 1:population
    inmates(i, :) = makeInmate(memory, you, opponent);
end

% Evaluate population
for i = 1:population
    [p1(i), p2(i)] = sentence(inmates(i,:), memory);
end

% Rank population
[rankedFitness rankedIndecies] = sortrows(p1);
rankedGenes = inmates(rankedIndecies,:);

end

function [newInmate] = makeInmate(memory, p1F, p2F)

    bits = 0;
    newInmate= [];
    current = 0;
    
    for n = 1:memory
        if current == 0
            newInmate = fuseDecision(p1F(), p2F());
            current = 1;
            bits = 1;
        else
            for s = 1:((4^(n-1))/4)
                for i = 1:4
                    bits = bits + 1;
                    newInmate(bits) = fuseDecision(p1F(newInmate(current)), p2F(newInmate(current)));
                end
                current = current + 1;
            end
        end
    end
end
