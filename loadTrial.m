function [pos, mag]=loadTrial(filename, start, finish)
    % Load data
    toss = ParseMatlabApp(filename);
    Fs = 100;

    % Transform coordinate system from phone frame to global frame
    for i=1:length(toss.Accel)
        toss.Accel(i,:) = [inv(Rot(toss.Orientation(i,1), toss.Orientation(i,2), toss.Orientation(i,3)))*toss.Accel(i,:)'];
    end
    toss.Accel_final = toss.Accel(1:end,:); % Pick the range we want to plot
    toss.Accel_final = toss.Accel_final - mean(toss.Accel_final); % Substract the mean to center the data and eliminate gravity
    toss.Accel_final = toss.Accel_final /100;%Change accel to centimeters
    toss.Orientation = toss.Orientation /100;%Change Orientation to centimeters

    %take 4 perfect tosses and average them to get the *perfect* toss
    Accel_final = toss.Accel_final(start:finish, :);
    Orientation = toss.Orientation(start:finish, :);
    % Double integration to get positions
    v = [0 0 0];
    for i=2:length(Accel_final)
        v(i,:) = v(i-1,:) + Accel_final(i-1,:);
    end

    pos = [0 0 0];
    for i=2:length(Accel_final)
        pos(i,:) = pos(i-1,:) + v(i-1,:);
    end

    % Plot
    % figure(1); hold on 
    % plot(pos(:,2),pos(:,3));
    % ylabel('Y (cm)'); xlabel('Z (cm)'); axis equal
    % plot(0,0,'rx')
    % title('Position Data');
    % hold off

    % Frequency Plot Testing
    % figure(2);
    % o=200;
    mag = sqrt(Accel_final(:,1).^2 + Accel_final(:,2).^2 + Accel_final(:,3).^2);
    % make_freq_plot(mag(1+o:25+o), 100)
end
