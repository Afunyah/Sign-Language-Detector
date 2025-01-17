function [fname, cc_frame] = proc_hand_detection_1_colr()
global frame; %#ok<GVMIS>
% global pad_w; %#ok<GVMIS>
% global pad_h; %#ok<GVMIS>
% global resz_h; %#ok<GVMIS>
pad_w = 100;
pad_h = 100;
resz_h = 40;
fname = 'hand_detection_1_colr';
[bwMsk,~] = createMask(frame);
blobAnalysis = vision.BlobAnalysis('MinimumBlobArea', 4000);
[area, ~, bbox] = blobAnalysis(bwMsk);
% imnew = insertObjectAnnotation(frame, 'rectangle', bbox, 'hand', 'LineWidth',1,'FontSize', 24);
%         subplot(1,2,1);
%         imshow(imnew)
l = size(bbox);
areas = zeros(1,l(1));
for j = 1:l(1)
    areas(j) = bbox(j,3)*bbox(j,4);
end

[~,index] = max(areas);
biggest_region = bbox(index,:);
hand_pixels = biggest_region;
ss = size(frame);
try
    w = min(ss(2),hand_pixels(1)+hand_pixels(3));
    h = min(ss(1),hand_pixels(2)+hand_pixels(4));
    rows = hand_pixels(2):h;
    cols = hand_pixels(1):w;
    %         subplot(1,2,2);
    %         imshow(frame(rows,cols));
    frame = frame(rows,cols,1:3);
catch ME
    error(ME.message);
    %             disp(ME.message);
    %             disp('Error in hand pixels');
end

frame = imresize(frame, [resz_h NaN]);
ss = size(frame);
cc_frame = padarray(frame,[pad_h-ss(1) pad_w-ss(2) 0],0,'post');
end

