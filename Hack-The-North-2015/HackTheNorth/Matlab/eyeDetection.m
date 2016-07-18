function [imout] = eyeDetection(imin)
    if isempty(imin)
        imout = 0;
    end
    if ~isempty(imin)
        A = rgb2gray(imin);
        A = imadjust(A);
        B = edge(A);
        C = bwareaopen(B,10);
        imout = bwmorph(C,'dilate',2);
    end
end