classdef player10
    %created by Meier David
properties
    name='Tit for average tat';
    mem=5; %how many moves does the player remember
    erase=50; %erase memory after this amount of turns
end
methods
    function decision=decide(obj,K,op,turn)
        if (mod(turn,obj.erase)<obj.mem+2) %play tft in the first 10 rounds
            if (mod(turn,obj.erase) == 1)
                decision = 1; %cooperate in turn 1
            elseif (K(op,10,turn-1) == 1)
                decision = 1;
            else
                decision = 2;
            end
        else
            if (sum(K(op,10,turn-obj.mem+1:turn-1))/obj.mem<=1.5) %averaged decision over 10 turns is cooperative
                decision=1;
            else
                decision=2;
            end
        end
    end
end
end
