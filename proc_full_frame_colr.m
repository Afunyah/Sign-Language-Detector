function [fname, cc_frame] = proc_full_frame_colr()
global frame; %#ok<GVMIS> 
fname = 'full_frame_colr';
cc_frame = frame;
cc_frame = imresize(cc_frame,[216 324]);
end

