%% ------------------------------------------------------------------------
% Initialize m-file

clear all;


% Inputs:
filename = 'simulation.mat';                       % name of the simulation-file

% Calc:
vars=load(filename);                               % load variables of the simulation-file

Rewardmatrix = vars.Rewardmatrix;                  % store the rewardmatrix
NumberOfTurns = vars.N;                            % store the numbers of turns
listOfPlayers = vars.Names;                         % store the list of players
Noise = vars.Noise;                                % store the noisematrix

numberOfPlayers=length(listOfPlayers);             % get the numbers of players                           

                

%% ------------------------------------------------------------------------
% Plot all players with given noiselevels

% Inputs:
NoiseLevel = [1  ;...     % Noise Level 1
              1  ];        % Noise Level 2

% Calc:
clf;
[x, lengthN] = size(NoiseLevel);   

for i=1:lengthN
    A=Rewardmatrix(:,:,NoiseLevel(1,i),NoiseLevel(2,i));
    A=sum(A)/NumberOfTurns/length(listOfPlayers);
    subplot(lengthN,1,i)
    bar(A);
    grid ON;
    title(['Plot with noise ',num2str(Noise(1,NoiseLevel(1,i))),' and ', num2str(Noise(2,NoiseLevel(2,i)))]);
    xlabel('Players')
    ylabel('Average profit')
end


%% ------------------------------------------------------------------------
% Plot statistics for a given player

% Inputs: 
player={'Downing','CDowning', 'Tit for tat'};     % Names of the players
NoiseLevel = [1 2  ;...     % Noise Level 1
              1 2 ];        % Noise Level 2

% Calc:
clf;
lengthVector = length(player);
position=zeros(1,numberOfPlayers);
[x, lengthN] = size(NoiseLevel); 

for i=1:lengthVector
a = strfind(listOfPlayers,player{i});
    for k=1:numberOfPlayers
        c=length(a{k});
        if c
            position(k)=1;
        end
    end
end

position=find(position);


A=Rewardmatrix(position,:,:,:)./NumberOfTurns;

for k=1:length(position)
    for i=1:lengthN
        A=Rewardmatrix(k,:,NoiseLevel(1,i),NoiseLevel(2,i))/NumberOfTurns;
        subplot(length(position),lengthN,i+(k-1)*lengthN)
        bar(A);
        grid ON;
        set(gca,'YLim',[0 5],'Layer','top') 
        title(['Plot with noise ',num2str(Noise(1,NoiseLevel(1,i))),' and ', num2str(Noise(2,NoiseLevel(2,i)))]);
        xlabel('Players')
        ylabel('Average profit')
    end


end
hold off;





