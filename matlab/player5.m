classdef player5
properties
    name='Friedmann';
end
methods
    function P5 = player5(np)
    end
    function decision=decide(obj,K,op,turn)
    if (turn == 1)
        decision = 1; %cooperate in turn 1
    elseif (max(K(op,5,:)) == 2) % was betrayed once
        decision = 2;
    else
        decision = 1;
    end
    end
end
end