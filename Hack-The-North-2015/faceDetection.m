function [fbbout] = faceDetection(fbbin)
    if isempty(fbbin)
        fbbout = 0;
    end
    if ~isempty(fbbin)
        fsize = size(fbbin);
        biggestarea = fbbin(1,3) * fbbin(1,4);
        if fsize(1) > 1
            for i = 1:fsize(1)
                if (fbbin(i,3) * fbbin(i,4) )> biggestarea
                    biggestarea = fbbin(i,3) * fbbin(i,4);
                    fbbout = fbbin(i,:);
                end
            end
        end
        if fsize(1) <= 1
           fbbout = fbbin; 
        end
    end
end