classdef Storage < handle
    %Storage データ管理クラス
    %   ファイル操作に関するメソッド群を定義する

    properties (SetAccess = private)
        currentDir % 実行時ディレクトリ
        trainDir   % 訓練データディレクトリ
        movDir     % 教師動画ディレクトリ
    end
    
    methods
        function obj = Storage(trainDir, movDir)
            %Storage 訓練データディレクトリ, 教師動画ディレクトリを指定
            obj.currentDir = fileparts(mfilename('fullpath'));
            obj.trainDir = [obj.currentDir filesep trainDir];
            obj.movDir = [obj.currentDir filesep movDir];
        end
        
        function createEmptyTrainDir(obj)
            %createEmptyTrainDir 訓練データディレクトリを教師動画ディレクトリと同じ形式で作成する
            if exist(obj.trainDir, 'dir')
                rmdir(obj.trainDir, 's');
            end
            for folderName = obj.getFolderNames(obj.movDir)
                targetDirname = [obj.trainDir filesep char(folderName)];
                mkdir(targetDirname);
            end
        end
        
        function folderNames = getFolderNames(~, targetDir)
            %getFolderNames 指定されたフォルダ内のフォルダ一覧を返す
            dirInfo = dir(targetDir);
            dirInfo = dirInfo(~ismember({dirInfo.name},{'.','..'}));
            dirNames = string({dirInfo.name});
            fullDirNames = [targetDir filesep] + dirNames;
            folderNames = dirNames(isfolder(fullDirNames));
        end
        
        function fileNames = getFileNames(~, targetDir, glob)
            %getFileNames 指定されたフォルダ内のファイル一覧を返す
            dirInfo = dir([targetDir filesep glob]);
            dirNames = string({dirInfo.name});
            fullDirNames = [targetDir filesep] + dirNames;
            fileNames = dirNames(isfile(fullDirNames));
        end
    end
end
