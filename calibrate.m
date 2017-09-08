function calib = calibrate
%CALIBRATE Calibration of webcam_digit_reader
%   This function performs an interactive calibration of a webcam to use it
%   with the automatic digit reader.

    cam_idx = listdlg('Name', 'Select a camera', 'SelectionMode', 'single', 'ListString', webcamlist);
    cam = webcam(cam_idx);

    resolution_idx = listdlg('Name', 'Select resolution', 'SelectionMode', 'single', 'ListString', cam.AvailableResolutions);
    cam.Resolution = cam.AvailableResolutions{resolution_idx};

    exposure_mode = 'manual';
    cam.ExposureMode = exposure_mode;

    h = preview(cam);

    sld = uicontrol(h.Parent.Parent, 'Style', 'slider',...
        'Min', 0, 'Max', 30, 'Value', 0, ...
        'Callback', {'setfocus', cam});
    
    uiwait(h.Parent.Parent.Parent);
    close all;

    img_ = snapshot(cam);
    f_h = figure;
    imagesc(img_);
    title('Select the ROI');
    h = imrect;
    display_roi = wait(h);

    tmp = inputdlg('How many digits? ');
    n_digits = str2num(tmp{1});

    close all;

    img = imcrop(img_, display_roi);
    figure, imagesc(img);
    title('Select the points of each digit starting from the upper right one (clockwise)');

    dig_pos = zeros(7, 2, n_digits);
    for i=1:n_digits
        for j=1:7
            h = impoint;
            dig_pos(j, :, i) = wait(h);
            setString(h,['(', num2str(i), ',', num2str(j), ')']);
        end
    end
    dig_pos = round(dig_pos);


    calib.cam_idx = cam_idx;
    calib.resolution_idx = resolution_idx;
    calib.exposure_mode = 'manual';
    calib.display_roi = display_roi;
    calib.n_digits = n_digits;
    calib.dig_pos = dig_pos;
    calib.focus = cam.Focus;

    save calibdata calib
end