classdef player14 < handle
    %created by Samuel Andermatt
    %this is an attempt to create a simple learning player
properties
    name='Strategy Switcher';
    playernumber=14;
    s=zeros(1,1); %current strategy
    lastS=zeros(1,1); %strategy of last turn
    strchange=20; %decides how many turns you wait until you change your strategy
    ts=zeros(5,1); %turnes spent in each strategy
    ps=zeros(5,1); %performance of each strategy
end
methods
    function P14 = player14(np)
        P14.s=zeros(np,1)+1; %start with strategy 1
        P14.lastS=zeros(np,1)+1;
        P14.ts=zeros(5,np);
        P14.ps=zeros(5,np);
    end
    function decision=decide(P14,K,op,turn)
        if (turn==1) %cooperate in turn 1
            decision=1;
        elseif (P14.s(op) == 1) %strategy one is active
            %TFT
            if (K(op,P14.playernumber,turn-1) == 1)
                decision = 1;
            else
                decision = 2;
            end
        elseif (P14.s(op) == 2)
            %TF2T
            if (K(op,P14.playernumber,turn-1) == 1 || K(op,P14.playernumber,turn-2) == 1)
                decision = 1;
            else
                decision = 2;
            end
        elseif (P14.s(op) == 3)
            decision=2; %always defect
        elseif (P14.s(op) == 4)
            decision=1; %always cooperate
        else
            %pavlov
            if (K(op,6,turn-1) == 1) % he cooperates, that means the stretagy is continued
                decision = K(P14.playernumber,op,turn-1);
            else                     % He betrayed therefore the strategy is changed
                if (K(6,op,turn-1) == 1)
                    decision = 2;
                else
                    decision = 1;
                end
            end
        end
        
        %update ts and ps
        P14.ts(P14.s(op),op)=P14.ts(P14.s(op),op)+1; %one term more spent in strategy s
        if (turn>1)
            W=win([K(P14.playernumber,op,turn-1) K(op,P14.playernumber,turn-1)]); %winnings from last turn
            P14.ps(P14.lastS(op),op)=((P14.ts(P14.lastS(op),op)-1)*P14.ps(P14.lastS(op),op)+W(1))/P14.ts(P14.lastS(op),op); %average performance of strategy P14.lastS
        end
        
        %choose new strategy
        
        %evaluation phase
        
        P14.lastS(op)=P14.s(op); %the strategy from last turn is no longer needed, therefore it is updated here
        
        %in the first 100 turns experience is gained with all strategies
        if (turn == P14.strchange)
            P14.s(op)=2; %change to strategy 2
        elseif (turn == 2*P14.strchange)
            P14.s(op)=3;
        elseif (turn == 3*P14.strchange)
            P14.s(op)=4;
        elseif (turn == 4*P14.strchange)
            P14.s(op)=5;
            %Now 20 turns have been played with each strategy, the player
            %will now only play the most sucessful ones.
        elseif (turn >= 5*P14.strchange && mod(turn,P14.strchange) == 0) %initial testing phase ended, change strategies every 20 turns
            %this is a simple way to choose a strategy, he simply chooses
            %the one performing best
            [maxPF,maxInd]=max(P14.ps(:,op)); %maxInd is the index of the best performing strategy
            P14.s(op)=maxInd;
        else
        end        
    end
end
end
