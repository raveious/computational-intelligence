function [p1,p2] = sentence(x, memory)
%SENTENCE Determines the length of the sentence for the two players

last_block = length(x) - (4^(memory-1)) + 1;

% Count how many of the different options are actually being used.
states = accumarray(x(last_block:end)',1);

% Fix the issue of not all the options being present.
if length(states) < 4
    % Just pad the rest of the array with zeros.
    states(4) = 0;
end

if ~iscolumn(states)
    states = states';
end

% Calculate the sentence lengths from the values in the project brief.
p1 = mean(states .* [3;0;5;2]);
p2 = mean(states .* [3;5;0;2]);
end

% function [p1,p2] = sentence(x)
% %SENTENCE Determines the length of the sentence for the two players
% 
% stage = 1;
% for i = 2:4:length(x)
%     
%     % Count how many of the different options are actually being used.
%     temp = accumarray(x(i:i + 3)',1);
% 
%     % Fix the issue of not all the options being present.
%     if length(temp) < 4
%         % Just pad the rest of the array with zeros.
%         temp(4) = 0;
%     end
%     
%     states(stage, :) = temp';
%     stage = stage + 1;
% end
% 
% % Calculate the sentence lengths from the values in the project brief.
% p1 = sum(states' .* [3;0;5;2]);
% p2 = sum(states' .* [3;5;0;2]);
% end
