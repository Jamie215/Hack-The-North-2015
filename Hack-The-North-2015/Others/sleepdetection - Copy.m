clear all

% Create video input object
vid = videoinput('winvideo');

% Detector Objects
 faceDetector = vision.CascadeObjectDetector();
 faceDetector.MergeThreshold = 5;
 eyeDetector = vision.CascadeObjectDetector('LeftEye');
 eyeDetector.MergeThreshold = 18;

cam = webcam
figure,

for j = 1:10
    img = snapshot(cam);
%     subplot(1,2,1), imshow(img)
    fbb = step(faceDetector, img); % x y width height
    fbbsize = size(fbb);
    
    if(fbbsize(1) > 0)
        ebb = step(eyeDetector, img);
        ebbsize = size(ebb);
        count = 1;
        C = zeros(2,4);
        for i = 1:ebbsize(1)
           if ((ebb(i,2) + ebb(i,4)/2) < (fbb(2) + fbb(4)/2)) & ( ebb(i,1) < fbb(1) + fbb(4) ) & (ebb(i,1) > fbb(1)) && (ebb(i,2) > fbb(2))
               C(count,:) = ebb(i,:);
               count = count + 1;
           end
        end
        fimg = imcrop(img, fbb(1,:));
        e1img = imcrop(img,C(1,:));
        e2img = imcrop(img,C(2,:));
        subplot(1,4,1), imshow(img);
        subplot(1,4,2), imshow(fimg);
        subplot(1,4,3), imshow(e1img);
        subplot(1,4,4), imshow(e2img);
    end
%     eyenum = size(ebb);
    
%     out = insertObjectAnnotation(img,'rectangle', fbb, 'face');
%     out = insertObjectAnnotation(img,'rectangle',ebb, 'eye');
%     imshow(out)
%     subplot(1,2,2), videoOut;

    %imshow(img);
end

delete(vid)
delete(cam)

%%
% figure,
% subplot(1,4,1), imshow(img)
% A = imcrop(img,fbb(1,:))
% subplot(1,4,2), imshow(A)
% figure,
% imshow(img)
% A = imcrop(img,fbb)
% subplot(1,4,1), imshow(A)
% B = imcrop(img,ebb(1,:))
% subplot(1,4,2), imshow(B)
% C = imcrop(img,ebb(2,:))
% subplot(1,4,3), imshow(C)
% D = imcrop(img,ebb(3,:))
% subplot(1,4,4), imshow(D)

% A = [200,100,200,100];
% B = imcrop(img,A);
% figure, imshow(B);

%%
% count = 1;
% C = zeros(2,4);
% for i = 1:ebbsize(1)
%    if ((ebb(i,2) + ebb(i,4)/2) < (fbb(2) + fbb(4)/2)) & ( ebb(i,1) < fbb(1) + fbb(4) )
%        C(count,:) = ebb(i,:);
%        count = count + 1;
%    end
% end

%%

figure,
subplot(2,2,1), imshow(e1img);
A = rgb2gray(e1img);
threshold = graythresh(A);
bw = im2bw(A, threshold);

bw = bwareaopen(bw,10);
se = strel('disk',2);
bw = imclose(bw,se);
bw = imfill(bw,'holes');

subplot(2,2,2), imshow(bw);

subplot(2,2,3), imshow(e2img);
A1 = rgb2gray(e2img);
threshold1 = graythresh(A1);
bw1 = im2bw(A1, threshold1);
subplot(2,2,4), imshow(bw1);

bw1 = bwareaopen(bw1,10);
se1 = strel('disk',2);
bw1 = imclose(bw1,se1);
bw1 = imfill(bw1,'holes');

figure,
subplot(1,2,1), imhist(bw)
subplot(1,2,2), imhist(bw1)

H1 = imhist(bw);
H2 = imhist(bw1);
% black percentage
R1 = H1(1) / ( H1(1) + H1(2))
R2 = H2(1) / ( H2(1) + H2(2))


%%
Q = imread('white.png');
% Q = imread('black.png');
% Q = imread('half.png');
Q1 = rgb2gray(Q);
Q2 = graythresh(Q1);
Q3 = im2bw(Q, Q2);


X = imhist(Q3) % X = [ black white]
% white percentage
W = X(1) / X(2)
% X = imhist(bw);
% Y = imhist(bw1);