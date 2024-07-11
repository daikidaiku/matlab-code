%% path

% ディレクトリ
dir = '/Users/daiki_daiku/Library/CloudStorage/Box-Box/Personal/研究/221201/';
% データファイル名
file_name = '01.csv';
% ゲージファイル名
gagefile_name = 'gage.csv';
% ビデオ名
video_name = '01.mp4';
%% 変数

% 巻き数
m = 15;

% 始点
gage1 = gage(2, 3);

% 終点
gage2 = gage(16, 3);
%% データ読込

data_dir = append(dir,file_name);
gage_dir = append(dir,gagefile_name);
video_dir = append(dir,video_name);
% データ
data1 = readmatrix([data_dir]);
% gage
gage = readmatrix([gage_dir]);
%% データ整理

% データ数
n = gage2 - gage1 + 1;
% データ
Z = data1(6:end, gage1:gage2);
% データサイズ
sz = size(Z);
row = sz(1);
% プロット位置
theta = linspace(0, 2 * m * pi, n);
x = cos(theta);
y = sin(theta);
h = linspace(70, 0, n);
t = linspace(0, (row - 0.01) / 100, row);
% colorbar用
zmax = max(max(Z));
zmin = min(min(Z));
%% 動画

% 時間軸
T = 0.01:0.01:row / 100;
for i = 1:length(T)
    z{i} = Z(i,:); % 各時刻のデータ
end
% Figure オブジェクトの生成
fig = figure;
% 描画範囲の固定
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
zlim([0 75]);
% 各フレームの画像データを格納する配列
frames(row) = struct('cdata', [], 'colormap', []);
H=scatter3(x, y, h, [], z{1}, 'filled');
view(45, 45)
for i = 1:row
    set(H, 'CData', z{i});
    clim([zmin + 2 zmax - 2]);
    colorbar;
    drawnow;
    frames(i) = getframe(fig);
end
video = VideoWriter(video_dir, 'MPEG-4');
video.FrameRate = 100;
open(video);
writeVideo(video, frames);
close(video);
%%
% scatter3(x, y, h, [], Z(1, :), 'filled');
% xlim([-1.5 1.5]); ylim([-1.5 1.5]); zlim([0 75])
% view(45, 45)