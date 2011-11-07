function [ decision ] = player8(K,op,turn)
%Joss
r=0.1;
if (turn == 1)
    decision = 1; % cooperate in turn 1
    if (rand < r) % insert random rejections
        decision=2;
    end
else
    if (K(op,8,turn-1) == 1)
        decision = 1;
    if (rand < r) % insert random rejections
        decision=2;
    end
    else
        decision = 2;
    end
end

end
