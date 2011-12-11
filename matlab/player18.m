classdef player18 < handle
    %created by Samuel Andermatt
    %this is an attempt to create a simple learning player
properties
    name='Watcher';
    short='WAT';
    playernumber=18;
    memory=6; %decides how many turns the player looks back to determine the most succesful strategy
    strategy; %decides which players strategy is chosen
end
methods
    function P18 = player18(np)
        P18.strategy=zeros(np,1);
    end
    function decision=decide(obj,K,op,turn)
        if (turn==1)
            decision=1; %cooperate in turn 1
        elseif (turn<obj.memory+2)
            decision=K(op,obj.playernumber,turn-1); %TFT for the first turns
        elseif (mod(turn-2,obj.memory)~=0)
            decision=K(obj.strategy(op),op,turn-obj.memory-1); %take the most succesful strategy against your opponent
        else
            %determine which strategy is best against your opponent
            np=length(K(:,1)); %number of players
            performance=zeros(np,1);
            for i=1:np
                for j=1:obj.memory
                    p=win([K(i,op,turn-obj.memory-1) K(op,i,turn-obj.memory-1)]); %the winings player i made vs this opponent
                    performance(i)=performance(i)+p(1);
                end
            end
            [maxPF,maxInd]=max(performance); %determine which player performed best vs this opponent
            obj.strategy(op)=maxInd;
            decision=K(obj.strategy(op),op,turn-obj.memory-1);
        end
    end
end
end