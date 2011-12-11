classdef player8
properties
    name='Joss';
    short='JOSS';
    r=0.1; %random rejection chance
    playernumber=8;
end
methods
    function P8 = player8(np)
    end
    function decision=decide(obj,K,op,turn)
    if (turn == 1)
        decision = 1; % cooperate in turn 1
        if (rand < obj.r) % insert random defections
            decision=2;
        end
    else
        if (K(op,obj.playernumber,turn-1) == 1)
            if (rand < obj.r) % insert random defections
                decision=2;
            else
                decision=1;
            end
        else
            decision = 2;
        end
    end
    end
end
end