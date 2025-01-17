function [fname, cc_frame] = proc_edge_full_frame()
global frame; %#ok<GVMIS> 
fname = 'edge_full_frame';
cc_frame = rgb2gray(frame);
cc_frame = imresize(cc_frame,[216 324]);
cc_frame = edge(cc_frame, 'canny', 0.1);
cc_frame = cc_frame*255;

end

