clear all;close all; home               % Initalisation

%Note: Most standard players are taken from the lecture http://www.socio.ethz.ch/education/fs11/igt/notes/Evolution_von_Kooperation_2011.pdf

tic                                     % start time measurement
N = 100                                 % Number of turns
maxplayers = 17;                        % Maximum number of players
K = zeros(maxplayers,maxplayers,N );    % Contains the information about the players true decisions: 1=Cooperate   2=Betray
K2 = zeros(maxplayers,maxplayers,N );   % Contains the information about the players decision disturbed by noise
minNoise1 = 0                           % The chance that cooperation gets recieved as betrayal goes from the value minNoise1 to maxNoise1
maxNoise1 = 0.05
minNoise2 = 0                           % The chance that betrayal gets recieved as cooperation goes from the value minNoise2 to maxNoise2
maxNoise2 = 0.05
NoiseInc=0.05;                          % Noise increment with each simulation
maxX=(maxNoise1-minNoise1)/NoiseInc+1;  % number of points of the x-axis
maxY=(maxNoise2-minNoise2)/NoiseInc+1;  % number of points of the y-axis
player = 'player'                       % Name of the player functions
Rewardmatrix=zeros(maxplayers,maxplayers,maxX,maxY); % Matrix that tracks how many points the players get out of each encounter
Reward=zeros(2,1);                      % Rewards that the players get in an encounter
Points=zeros(maxplayers);               % Total amount of points of a player

Winner=0;                               % most succesful player

list = playerlist(player, maxplayers);
for i=1:maxplayers
    if list(i)==1
        i2=int2str(i);
        eval(['P' i2 '=player' i2 '(' num2str(maxplayers) ')']);
        Names{i}=eval(['P' i2 '.name']);
    end
end

Noise(1,1:maxX)=(minNoise1:NoiseInc:maxNoise1);
Noise(2,1:maxY)=(minNoise2:NoiseInc:maxNoise2);

for x=1:maxX
    Noise1=(x-1)*NoiseInc;
    for y=1:maxY
        Noise2=(y-1)*NoiseInc;
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
                        Rewardmatrix(j,k,x,y) = Rewardmatrix(j,k,x,y) + Reward(1);
                        Rewardmatrix(k,j,x,y) = Rewardmatrix(k,j,x,y) + Reward(2);
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
    end
end

save simulation Rewardmatrix N list Noise;
toc % end time measurement

