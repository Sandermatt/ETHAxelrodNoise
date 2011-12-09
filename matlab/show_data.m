%% ------------------------------------------------------------------------
% Initialize m-file

% Inputs:
filename = 'simulation.mat';                       % name of the simulation-file

% Calc:
vars=load(filename);                               % load variables of the simulation-file

Rewardmatrix = vars.Rewardmatrix;                  % store the rewardmatrix
NumberOfTurns = vars.N;                            % store the numbers of turns
listOfPlayers = vars.Names;                         % store the list of players
Noise = vars.Noise;                                % store the noisematrix
AvarageCoop = vars.AverageCoop;                     % store average cooperation

numberOfPlayers=length(listOfPlayers);             % get the numbers of players 


% Convert rewardmatrix
for i=1:numberOfPlayers                            % generate empty matrices for every player
    i2=int2str(i);
    eval(['P' i2 '=zeros(' 'size(Noise,2)' ',' 'size(Noise,2)' ',' 'numberOfPlayers'  ');']);
end

for i=1:numberOfPlayers                            % matrix for every player Pi(noise1,noise2,oponent)
    i2 = int2str(i);
    for k=1:size(Noise,2)
        k2 = int2str(k);
        for j=1:size(Noise,2)
            j2 = int2str(j);
            eval(['R' i2 '(' k2 ',' j2 ',:' ')' '=' 'Rewardmatrix(' i2 ',:,' k2 ',' j2 ');']);
        end
    end
    
end

for i=1:numberOfPlayers                            % matrix for every player Pi(noise1,noise2,oponent)
    i2 = int2str(i);
    for k=1:size(Noise,2)
        k2 = int2str(k);
        for j=1:size(Noise,2)
            j2 = int2str(j);
            eval(['C' i2 '(' k2 ',' j2 ',:' ')' '=' 'AverageCoop(' k2 ',' j2 ',' i2 ',:'  ');']);
        end
    end
    
end
                

%% ------------------------------------------------------------------------
% Plot all players with given noiselevels

% Inputs:
NoiseLevel = [1 1 2 2;...     % Noise Level 1
              1 2 1 2];        % Noise Level 2

% Calc:

[x, lengthN] = size(NoiseLevel);   

A=zeros(numberOfPlayers);

for i=1:lengthN
    for k=1:numberOfPlayers
        k2=int2str(k);
        eval(['A(' k2 ',:)=P' k2 '(NoiseLevel(1,i),NoiseLevel(2,i),:);']);
    end
    
    A=sum(A')/NumberOfTurns/length(listOfPlayers);
    
    subplot(lengthN,1,i)
    bar(A);
    grid ON;
            set(gca,'XTick',1:1:numberOfPlayers)
        set(gca,'XTickLabel',listOfPlayers)
        set(gca,'YLim',[max((min(A)-0.5),0) min((max(A)+0.5),5)],'Layer','top') 
    title(['Plot with noise ',num2str(Noise(1,NoiseLevel(1,i))),' and ', num2str(Noise(2,NoiseLevel(2,i)))]);
    xlabel('Players')
    ylabel('Average profit')
 
end


%% ------------------------------------------------------------------------
% Plot statistics for a given player

% Inputs: 
position=[1];     % Numbers of the players (hint: type Names to see which player has which number)
NoiseLevel = [1   ;...     % Noise Level 1
              1  ];        % Noise Level 2

% Calc:

lengthVector = length(position);

[x, lengthN] = size(NoiseLevel); 

A=Rewardmatrix(position,:,:,:)./NumberOfTurns;

for k=1:length(position)
    for i=1:lengthN
        A=Rewardmatrix(k,:,NoiseLevel(1,i),NoiseLevel(2,i))/NumberOfTurns;
        subplot(length(position),lengthN,i+(k-1)*lengthN)
        bar((1:1:numberOfPlayers)', A);
        grid ON;
        set(gca,'XTick',1:1:numberOfPlayers)
        set(gca,'XTickLabel',listOfPlayers)
        set(gca,'YLim',[max((min(A)-0.5),0) min((max(A)+0.5),5)],'Layer','top') 
        title(['Plot with noise ',num2str(Noise(1,NoiseLevel(1,i))),' and ', num2str(Noise(2,NoiseLevel(2,i)))]);
        xlabel('Players')
        ylabel('Average profit')
        xticklabel_rotate([],90,listOfPlayers)
    end


end
hold off;



%% ------------------------------------------------------------------------
clear i k Reward position
position=zeros(size(Noise,2)^2,numberOfPlayers);

for i=1:size(Noise,2)
   for k=1:size(Noise,2)
       Reward(i,k)=max(sum(Rewardmatrix(:,:,i,k)'))/(NumberOfTurns*numberOfPlayers);
       position(k+(i-1)*size(Noise,2),find(Reward(i,k)*(NumberOfTurns*numberOfPlayers)==sum(Rewardmatrix(:,:,i,k)')))=1;
   end
end

imagesc(0:1:size(Noise,2)-1,0:1:size(Noise,2)-1,Reward)
set(gca,'XTick',0:1:size(Noise,2))
set(gca,'YTick',0:1:size(Noise,2))
set(gca,'XTickLabel',Noise(1,:))
set(gca,'YTickLabel',Noise(2,:))

for i=1:size(Noise,2)
    for k=1:size(Noise,2)
        text(k-1,i-1,...
        [listOfPlayers{find(position(k+(i-1)*size(Noise,2),:)==1)} '\newline' num2str(Reward(i,k))],...
        'HorizontalAlignment','center');

       
       
   end
end

%% ------------------------------------------------------------------------
clear i k totalReward totalCoop

totalReward = zeros(size(Noise,2));
totalCoop = zeros(size(Noise,2));


    for k=1:numberOfPlayers
    
        for i=1:numberOfPlayers
            totalReward(:,:)=totalReward(:,:)+eval(['R' int2str(k) '(:,:,' int2str(i) ')'  ';']);
            
        end
            for l=1:size(Noise,2)
                for j=1:size(Noise,2)
                    totalCoopP(l,j,k)=mean(eval(['C' int2str(k) '(l,j,:)'  ';']));
                end
            end
    end
    
    for l=1:size(Noise,2)
        for j=1:size(Noise,2)
            totalCoop(l,j)=mean(totalCoopP(l,j,:));
        end
    end


totalReward = totalReward/(numberOfPlayers*NumberOfTurns*numberOfPlayers)
totalCoop
