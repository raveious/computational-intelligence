function [U,V] = myFCM(X,c,m)
% inputs:
% X - [N x d] array of feature vectors
% c - number of clusters
% m - fuzzifier
% outputs:
% U - [c x N] partition matrix
% V - [c x d] cluster center vectors

[N, d] = size(X);
U = zeros(c, N);

% Cluster Centers at origin
% V = zeros(c, d);

% Cluster Centers are random points between data values
% V = 

% Cluster Centers are random data points
V = datasample(X, c,'Replace',false);

prev_V = zeros(c, d);
threshold = 0.1;
change = threshold + 1;

while change > threshold
    for k = 1:N
        for i = 1:c
            if sqrt(sum((X(k,:) - V(i, :)).^2)) == 0
                % 8.3b
                
            else
                % 8.3a
                den = 0;
                for j = 1:c
                    den = den + sqrt(sum((X(k,:) - V(j, :)).^2));
                end
                U(i, k) = (sqrt(sum((X(k,:) - V(i, :)).^2))^(-2/(m-1))) / (den)^(-2/(m-1));
            end
        end
    end
    
    % 8.4
    top = 0;
    bot = 0;
    for i = 1:c
        top = top + (U(:, i) .^ m * X(i, :));
        bot = bot + (U(:, i) .^ m);
    end
    V = top./bot;
    
    change = 0;
    for i = 1:c
        change = change + norm(V - prev_V);
    end
    prev_V = V;
end