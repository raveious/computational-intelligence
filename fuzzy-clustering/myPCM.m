function [U,V] = myPCM(X,c,m,nu)
% inputs:
% X - [N x d] array of feature vectors
% c - number of clusters
% m - fuzzifier
% nu - scale parameter
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

% I couldn't figure this one out...
