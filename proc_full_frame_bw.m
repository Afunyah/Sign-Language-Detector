function [fname, cc_frame] = proc_full_frame_bw()
global frame; %#ok<GVMIS> 
fname = 'full_frame_bw';
frame = imbinarize(frame,'adaptive','ForegroundPolarity','dark','Sensitivity',0.68);
frame = (frame*255);
frame = rgb2gray(frame);

cc_frame = frame*255;
cc_frame = imresize(cc_frame,[216 324]);
end

