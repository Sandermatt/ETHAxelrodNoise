classdef player13
    %created by samuel andermatt
    %this is a player that takes the decisions to other players into
    %account (works with signaling)
properties
    name='TFT with Reputation';
    playernumber=13;
    threshold=0.85; %number of cooperations that have to be made with other players on average to ensure cooperation
end
methods
    function P13 = player13(np)
    end
    function decision=decide(obj,K,op,turn)
        if (turn == 1)
            decision = 1; %cooperate in turn 1
        elseif (K(op,obj.playernumber,turn-1) == 1)
            decision = 1;
        elseif (mean(K(op,:,turn-1))-1 > obj.threshold) %average of oponents decision is higher than threshold
            decision = 1;
        else
            decision = 2;
        end
    end
end
end
