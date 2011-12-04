filename = 'simulation.mat';

NoiseLevel = [1 2 1 2;...     % Noise Level 1
              1 2 2 1 ];        % Noise Level 2



vars=load(filename);

Rewardmatrix = vars.Rewardmatrix;
NumberOfTurns = vars.N;
listOfPlayers = vars.list;
Noise = vars.Noise;

[x, lengthN] = size(NoiseLevel);

for i=1:lengthN
    A=Rewardmatrix(:,:,NoiseLevel(1,i),NoiseLevel(2,i));
    A=sum(A)/NumberOfTurns/length(listOfPlayers);
    subplot(lengthN,1,i)
    bar(A);
    grid ON;
    title(['plot with noise ',num2str(Noise(1,NoiseLevel(1,i))),' and ', num2str(Noise(2,NoiseLevel(2,i)))]);
    
end


