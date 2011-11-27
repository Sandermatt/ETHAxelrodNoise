classdef player3 < handle
properties
    name='Random';
end
methods
    function decision=decide(obj,K,op,turn)
        if (rand>0.5)
            decision=1;
        else
            decision=2;
        end
    end
end
end