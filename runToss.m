function []=runToss(filename, start, finish, name)
    [perfect, fPer] = loadPerfectToss();
    [trial, fTrial] = loadTrial(filename, start, finish);
    %animation

    if length(perfect) > length(trial)
       len = length(perfect);
       fPer = fPer(1:length(trial), 3);
    else
        len = length(trial);
        fTrial = fTrial(1:length(perfect), 3);
    end

    freq = abs(fPer - fTrial);
    f = sqrt(freq(:,2).^2 + freq(:,3).^2);
    f = f / (max(f));
    red = zeros(size(f));
    green = 1 - f;
    blue = ones(size(f));
    rgb = [red,green,blue];
    
    figure()
    pause(2)
    PerfectY = [perfect(1,2)];
    PerfectZ = [perfect(1,3)];
    scatter(PerfectY,PerfectZ,50,[1,1,1]);
    TestY = [trial(1,2)];
    TestZ = [trial(1,3)];
    scatter(TestY,TestZ,50,rgb(1,:),'filled');
                
    for i = 2:len
    % Plotting
        if i < length(perfect)
            PerfectY = [perfect(i,2)];
            PerfectZ = [perfect(i,3)];
            scatter(PerfectY,PerfectZ,50,[1,1,1]);
        end
        if i < length(trial)
            TestY = [trial(i,2)];
            TestZ = [trial(i,3)];
            if i < length(rgb)
                scatter(TestY,TestZ,50,rgb(i,:),'filled');
            else
                scatter(TestY,TestZ,50,[1,0,1],'filled');

            end
        end

        axis([-7 7 -10 25]);
        set(gca,'Color',[0,0,0]); %black background
        hold on;
        title(name);
        lgd = legend('Testing Toss', 'Perfect Toss');
        c = lgd.TextColor;
        lgd.TextColor = [1,1,1];
        xlabel('Z (cm)'); ylabel('Y (cm)');
        view(2); axis equal; pause(0.000000001);
    end
end
