function [isopen] = openclose(imin, threshold)
    if isempty(imin)
        imout = 0;
    end
    if ~isempty(imin)
        imsize = size(imin);
        threshold = round(threshold * imsize(2));
    %   finding distance
        toppos = imsize(1);
        botpos = 0;
        for i = 1:imsize(1)
            for j = 1:imsize(2)
                if imin(i, j) == 1 & i < toppos;
                    toppos = i;
                end
                if imin(i, j) == 1 & i > botpos;
                    botpos = i;
                end
            end
        end

        diff = botpos - toppos;

        if diff <= threshold
            isopen = 1; % close
%             isopen = [1, diff, botpos, toppos];
        end
        if diff > threshold
            isopen = 0; % open
%             isopen = [0, diff, botpos, toppos];
        end
    end
end