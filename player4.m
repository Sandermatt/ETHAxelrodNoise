function [ decision ] = player4(K,op,turn)
%Tit for tat
%
%
%
%
if (turn == 1)
    decision = 1; %cooperate in turn 1
else
    if (K(op,4,turn-1) == 1)
        decision = 1;
    else
        decision = 2;
    end
end

end
