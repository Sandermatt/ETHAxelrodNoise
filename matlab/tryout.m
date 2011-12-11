% 2 given Players agains each other 

% Clear used Variables:
clear players shortTemp

% Inputs:
player = [4 4 ;...               % player 1
          1 2] ;                % player 2

      
% Calc:
players = size(player,2);         % number of faceoffs
tempRewardMatrix = zeros(lengthOfNoise^2,2,players);    % create temporary rewardmatrix(noiselevel,2,faceoff)


for l = 1:players                 % create rewardmatrix
    for i = 1:lengthOfNoise
        for k = 1:lengthOfNoise
            tempRewardMatrix(k+(i-1)*lengthOfNoise,1,l) = eval(['R' int2str(player(1,l)) '(' int2str(i) ',' int2str(k) ',' int2str(player(2,l)) ');'])/numberOfTurns; 
            tempRewardMatrix(k+(i-1)*lengthOfNoise,2,l) = eval(['R' int2str(player(2,l)) '(' int2str(i) ',' int2str(k) ',' int2str(player(1,l)) ');'])/numberOfTurns;
        end
    end
end

for l = 1:players               % iterate over faceoffs
    h = figure(l+figureCounter);                              % initialize figure
    set(h,'NumberTitle','off')
    set(h,'Position',[10 500 1000 900])         % position and size of figure
    set(h,'Name',['"' listOfPlayers{player(1,l)} '" against "' listOfPlayers{player(2,l)} ' and vice versa'])  % set title of figure
    for i = 1:lengthOfNoise
        for k = 1:lengthOfNoise
            subplot(lengthOfNoise, lengthOfNoise, k+(i-1)*lengthOfNoise)
            bar(tempRewardMatrix(k+(i-1)*lengthOfNoise,:,l))
            grid ON;                    
            set(gca,'XTick',1:1:2)
            shortTemp{1} = short{player(1,l)};
            shortTemp{2} = short{player(2,l)};
            set(gca,'XTickLabel',shortTemp,'FontSize',8)
            set(gca,'XLim',[0 3])
            set(gca,'YLim',[max((min(tempRewardMatrix(k+(i-1)*lengthOfNoise,:,l))-0.25),0) min((max(tempRewardMatrix(k+(i-1)*lengthOfNoise,:,l))+0.25),5)])         
            title(['Noiseplot with Noiselevel 1: ',num2str(noise(1,k)),' and Noiselevel 2: ', num2str(noise(1,i)),],'FontWeight','bold','FontSize',12);
            xlabel('Opponents','FontWeight','bold','FontSize',10)
            ylabel(['Cooperation of Player "' listOfPlayers{position(i)} '"'],'FontWeight','bold','FontSize',8)
        end
    end    
end
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      