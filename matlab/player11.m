classdef player11  < handle
    %created by Samuel Andermatt (the idea is rather straightforward, so in
    %case somebody has had this idea before I apologize)
    %The idea is that you basically go for TFT, but try to avoid to enter a
    %state where players reject each other over and over again.
    %Therefore you will try to reconcile, as soon as the rejections on both
    %sides caused enough damage to the other player to avoid beeing
    %exploitable
properties
    name='Reconcilation TFT';
    short='RTFT';
    playernumber=11;
    k=zeros(1); %this is a number that allows the object to switch between a recoonciling state and a TFT state. 0 means TFt, 1 means reconcile.
    memory=20; %determines how many turns you go back at max
end
methods
    function P11 = player11(np)
        P11.k=zeros(np,1);
    end
    function decision=decide(obj,K,op,turn)
        if (turn == 1)
            decision = 1; %cooperate in turn 1
        elseif (obj.k(op)==1) %player is in reconciling state
            decision = 1;
            obj.k(op)=0; %Go back to TFT state
        elseif (K(op,obj.playernumber,turn-1) == 1)  %cooperation is always met with cooperation
            decision = 1;
        else
            %calculate if the conditions are met to enter reconciling state
            winCoop=0; %the winnings the opponent had if he cooperated
            winReject=0; %the winnings he made by rejecting
            %calculate the winnings B can get by exploiting the
            %reconcilation attempt, a reconcilation attempt is two
            %consecutive cooperative steps
            C=win([2 1]);
            RecT=2*C(1);
            for i=turn-1:-1:turn-obj.memory-1
                if(i<1) 
                    continue; %there are no turns before the first turn
                end
                A=win([1 1]); %winnings for cooperation
                winCoop=winCoop+A(1); %the points he would have won by cooperating
                B=win([K(op,obj.playernumber,i) K(obj.playernumber,op,i)]); %the points won by rejecting
                winReject=winReject+B(1); %the points the opponent actually won trhough rejection
                if (winCoop>winReject+RecT) %Cooperation would have bben better for the opponent
                    obj.k(op)=1;
                    decision=1;
                    break;
                end
            end
            if (obj.k(op)==0) %Criteria for reconcilation have not been met
                decision = 2;
            end
        end
    end
end
end
