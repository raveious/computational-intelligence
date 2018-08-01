function [U,V,S] = myGKFCM(X,c,m,p)
% inputs:
% X - [N x d] array of feature vectors
% c - number of clusters
% m - fuzzifier
% p - [c x 1] scale parameter
% outputs:
% U - [c x N] partition matrix
% V - [c x d] cluster center vectors
% S - [d x d x c] covariance matrices

[N, d] = size(X);
U = zeros(c, N);
S = zeros(d, d, c);

% Cluster Centers at origin
% V = zeros(c, d);

% Cluster Centers are random points between data values
% V = 

% Cluster Centers are random data points
V = datasample(X, c,'Replace',false);

% I couldn't figure this one out...
