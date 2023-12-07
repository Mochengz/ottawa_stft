
% 载入数据
data=load('I-D-2.mat');  % 假设数据文件名为 'I-D-2.mat'
vibration_data = data.Channel_1;  % 振动数据
speed_data = data.Channel_2;      % 转速数据

% 确定采样频率和时间窗长度
fs = 200000;  % 采样频率为200000Hz
window_length = 512;  % 时间窗长度为512个样本点

% 计算时间轴
time = (0 : size(vibration_data, 2)-1) / fs;

% 绘制时域振动数据
figure;
plot(time, vibration_data);
xlabel('Time (s)');
ylabel('Vibration');
title('Time Domain Vibration Data');

% 进行短时傅里叶变换并绘制时频谱
figure;
spectrogram(vibration_data, window_length, [], [], fs, 'yaxis');
colorbar;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Short Time Fourier Transform - Spectrogram');






% 转速时域图谱
% Load the data from the file
data=load('I-D-2.mat');
% Extract the data for the Ottawa fault bearing
ottawaData = data.Channel_2;
% 转速数据的采样频率
fs = 200000;  % Hz

% 转速数据的采样持续时间
duration = 10;  % seconds

% 创建时间向量
t = 0:1/fs:duration-1/fs;

% 绘制时域图谱
figure;
plot(t, ottawaData);
xlabel('时间 (秒)');
ylabel('转速');
title('转速时域图谱');




% 加速度时域图谱
% Load the data from the file
data=load('I-D-2.mat');

% Extract the data for the Ottawa fault bearing
ottawaData = data.Channel_1;
% 加速度数据的采样频率
fs = 200000;  % Hz

% 加速度数据的采样持续时间
duration = 10;  % seconds

% 创建时间向量
t = 0:1/fs:duration-1/fs;

% 绘制时域图谱
figure;
plot(t, ottawaData);
xlabel('时间 (秒)');
ylabel('加速度');
title('加速度时域图谱');



% 加速度频域图谱
% Load the data from the file
data=load('I-D-2.mat');

% Extract the data for the Ottawa fault bearing
ottawaData = data.Channel_1;
% 加速度数据的采样频率
fs = 200000;  % Hz

% 加速度数据的采样持续时间
duration = 10;  % seconds

% 创建时间向量
t = 0:1/fs:duration-1/fs;

% 进行周期图谱估计
[N, ~] = size(ottawaData);  % 数据点个数
[pxx, f] = periodogram(ottawaData, [], N, fs);  % 计算功率谱密度

% 绘制单边频谱
figure;
plot(f, pxx);
xlabel('频率 (Hz)');
ylabel('功率谱密度');
title('加速度频域图谱（单边谱）');




% 转速频域图谱
% Load the data from the file
data=load('I-D-2.mat');

% Extract the data for the Ottawa fault bearing
ottawaData = data.Channel_2;
% 转速数据的采样频率
fs = 200000;  % Hz

% 转速数据的采样持续时间
duration = 10;  % seconds

% 创建时间向量
t = 0:1/fs:duration-1/fs;

% 进行FFT变换
N = length(ottawaData);  % 数据点个数
f = (-fs/2) : (fs/N) : (fs/2) - (fs/N);  % 频率向量
speedFFT = fftshift(fft(ottawaData));  % 进行FFT变换并进行移频

% 绘制频域图谱
figure; 
plot(f, abs(speedFFT)); 
xlabel('频率 (Hz)'); 
ylabel('振幅'); 
title('转速频域图谱');
xlim([0, fs/2]);
grid on;