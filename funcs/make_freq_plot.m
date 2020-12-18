function make_freq_plot(x, Fs)
    N = length(x);
    freqs_shifted_hz = (linspace(-pi, pi-2/N*pi, N) + pi/N*mod(N,2))*Fs/(2*pi);
    plot(freqs_shifted_hz, abs(fftshift(fft(x))));
    xlabel('Frequency (Hz)'); ylabel('Amplitude');
end