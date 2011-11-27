classdef player8 < handle
properties
    name='Joss';
    r=0.1; %random rejection chance
end
methods
    function decision=decide(obj,K,op,turn)
    if (turn == 1)
        decision = 1; % cooperate in turn 1
        if (rand < obj.r) % insert random rejections
            decision=2;
        end
    else
        if (K(op,8,turn-1) == 1)
            decision = 1;
        if (rand < obj.r) % insert random rejections
            decision=2;
        end
        else
            decision = 2;
        end
    end
    end
end
end