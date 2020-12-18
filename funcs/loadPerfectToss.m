function [pos, mag]=loadPerfectToss()
    % Load data
    tosses = ParseMatlabApp('perfectTossesx4.mat');
    Fs = 100;

    % Transform coordinate system from phone frame to global frame
    for i=1:length(tosses.Accel)
        tosses.Accel(i,:) = [inv(Rot(tosses.Orientation(i,1), tosses.Orientation(i,2), tosses.Orientation(i,3)))*tosses.Accel(i,:)'];
    end
    
    tosses.Accel_final = tosses.Accel(1:end,:); % Pick the range we want to plot
    tosses.Accel_final = tosses.Accel_final - mean(tosses.Accel_final); % Substract the mean to center the data and eliminate gravity
    tosses.Accel_final = tosses.Accel_final /100;%Change accel to centimeters
    tosses.Orientation = tosses.Orientation /100;%Change Orientation to centimeters

    %take 4 perfect tosses and average them to get the *perfect* toss
    Accel_final = 2*mean(cat(3, tosses.Accel_final(573:693, :), tosses.Accel_final(1031:1151, :), tosses.Accel_final(1376:1496, :), tosses.Accel_final(1736:1856, :)),3);
    Orientation = 2*mean(cat(3, tosses.Orientation(573:693, :), tosses.Orientation(1031:1151, :), tosses.Orientation(1376:1496, :), tosses.Orientation(1736:1856, :)),3);

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
    mag = [fftshift(fft(Accel_final(:,1))),fftshift(fft(Accel_final(:,2))),fftshift(fft(Accel_final(:,3)))];
end
