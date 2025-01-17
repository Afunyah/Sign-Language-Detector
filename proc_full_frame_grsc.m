function [fname, cc_frame] = proc_full_frame_grsc()
global frame; %#ok<GVMIS> 
fname = 'full_frame_grsc';
cc_frame = rgb2gray(frame);
cc_frame = imresize(cc_frame,[216 324]);
end

