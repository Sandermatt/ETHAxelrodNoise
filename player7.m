function [ decision ] = player7(K,op,turn)
%Tit for 2tat
if (turn == 1)
    decision = 1; %cooperate in turn 1
elseif (turn ==2 )
    decision = 1;
else
    if (K(op,7,turn-1) == 1 | K(op,7,turn-2) == 1)
        decision = 1;
    else
        decision = 2;
    end
end

end