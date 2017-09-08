% Webcam Digit Reader
% Requires MATLAB Support Package for USB Webcams

clear all

% If calibration data is missing, then calibrate
try load calibdata.mat
catch ME
    % Exception MATLAB:load:couldNotReadFile
    calib = calibrate;
end

% Camera initialization
cam = webcam(calib.cam_idx);
cam.Resolution = cam.AvailableResolutions{calib.resolution_idx};
cam.ExposureMode = calib.exposure_mode;
cam.Focus = calib.focus;

% Snapshot example
snap_number(cam, calib)