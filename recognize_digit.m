function digit = recognize_digit(img, pos)
%RECOGNIZE_DIGIT Function to recognize a digit
    
    % The LUT contains the decimal integer values that correspond to digits
    % Each digit is recognized by constructing a 7-bit binary number
    % starting from the upper right segment, as follows:
    %           6
    %         5   1
    %           7
    %         4   2
    %           3
    % If a segment is switched on, a 1 is put in the binary string,
    % otherwise it contains a 0.
    % For example digit 8 (all segments on) is represented by 1111111,
    % that corresponds to the decimal integer 127.
    lut = [126, 96, 91, 115, 101, 55, 63, 98, 127, 119];
    
    s = '';
    for i=1:7
        roi = img(pos(i, 2)-1:pos(i, 2)+1, pos(i, 1)-1:pos(i, 1)+1);
        val = 0;
        if( sum(roi(:)) > 1 )
            val = 1;
        end
        s = [s, num2str(val(1))];
    end
    
    digit = find(lut == bin2dec(s)) - 1;
    if isempty(digit)
        digit = NaN;
    end
end

