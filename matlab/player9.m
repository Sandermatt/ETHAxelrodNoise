classdef player9
properties
    name='Diekmann'; %source:www.socio.ethz.ch/vlib/pesb/pesb9.pdf
end
methods
    function P9 = player9(np)
    end
    function decision=decide(obj,K,op,turn)
        if (turn == 1)
            decision = 1; % cooperate in turn 1
        else
            if (K(op,9,turn-1) == 1)
                decision = 1;
            elseif (mod(turn,10)==0) %insert two cooperative moves every ten moves
                decision=1;
            elseif (mod(turn,10)==1) %insert two cooperative moves every ten moves
                decision=1;
            else
                decision = 2;
            end
        end
    end
end
end