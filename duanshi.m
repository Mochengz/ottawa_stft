
%% 载入数据
data=load('I-D-2.mat');  % 假设数据文件名为 'I-D-2.mat'
vibration_data = data.Channel_1;  % 振动数据
speed_data = data.Channel_2;      % 转速数据

% 确定采样频率和时间窗长度
fs = 200000;  % 采样频率为200000Hz


% 原数据采样频率太高，计算时间过长，通过降采样来减少数据量
% 降采样后， 采样频率为20000Hz,采样点数为200000
downsample_scale = 20;   % 20倍降采样
vibration_data=downsample(vibration_data,downsample_scale);
fs=fs/downsample_scale;
N = size(vibration_data, 1);   % size(vibration_data, 2) 是列数，值为1

window_length = 10000;  % 频率分辨率为fs/window_length 512点太少

% 计算时间轴
time = (0 : N-1) / fs;

%% 绘制时域振动数据
figure;
plot(time, vibration_data);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time Domain Vibration Data');

%% 绘制频域振动数据
y_fft_sig = abs(vibration_data)*2/N;
y_fft_sig = y_fft_sig(1:N/2);
x_f = (0:N/2-1)*fs/N;
figure;
plot(x_f,y_fft_sig);
ylabel('Amplitude');
% 创建 xlabel
xlabel('Frequency(Hz)');
title('Frequency Domain Vibration Data');
%% 绘制包络谱的短时傅里叶变换时频谱
% 时频谱图可在 0~500Hz范围看到故障特征频率及其倍频曲线

xenv=abs(hilbert(vibration_data));

figure;
spectrogram(xenv, gausswin(window_length), floor(window_length*9/10), [], fs, 'yaxis');  
colorbar;
xlabel('Time (s)');
ylabel('Frequency (kHz)');
title('Short Time Fourier Transform - Spectrogram');

%% 转速曲线通过解码器获取
fs_en=200000;
p=100;
CPR=1024;
[fr,t_f]=encoder(speed_data,fs_en,p,CPR);
figure;
plot(t_f, fr);
xlabel('Time (s)');
ylabel('Rotation Speed');
title('Real Rotation Speed');


