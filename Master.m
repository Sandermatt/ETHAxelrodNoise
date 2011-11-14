clear all;close all; home               % Initalisation

tic                                     % start time measurement
N = 200                                 % Number of turns
maxplayers = 9;                         % Maximum number of players
K = zeros(maxplayers,maxplayers,N );    % Contains the information about the players true decisions: 1=Cooperate   2=Betray
K2 = zeros(maxplayers,maxplayers,N );   % Contains the information about the players decision disturbed by noise
Noise1 = 0.05                           % Chance that cooperation gets recieved as betrayal
Noise2 = 0.05                           % Chance that betrayal gets recieved as cooperation
player = 'player'                       % Name of the player functions

Rewardmatrix=zeros(maxplayers,maxplayers); % Matrix that tracks how many points the players get out of each encounter
Reward=zeros(2,1);                      % Rewards that the players get in an encounter
Points=zeros(maxplayers);               % Total amount of points of a player
Winner=0;                               % most succesful player

list = playerlist(player, maxplayers);
for i=1:maxplayers
    if list(i)==1
        i2=int2str(i);
        eval(['P' i2 '=player' i2]);
        Names{i}=eval(['P' i2 '.name']);
    end
end

Names

for i=1:N % loop trough all turns
    for j=1:maxplayers % loop trough all players
        for k=1:j      % let each player interact with all other players
            j2=int2str(j);    
            k2=int2str(k);                    
            if list(j)==1 && list(k)==1
                K(j,k,i)=eval(['P' j2 '.decide(K2,k,i)']);  % player j decides how to behave to player k
                K(k,j,i)=eval(['P' k2 '.decide(K2,j,i)']);  % player k decides how to behave to player j
                Reward=win([K(j,k,i) K(k,j,i)]); % Rewards are calculated
                if (j == k)
                    Reward=Reward/2; % otherwise the interaction with itself get counted double
                end
                Points(j) = Points(j) + Reward(1);  % Points get updated
                Points(k) = Points(k) + Reward(2);
                Rewardmatrix(j,k) = Rewardmatrix(j,k) + Reward(1);
                Rewardmatrix(k,j) = Rewardmatrix(k,j) + Reward(2);
                % noise/miscommunication
                if (K(j,k,i) == 1) %player j cooperates
                    if (rand > Noise1) %transmission correct
                        K2(j,k,i) = 1; 
                    else % miscommunication
                        K2(j,k,i) = 2;
                    end
                else %player j betrays
                    if (rand > Noise2) %transmission correct
                        K2(j,k,i) = 2; 
                    else % miscommunication
                        K2(j,k,i) = 1;
                    end
                end
                if (K(k,j,i) == 1) %player k cooperates
                    if (rand > Noise1) %transmission correct
                        K2(k,j,i) = 1; 
                    else % miscommunication
                        K2(k,j,i) = 2;
                    end
                else % player k betrays
                    if (rand > Noise2) %transmission correct
                        K2(k,j,i) = 2; 
                    else % miscommunication
                        K2(k,j,i) = 1;
                    end
                end
            end
        end 
    end
end
Rewardmatrix
AvReward = endwin(Rewardmatrix)/(N*maxplayers) %average Reward
Winner = find(AvReward == max(AvReward))
bar(AvReward) %make a plot with the players performances
axis([0 maxplayers+1 min(AvReward)-0.05 max(AvReward)+0.05])
toc                     % end time measurement