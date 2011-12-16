classdef player6
properties
    name='Pavlov';
    short='PAV';
end
methods
    function P6 = player6(np)
    end
    function decision=decide(obj,K,op,turn)
    if (turn == 1)
        decision = 1; %cooperate in turn 1
    elseif (K(op,6,turn-1) == 1) % he cooperates, that means the stretagy is continued
        decision = K(6,op,turn-1);
    else                     % He betrayed therefore the strategy is changed
        if (K(6,op,turn-1) == 1)
            decision = 2;
        else
            decision = 1;
        end
    end
    end
end
end