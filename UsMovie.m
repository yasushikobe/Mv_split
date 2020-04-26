classdef UsMovie < handle
    %UsMovie 超音波動画操作クラス
    %   動画のトリミング・画像抽出を行う
    properties
        aviFile  % 動画ファイル（フルパス）
        usDevice % デバイス属性クラス
    end
    
    methods
        function obj = UsMovie(aviFile, usDevice)
            %UsMovie 動画ファイルパス、デバイス属性クラスを指定。
            obj.aviFile = aviFile;
            obj.usDevice = usDevice;
        end
        
        function split(obj, targetFolder)
            %split 動画を画像に分割する。出力フォルダを指定する。
            videoRecorder = VideoReader(obj.aviFile);
            width = videoRecorder.Width;
            height = videoRecorder.Height;
            movie = struct('cdata', zeros(height, width, 3, 'uint8'), 'colormap', []);
            frameNo = 1;
            while hasFrame(videoRecorder)
                movie(frameNo).cdata = readFrame(videoRecorder);
                frameNo = frameNo + 1;
            end
            I_first = movie(1).cdata;
            I_first = I_first( ...
                obj.usDevice.y1:obj.usDevice.y2 - obj.usDevice.y1, ...
                obj.usDevice.x1:obj.usDevice.x2 - obj.usDevice.x1, ...
                : ...
                );
            % 表示テスト
            % imshow(I_first);

            % 超音波画像は横長なので「Y-X」で計算
            % TODO：　縦長もあり得るので将来は修正必要
            blankSize =  size(I_first,2) - size(I_first,1);
            
            % ファイル名の取得
            [~, name, ~] = fileparts(obj.aviFile);
            fineNo = size(movie,2); 
            for frameNo = 1:fineNo
                I_origin = movie(frameNo).cdata;
                I_cut = I_origin( ...
                    obj.usDevice.y1:obj.usDevice.y2 - obj.usDevice.y1, ...
                    obj.usDevice.x1:obj.usDevice.x2 - obj.usDevice.x1, ...
                    : ...
                    );
                % 画像が中央になるようにゼロで上下を埋める
                I_final = [ ...
                    zeros(fix(blankSize/2), ...
                    size(I_cut,2),3); I_cut; zeros(blankSize-fix(blankSize/2), ...
                    size(I_cut,2),3) ...
                    ];
                outputFile = [targetFolder filesep sprintf('%s_%05d.png', name, frameNo)];
                imwrite(I_final, outputFile);
                fprintf('%s of %d files.\n', outputFile, fineNo);
            end
        end
    end
end