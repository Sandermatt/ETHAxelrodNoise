classdef player4
properties
    name='Tit for tat';
    short='TFT';
end
methods
    function P4 = player4(np)
    end
    function decision=decide(obj,K,op,turn)
        if (turn == 1)
            decision = 1; %cooperate in turn 1
        elseif (K(op,4,turn-1) == 1)
            decision = 1;
        else
            decision = 2;
        end
    end
end
end
