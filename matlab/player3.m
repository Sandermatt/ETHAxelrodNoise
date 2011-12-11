classdef player3
properties
    name='Random';
    short='RAN';
end
methods
    function P3 = player3(np)
    end
    function decision=decide(obj,K,op,turn)
        if (rand>0.5)
            decision=1;
        else
            decision=2;
        end
    end
end
end