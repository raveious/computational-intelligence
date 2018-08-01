function [p1, p2] = splitDecision(h)
    p1 = h > 2;
    p2 = mod(h, 2) == 0;
end