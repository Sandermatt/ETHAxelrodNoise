classdef player19 < handle
    %At this point I apologize if I missuse terms differently used in
    %evolutionary algorithms. I am not familiar with this field.
properties
    name='Evolutionary';
    short='EVO';
    playernumber=19;
    stratlen=10; %length of the strategy that has to be optimized
    subsegs=1; %decides in how many segments each strategy is split
    childnum=2; %number of mutated children
    mut=0.1; %mutation rate
    transition=1000; %once the transition turn is reached the mutability is changed, this is because initially larger changes in the strategy are needed
    mut2=0.05; %the mutability after the transition
    transition2=5000; %second transition into the most stable phase
    mut3=0.025;
    child=zeros(1,1,1); %this array stores the children strategies
    parent=zeros(1,1); %the parent strategy
    seglen=1;
end
methods
    function P19 = player19(np)
        P19.child=zeros(np,P19.childnum,P19.stratlen);
        P19.seglen=P19.stratlen/P19.subsegs; %decides how long a segment is
        P19.parent=zeros(np,P19.stratlen); %the parent strategy
    end
    function decision=decide(obj,K,op,turn)
        %this part creates the sequance to start of
        if (turn == 1)
            decision = 1; %cooperate in turn 1
        elseif(turn<obj.stratlen+1)
             decision = K(op,4,turn-1); %use TFT to generate the first sequence
             obj.parent(op,turn-1)=decision;
        else
            if (turn==obj.transition) %transition into the second regime
                obj.mut=obj.mut2;
            end
            if (turn==obj.transition2) %transition into the second regime
                obj.mut=obj.mut3;
            end
            if (turn==obj.stratlen+1) %the last parent entry has to be made in a seperate space
                obj.parent(op,turn-1)=K(obj.playernumber,op,turn-1);
            end
            %the next part creates the first mutations
            if (turn==obj.stratlen+1)
                for i=1:obj.stratlen
                    for j=1:obj.childnum
                        if rand>obj.mut %ad a mutation
                            obj.child(op,j,i)=K(obj.playernumber,op,i);
                        else %add a mutation
                            if (K(obj.playernumber,op,i)==1)
                                obj.child(op,j,i)=2;
                            else
                                obj.child(op,j,i)=1;
                            end
                        end
                    end
                end
            end
            %from now on the main algorithm can run
            if(mod(turn,obj.stratlen*(1+obj.childnum)+1)==1)
                %create new children
                %calculate performance
                perf=zeros(obj.childnum,obj.subsegs); %this array will store the performance of all strategies
                parperf=zeros(obj.subsegs,1);
                for i=0:obj.childnum
                    for j=1:obj.subsegs
                        for k=1:obj.seglen
                            turn2=turn-(obj.childnum-i+1)*obj.stratlen+(j-1)*obj.seglen+k-1;
                            w=win([K(obj.playernumber,op,turn2) K(op,obj.playernumber,turn2)]); %calculates the winnings
                            if(i==0)
                                parperf(j)=parperf(j)+w(1); %updates the parents performance
                            else
                                perf(i,j)=perf(i,j)+w(1); %updates the childrens performance
                            end
                        end
                    end
                end
                for i=1:obj.subsegs
                    [maxperf,perfInd]=max(perf(:,i)); %calculates the performance of the best child, and which child performed strongest
                    if (maxperf > parperf(i)) %child performes better
                        for j=1:obj.seglen
                            turn2=(i-1)*(obj.seglen)+j; %turn in the strategy that will be changed
                            obj.parent(op,turn2)=obj.child(op,perfInd,turn2); %exchange the segment of the parent with the more succesful segment
                        end
                    else %parent is strongest
                    end
                end
                %create and mutate children
                for i=1:obj.childnum
                    obj.child(op,i,:)=obj.parent(op,:);
                    %mutate
                    for j=1:obj.stratlen
                        if (rand<obj.mut) %add mutation
                            if (obj.child(op,i,j)==1)
                                obj.child(op,i,j)=2;
                            else
                                obj.child(op,i,j)=1;
                            end
                        else
                        end
                    end
                end
            end
            %choose the next move
            if (mod(turn,obj.stratlen*(1+obj.childnum)+1)==0)
                decision=K(op,obj.playernumber,turn-1); %add a TFT step until you evaluate the performance of each child
            else
                %perform the appropriate child strategy
                x=mod(turn,obj.stratlen*(1+obj.childnum)+1); %decides in which turn we are in the cicle
                x2=floor((x-1)/obj.stratlen); %decides which strategy will be played, 0 is the original strategy
                if(x2==0) %the parent strategy is played
                    decision=obj.parent(op,x);
                else
                    x3=mod(x-1,obj.stratlen)+1; %decides in which turn we are during the current stategy
                    decision=obj.child(op,x2,x3);
                end
            end
        end
    end
end
end
