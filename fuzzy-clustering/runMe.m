
clear;
iris = fopen('iris.data');
rawdata = textscan(iris, '%f,%f,%f,%f,Iris-%s');
fclose(iris);

data = cell2mat({rawdata{1}, rawdata{2}, rawdata{3}, rawdata{4}});

% for i = 1:100
    [U, V] = myFCM(data, 3, 1.7);
    maxes = zeros(1, size(U, 2));
    for m = 1:size(U, 2)
        [~, maxes(m)] = max(U(:, m));
    end
% end