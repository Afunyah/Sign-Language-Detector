
% CLASSIFIER SCRIPT

clear;

global frame; %#ok<GVMIS>

% PROC FUNCTION OPTIONS --------
% proc_hand_detection_1_grsc    - Only hand (resized and padded) grayscale
% proc_hand_detection_1_colr    - Only hand (resized and padded) colour
% proc_hand_detection_1_bw      - Only hand (resized and padded) black and white
% proc_edge_hand_detection_1    - Only hand (resized and padded) canny edges

% WILL NOT WORK - No resizing and padding - no uniform size!
% proc_hand_detection_2_grsc    - Only hand (no resize and padding) grayscale
% proc_hand_detection_2_colr    - Only hand (no resize and padding) colour

% proc_full_frame_colr          - Full frame colour
% proc_full_frame_grsc          - Full frame grayscale
% proc_full_frame_bw            - Full frame black and white
% proc_edge_full_frame          - Full frame canny edges

% ------------------------------

% Add functions to the array below
proc_function_array = {@()proc_hand_detection_1_bw, @()proc_edge_full_frame}; % <------------------- ADD FUNCTIONS HERE

% Extract number of functions, function names and corresponding trained networks
pfa_len = length(proc_function_array);
pf_names = cell(1,pfa_len);
net_array = cell(1,pfa_len);

for i=1:pfa_len
    fchr = char(proc_function_array{i}); fchr = fchr(9:end);
    pf_names{i} = fchr;
    net_dat_name = sprintf("nets/cnn_train_%s_data_v1.mat", fchr);
    load(net_dat_name,"net");
    net_array{i} = net;
end

figure1=figure('Position', [100, 100, 1024, 300*pfa_len]);

wc = webcam(1); % Change webcam here
nFrames = 300;
for i = 1:nFrames
    frame = wc.snapshot();
    o_frame = frame;

    for k = 1:pfa_len
        subplot(pfa_len,3,(k-1)*3+1)
        imshow(frame,'InitialMagnification', 800);
        title(nFrames - i);
        try
            [~, cc_frame] = proc_function_array{k}();
            subplot(pfa_len,3,(k-1)*3+2)
            imshow(uint8(cc_frame),'InitialMagnification', 800);
            title(nFrames - i);
            YPred = classify(net_array{k},uint8(cc_frame));
            %         YPred = classify(net,(cc_frame));
            catg = YPred;
        catch ME
            %         disp(ME.message);
            catg = '?';
        end
        subplot(pfa_len,3,(k-1)*3+3)
        cla
        text(0.4,0.5,catg,'FontSize',80);
        title(pf_names{k}, 'Interpreter', 'none', 'FontSize',16);

        frame = o_frame;
    end
    pause(0.07);
end



disp('-------- DONE --------');


