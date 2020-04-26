%% サブフォルダをクラス名とした動画ファイルのスプリット
% 岡山大学整形外科　中原龍一
%
% 改変・再配布自由　
% 人工知能ユーザーの拡大を祈って
% 
% movフォルダ内にあるサブフォルダ名をクラス名とする
% 
% (1) movフォルダ内にクラス名のフォルダを作成し動画ファイルを入れる複数ファイルを置いてもよい
%
% (2) 本スクリプトを実行するとTraingImagesフォルダ内に動画ファイルが静止画ファイルに分割されて出力される
%

%% 出力先のフォルダの設定
clear;
storage = Storage('TrainImages', 'mov');

%% 切りとり座標の設定
% 東芝超音波設定 Aplio 300
usDevice = UsDevice_Toshiba_Aplio300;

% コニカミノルタ Sonimage HS1
% usDevice = UsDevice_KonicaMinolta_SonimageHS1;

%% mov内のサブフォルダと同じ名前のフォルダを作成
storage.createEmptyTrainDir;

%% 動画フォルダ内にある動画ファイル名の取得
aviFolderNames = storage.getFolderNames(storage.movDir);
for aviFolderName = aviFolderNames
    targetFolder = [storage.movDir filesep char(aviFolderName)];
    aviFileNames = storage.getFileNames(targetFolder, '*.mp4');
    for aviFileName = aviFileNames
        aviFullFileName = [targetFolder filesep char(aviFileName)];
        splitFolder = [storage.trainDir filesep char(aviFolderName)];
        movie = UsMovie(aviFullFileName, usDevice);
        movie.split(splitFolder);
    end
end