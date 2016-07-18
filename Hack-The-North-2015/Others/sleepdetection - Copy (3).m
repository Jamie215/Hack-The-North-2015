clear all

% Create video input object
vid = videoinput('winvideo');

% Detector Objects
 faceDetector = vision.CascadeObjectDetector();
 faceDetector.MergeThreshold = 6;
 eyeDetector = vision.CascadeObjectDetector('LeftEye');
 eyeDetector.MergeThreshold = 18;

cam = webcam
figure,

for j = 1:50
    img = snapshot(cam);
    fbb = step(faceDetector, img); % x y width height
    fbbsize = size(fbb);
    
    if(fbbsize(1) > 0)
        ebb = step(eyeDetector, img);
        ebbsize = size(ebb);
        
        if(ebb ~= 0 & ~isempty(ebb))
            count = 1;
            C = zeros(2,4);
            for i = 1:ebbsize(1)
               if ((ebb(i,2) + ebb(i,4)/2) < (fbb(2) + fbb(4)/2)) & ( ebb(i,1) < fbb(1) + fbb(4) ) & (ebb(i,1) > fbb(1)) && (ebb(i,2) > fbb(2))
                   C(count,:) = ebb(i,:);
                   C(count,:) = [round(ebb(i,1) + ebb(i,3) * 0.1), round(ebb(i,2) + ebb(i,4) * 0.15), round(ebb(i,3) * 0.8), round(ebb(i,4) * 0.85)];
                   count = count + 1;
               end
            end
            fimg = imcrop(img, fbb(1,:));
            e1img = imcrop(img,C(1,:));
            e2img = imcrop(img,C(2,:));
            subplot(2,4,1), imshow(img);
            subplot(2,4,2), imshow(fimg);
            subplot(2,4,3), imshow(e1img);
            subplot(2,4,4), imshow(e2img);
            e1img1 = eyeDetection(e1img);
            e2img1 = eyeDetection(e2img);
            subplot(2,4,5), imshow(e1img1)
            subplot(2,4,6), imshow(e2img1)
            
%             A = rgb2gray(e1img);
%             A = imadjust(A);
%             subplot(2,4,5), imshow(A)
%             c = edge(A);
%             c = bwareaopen(c,8);
%             c = bwmorph(c,'dilate',2);
%             subplot(2,4,6), imshow(c)
%             A1 = rgb2gray(e2img);
%             A1 = imadjust(A1);
%             subplot(2,4,7), imshow(A1)
%             c1 = edge(A1);
%             c1 = bwareaopen(c1,8);
%             c1 = bwmorph(c1,'dilate',2);
%             subplot(2,4,8), imshow(c1)
            
%             c1size = size(c1);

            % finding distance
%             toppos = csize(1);
%             botpos = 0;
%             for k = 1:csize(1)
%                 for l = 1:csize(2)
%                     if c(k, l) == 1 & k < toppos
%                         toppos = k
%                     end
%                     if c(k, l) == 1 & k > botpos
%                         botpos = k
%                     end
%                 end
%             end
%             diff = botpos - toppos
%             
%             % finding distance
%             toppos1 = c1size(1);
%             botpos1 = 0;
%             for k = 1:c1size(1)
%                 for l = 1:c1size(2)
%                     if c1(k, l) == 1 & k < toppos1
%                         toppos1 = k
%                     end
%                     if c1(k, l) == 1 & k > botpos1
%                         botpos1 = k
%                     end
%                 end
%             end
%             diff1 = botpos1 - toppos1
            
            end
        end
    end

delete(vid)
delete(cam)


%%

% figure,
% subplot(2,2,1), imshow(e1img);
% A = rgb2gray(e1img);
% A = imadjust(A);
% % threshold = graythresh(A);
% % bw = im2bw(A, threshold);
% 
% % bw = bwareaopen(bw,10);
% % se = strel('disk',2);
% % bw = imclose(bw,se);
% % bw = imfill(bw,'holes');
% 
% subplot(2,2,2), imshow(A);
% 
% subplot(2,2,3), imshow(e2img);
% A1 = rgb2gray(e2img);
% A1 = imadjust(A1);
% % threshold1 = graythresh(A1);
% % bw1 = im2bw(A1, threshold1);
% subplot(2,2,4), imshow(A1);

% bw1 = bwareaopen(bw1,10);
% se1 = strel('disk',2);
% bw1 = imclose(bw1,se1);
% bw1 = imfill(bw1,'holes');

% figure,
% subplot(1,2,1), imhist(bw)
% subplot(1,2,2), imhist(bw1)

%%
% H1 = imhist(bw);
% H2 = imhist(bw1);
% % black percentage
% R1 = H1(1) / ( H1(1) + H1(2))
% R2 = H2(1) / ( H2(1) + H2(2))
% 
% %threshold of 35 - 40


%%
% Q = imread('white.png');
% % Q = imread('black.png');
% % Q = imread('half.png');
% Q1 = rgb2gray(Q);
% Q2 = graythresh(Q1);
% Q3 = im2bw(Q, Q2);
% 
% 
% X = imhist(Q3) % X = [ black white]
% % white percentage
% W = X(1) / X(2)

%%
%crop away upper quarter of image
% test = rgb2gray(e1img);
% test = imadjust(test);
% tsize = size(test)
% tbox = [0, (round(tsize(1) * 0.25)), tsize(2), round(tsize(1) * 0.75)];
% test1 = imcrop(test, tbox);
% figure, subplot(1,2,1), imshow(test), subplot(1,2,2), imshow(test1);

%%
figure, subplot(1,2,1), imshow(A)
c = edge(A);
c = bwareaopen(c,8);
c = bwmorph(c,'dilate',2);
subplot(1,2,1), imshow(c)

figure, subplot(1,2,1), imshow(A1)
c1 = edge(A1);
c1 = bwareaopen(c1,8);
c1 = bwmorph(c1,'dilate',2);
subplot(1,2,2), imshow(c1)

%%

% csize = size(c)
% 
% ccol = c(:,round(csize(2)/2));
% figure, subplot(1,2,1), imshow(c), subplot(1,2,2), imshow(ccol);
% 
% % finding distance
% first = 0;
% for k = 1:csize(1)
%     if ccol(k, 1) == 1 & first == 0
%         firstnum = k;
%         first = 1;
%     end
%     if ccol(k, 1) == 1 & first ~= 0
%         lastnum = k;
%     end
% end
% diff = lastnum - firstnum

csize = size(c)
% finding distance
            toppos = csize(1);
            botpos = 0;
            for k = 1:csize(1)
                for l = 1:csize(2)
                    if c(k, l) == 1 & k < toppos
                        toppos = k
                    end
                    if c(k, l) == 1 & k > botpos
                        botpos = k
                    end
                end
            end
            diff = botpos - toppos

% c1size = size(c1)
% 
% % c1col = c1(:,round(c1size(2)/2));
% % figure, subplot(1,2,1), imshow(c1), subplot(1,2,2), imshow(c1col);
% 
% % finding distance
% toppos = c1size(1);
% botpos = 0;
% for k = 1:c1size(1)
%     for l = 1:c1size(2)
%         if c1(k, l) == 1 & k < toppos
%             toppos = k
%         end
%         if c1(k, l) == 1 & k > botpos
%             botpos = k
%         end
%     end
% end
% diff = botpos - toppos

%%

centers = imfindcircles(A, 10)
centers = imfindcircles(A1, 10)