classdef UsDevice < handle
    %UsDevice デバイス属性クラス
    properties(Access = public)
        x1  % トリミング範囲 X1
        y1  % トリミング範囲 Y1
        x2  % トリミング範囲 X2
        y2  % トリミング範囲 Y2
    end
    
    methods
        function obj = UsDevice(x1, y1, x2, y2)
            %UsDevice トリミング範囲を指定する。
            obj.x1 = x1;
            obj.y1 = y1;
            obj.x2 = x2;
            obj.y2 = y2;
        end
        
        function x1 = get.x1(obj)
            x1 = obj.x1;
        end
        
        function y1 = get.y1(obj)
            y1 = obj.y1;
        end
        
        function x2 = get.x2(obj)
            x2 = obj.x2;
        end
        
        function y2 = get.y2(obj)
            y2 = obj.y2;
        end
    end
end
