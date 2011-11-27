classdef player4 < handle
properties
    name='Tit for tat';
end
methods
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
