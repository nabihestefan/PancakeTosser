function []=runToss(filename, start, finish, name)
    Fs = 100;
    [perfect, fPer] = loadPerfectToss();
    [trial, fTrial] = loadTrial(filename, start, finish);
    %animation

    if length(perfect) > length(trial)
       len = length(trial);
       fin = length(perfect);
    else
       len = length(perfect);
       fin = length(trial);
    end
    
    %FFT Plots
    figure()
    NP = length(fPer);
    NP_fshift = (linspace(-pi, pi-2/NP*pi, NP) + pi/NP*mod(NP,2))*Fs/(2*pi);
    plot(NP_fshift, abs(fPer(:,2)));
    
    hold on
    NT = length(fTrial);
    NT_fshift = (linspace(-pi, pi-2/NT*pi, NT) + pi/NT*mod(NT,2))*Fs/(2*pi);
    plot(NT_fshift, abs(fTrial(:,2)));
    title(append("FFT Y-axis " + name))
    legend("Perfect Toss Freq", "Trial Toss Freq");
    xlabel('Frequency (Hz)'); ylabel('Amplitude');
    hold off
    
    figure()
    plot(NP_fshift, abs(fPer(:,3)));
    
    hold on
    plot(NT_fshift, abs(fTrial(:,3)));
    title(append("FFT Z-axis " + name))
    legend("Perfect Toss Freq", "Trial Toss Freq");
    xlabel('Frequency (Hz)'); ylabel('Amplitude');
    hold off
    
    %Animation
    diff = abs(fTrial - fPer);
    green = (1-mean(diff, 'all')*2);
    if green < 0
        green = 0;
    else if green > 1
        green = 1;
        end
    end
    rgb = [0,green, 1];
    
    figure()
    pause(2)
    PerfectY = [perfect(1,2)];
    PerfectZ = [perfect(1,3)];
    scatter(PerfectY,PerfectZ,50,[1,1,1]);
    TestY = [trial(1,2)];
    TestZ = [trial(1,3)];
    scatter(TestY,TestZ,50,rgb,'filled');
                
    for i = 2:fin
    % Plotting
        if i < length(perfect)
            PerfectY = [perfect(i,2)];
            PerfectZ = [perfect(i,3)];
            scatter(PerfectY,PerfectZ,50,[1,1,1]);
        end
        if i < length(trial)
            TestY = [trial(i,2)];
            TestZ = [trial(i,3)];
            scatter(TestY,TestZ,50,rgb,'filled');
        end

        axis([-7 7 -10 25]);
        set(gca,'Color',[0,0,0]); %black background
        hold on;
        title(name);
        lgd = legend('Testing Toss', 'Perfect Toss');
        c = lgd.TextColor;
        lgd.TextColor = [1,1,1];
        xlabel('Z (cm)'); ylabel('Y (cm)');
        view(2); axis equal;pause(0.000000000000000000000000000001);
    end
end
