function num = snap_number(cam, calib)
% SNAP_NUMBER Take a snapshot and view the number

    close all
    img_ = snapshot(cam);
    img = imcrop(img_, calib.display_roi);
    img = imbinarize(rgb2gray(img));
    img = ~img;
    figure, imshow(img);

    num = nan(1, calib.n_digits);
    for i=1:calib.n_digits
        num(i) = recognize_digit(img, calib.dig_pos(:, :, i));
    end
end