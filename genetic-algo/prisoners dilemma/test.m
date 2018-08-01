clear

r = @(y)randi([0 1]);
testify = @(y)ones();
silent = @(y)zeros();

[p1 p2] = prison(r,r);

function [output] = titTat(h)
    if nargin == 0
        output = randi([0 1]);
    else
%         you = h > 2;
        [~, output] = splitDecision(h);
    end
end
