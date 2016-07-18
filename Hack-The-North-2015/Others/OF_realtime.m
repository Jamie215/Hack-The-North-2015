clear all

% Create video input object
vid = videoinput('winvideo');
% vid = videoinput('winvideo', 1, 'RGB24_320x240');

% Detector Objects
 faceDetector = vision.CascadeObjectDetector('FrontalFaceLBP');
 faceDetector.MergeThreshold = 5;
 eyeDetector = vision.CascadeObjectDetector('LeftEye');
 eyeDetector.MergeThreshold = 18;
%  eyeDetector.MinSize = [];
%  reyeDetector = vision.CascadeObjectDetector('RightEye');
%  faceDetector.MergeThreshold = 5;

cam = webcam
% preview(cam);
%closePreview(cam)


% BB=step(EyeDetect,I);
% figure,imshow(I);
% rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
% title('Eyes Detection');

for j = 1:100
    img = snapshot(cam);
%     subplot(1,2,1), imshow(img)
    fbb = step(faceDetector, img); % x y width height
    ebb = step(eyeDetector, img);
%     rebb = step(reyeDetector,img);
    faceimg = imgcrop(img, fbb);
    
    eyenum = size(ebb);
    for i = 1:eyenum(1)
        
    end
    
    out = insertObjectAnnotation(img,'rectangle', fbb, 'face');
    out = insertObjectAnnotation(img,'rectangle',ebb, 'eye');
%     out = insertObjectAnnotation(img,'rectangle',BB, 'right eye');
    imshow(out)
%     subplot(1,2,2), videoOut;

    %imshow(img);
end

delete(vid)
delete(cam)
